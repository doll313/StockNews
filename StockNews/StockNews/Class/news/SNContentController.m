//
//  SNContentController.m
//  IosDemo
//
//  Created by MengWang on 16/3/28.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNContentController.h"
#import <SBBusiness/SNDataProcess.h>
#import "SNBodyParser.h"
#import "SBCommentView+Private.h"
#import <SBBusiness/SNJSONNODE.h>
#import "SNSyncImageOperation.h"
#import "SNAsyncImageOperation.h"
#import "SNImagePreviewView.h"
#import <SBModule/SBURLAction.h>

@interface SNContentController ()<SBHttpDataLoaderDelegate,UIWebViewDelegate,SBHttpTaskDelegate>
@property (nonatomic, strong)UIWebView *contentWebview;
@property (nonatomic, strong)SBHttpDataLoader *loader;
@property (nonatomic, strong)DataItemResult *result;
@property (nonatomic, strong)UIButton *commentBtn;
@property (nonatomic, strong)NSOperationQueue *queue;
@end

@implementation SNContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stock_navigation_back"] highlightedImage:[UIImage imageNamed:@"stock_navigation_back"]]];
    self.navigationItem.backBarButtonItem.title = @"";
    
    _queue = [[NSOperationQueue alloc] init];
    [_queue setMaxConcurrentOperationCount:2];
    
    DataItemDetail *detail = (DataItemDetail *)[self.urlAction objectForKey:@"detail"];
    self.loader = [SNDataProcess snget_news_content:[detail getString:__SN_BIGNEWS_LIST_NEWSID] newsType:[detail getInt:__SN_BIGNEWS_LIST_NEWSTYPE] delegate:self];

    _contentWebview = [[UIWebView alloc] initWithFrame:CGRectZero];
    _contentWebview.scalesPageToFit = YES;
    _contentWebview.delegate = self;
    [self.view addSubview:_contentWebview];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    _commentBtn.layer.cornerRadius = 5;
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _commentBtn.layer.masksToBounds = YES;
    _commentBtn.layer.borderWidth = 1;
    [_commentBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(enterCommentList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentBtn];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.contentWebview.frame = self.view.bounds;
    
    _commentBtn.frame = CGRectMake(self.view.width - 80, self.view.height - 80, 40, 40);
}

- (void)dealloc {
    [self.loader stopLoading];
    
    [self.queue cancelAllOperations];
}

- (void)enterCommentList:(id)sender {
    SBURLAction *action = [SBURLAction actionWithClassName:@"SBCommentController"];
    [action setObject:self.result.resultInfo forKey:@"detail"];
    [self sb_openCtrl:action];
}

#pragma mark SBHttpDataLoaderDelegate

- (void)dataLoader:(SBHttpDataLoader *)dataLoader onReceived:(DataItemResult *)result {
    if (self.loader == dataLoader) {
 
        DataItemResult *itemResult = [SNBodyParser parserBodyData:result.rawData];
        if (itemResult.hasError) {
            return;
        }
        
        self.result = itemResult;
        
        SBWS(__self);
        [SNBodyParser generateNewsHTML:itemResult onFinished:^(NSString *resultStr) {
            NSString *path = [[NSBundle mainBundle]pathForResource:@"SNBodyTemplate" ofType:@"html"];
            NSURL *fileURL = [NSURL fileURLWithPath:path];
            [__self.contentWebview loadHTMLString:resultStr baseURL:fileURL];
        }];
    }
}

#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 网页load完成之后，开始加载图片
    [self requestBodyImages];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 点击加载大图
    NSString *imageUrl = request.URL.absoluteString;
    // 解码
    imageUrl = [imageUrl sb_urlDecoding];

    if ([imageUrl contains:@"loadLargeImage"]) {
        [self loadLargeImage:imageUrl];
        return NO;
    }
    return YES;
}

// 加载大图
- (void)loadLargeImage:(NSString *)absoluteString {
    NSArray *array = [absoluteString componentsSeparatedByString:@"params="];
    if (array.count == 2) {
        NSString *dictString = array[1];
        NSDictionary *imageInfo = [dictString sb_objectFromJSONString];
        if (imageInfo) {
            NSString *src = imageInfo[@"src"];
            if (src.length > 0) {
                array = [src componentsSeparatedByString:@"base64,"];
                NSString *dataString = array[1];
                if (dataString.length > 0) {
                    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:dataString options:0];
                    UIImage *image = [[UIImage alloc] initWithData:imageData];
                    SNImagePreviewView *bigImage = [[SNImagePreviewView alloc] init];
                    [bigImage showBigImageView:image];
                }
            }
        }
    }
}

#pragma mark  下载图片

// 批量下载图片
- (void)requestBodyImages {
    NSArray *bodyImages = [SNBodyParser generateBodyImages:self.result];
    
    [bodyImages enumerateObjectsUsingBlock:^(DataItemDetail *imageDetail, NSUInteger idx, BOOL * _Nonnull stop) {
        [self requestBodyImage:imageDetail];
    }];
}

// 下载单张图片
- (void)requestBodyImage:(DataItemDetail *)imageDetail {
    NSString *imageSrc = [imageDetail getString:@"src"].trim;
    
    // 缓存TODO
    
    SNAsyncImageOperation *imageOperation = [[SNAsyncImageOperation alloc] initWithURL:imageSrc andDelegate:self];
    [self.queue addOperation:imageOperation];
}

#pragma mark 队列下载回调

/** onError 方法，在 SBHttpTask 请求出错时回调的方法 */
- (void)task:(SBHttpTask *)task onError:(NSError *)error {
    
}

/** onReceived 方法，在 SBHttpTask 数据加载完成后回调的方法 */
- (void)task:(SBHttpTask *)task onReceived:(NSData *)data {
    if (data.length > 0) {
        NSString *requestUrl = task.aURLString;
        [self cacheBodyImage:data withUrl:requestUrl];
    }
}

#pragma mark 与js交互

//获取缓存上的图片
- (BOOL)cacheBodyImage:(NSData *)imageData withUrl:(NSString *)requestURL {
    //图片数据
    NSArray *bodyImages = [SNBodyParser generateBodyImages:self.result];
    for (NSInteger i=0; i<bodyImages.count; i++) {
        DataItemDetail *imageDetail = bodyImages[i];
        NSString *src = [imageDetail getString:@"src"].trim;
        if ([src isEqualToString:requestURL]) {
            //缓存时效
            //更新图片 这边url传空，不会下载
            if (imageData.length > 0) {
                UIImage *image = [UIImage imageWithData:imageData];
                if(!image || image.size.width == 0){
                    return NO;
                }
                /**NSDATA base 64 转 nsstring*/
                NSString *base64String = [imageData base64EncodedString];
                if(!base64String || base64String.length == 0){
                    return NO;
                }
                
                NSString *isStockImage = [imageDetail getString:@"isStockImage"];   // 图片index
                //如果是行情图片,通过js的方式设置图片
                if(isStockImage.length>0){
                    NSInteger stockIndex = [isStockImage intValue];
                    NSString *jsStr = [NSString stringWithFormat:@"resetStockImage('%ld', '%@', 'data:image/png;base64,%@' ,'%ld');", i, @"", base64String ,stockIndex];
                    [self.contentWebview stringByEvaluatingJavaScriptFromString:jsStr];
                    return YES;
                }
                
                NSString *jsStr = [NSString stringWithFormat:@"resetImage('%ld', '%@', 'data:image/png;base64,%@');", i, @"", base64String];
                [self.contentWebview stringByEvaluatingJavaScriptFromString:jsStr];
                
                return YES;
            } else {
                return NO;
            }
        }
    }
    return NO;
}


@end
