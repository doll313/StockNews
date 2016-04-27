//
//  SNNewsViewController.m
//  IosDemo
//
//  Created by MengWang on 16/3/18.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNNewsViewController.h"
#import "SNTagsView.h"
#import "SNYWViewController.h"
#import "SBArticleViewController.h"
#import "SNLiveViewController.h"
#import "SNStockStatusViewController.h"

@interface SNNewsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)NSArray *channelList;    // 频道号列表
@property (nonatomic, strong)SNTagsView *tagsView;
@property (nonatomic, strong)UIScrollView *pageScrollView;
@end

@implementation SNNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"stock_navi_bg_128"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stock_navigation_back"] highlightedImage:[UIImage imageNamed:@"stock_navigation_back"]]];
    self.navigationItem.backBarButtonItem.title = @"";
    
    self.channelList = @[@"要闻", @"直播", @"个股", @"看盘", @"滚动", @"公司", @"基金", @"股市播报", @"大盘", @"交易提示", @"产经新闻", @"报刊头条", @"美股要闻", @"全球股市"];
    
    [self initTagsView];
    [self addControllers];

    [self initPageScrollView];
    
    UIViewController *ctrl = [self.childViewControllers firstObject];
    [self.pageScrollView addSubview:ctrl.view];
    ctrl.view.frame = self.pageScrollView.frame;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tagsView.frame = CGRectMake(0, 0, self.view.width, 40);
    self.pageScrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

- (void)initTagsView {
    SBWS(__self);
    _tagsView = [[SNTagsView alloc] initWithChannelList:self.channelList];
    self.navigationItem.titleView = _tagsView;

    _tagsView.titleClick = ^(NSInteger tag) {
        CGFloat offsetX = tag * __self.pageScrollView.frame.size.width;
        CGFloat offsetY = __self.pageScrollView.contentOffset.y;
        CGPoint offset = CGPointMake(offsetX, offsetY);
        [__self.pageScrollView setContentOffset:offset animated:YES];
    };
}

- (void)initPageScrollView {
    _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_pageScrollView];
    
    CGFloat contentX = self.childViewControllers.count * self.view.width;
    self.pageScrollView.contentSize = CGSizeMake(contentX, 0);
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.pageScrollView.delegate = self;
}

- (void)addControllers {
    for (int i = 0; i < self.channelList.count; i++) {
        NSString *titleName = self.channelList[i];
        if ([titleName isEqualToString:@"要闻"]) {
            SNYWViewController *ctrl = [[SNYWViewController alloc] init];
            ctrl.channelName = @"ywjh";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"直播"]) {
            SNLiveViewController *ctrl = [[SNLiveViewController alloc] init];
            ctrl.channelName = @"zhibo";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"个股"]) {
            SNStockStatusViewController *ctrl = [[SNStockStatusViewController alloc] init];
            ctrl.channelName = @"ggdj";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"看盘"]) {
            SBArticleViewController *ctrl = [[SBArticleViewController alloc] init];
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"滚动"]) {
            SNLiveViewController *ctrl = [[SNLiveViewController alloc] init];
            ctrl.column = @"102";
            ctrl.cellStyle = @"digestStyle";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"公司"]) {
            SNLiveViewController *ctrl = [[SNLiveViewController alloc] init];
            ctrl.column = @"103";
            ctrl.cellStyle = @"digestStyle";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"基金"]) {
            SNLiveViewController *ctrl = [[SNLiveViewController alloc] init];
            ctrl.column = @"109";
            ctrl.cellStyle = @"digestStyle";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"股市播报"]) {
            SNStockStatusViewController *ctrl = [[SNStockStatusViewController alloc] init];
            ctrl.channelName = @"gszb";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"大盘"]) {
            SNStockStatusViewController *ctrl = [[SNStockStatusViewController alloc] init];
            ctrl.channelName = @"dpfx";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"交易提示"]) {
            SNStockStatusViewController *ctrl = [[SNStockStatusViewController alloc] init];
            ctrl.channelName = @"jyts";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"产经新闻"]) {
            SNStockStatusViewController *ctrl = [[SNStockStatusViewController alloc] init];
            ctrl.channelName = @"cjxw";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"报刊头条"]) {
            SNStockStatusViewController *ctrl = [[SNStockStatusViewController alloc] init];
            ctrl.channelName = @"bktt";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"美股要闻"]) {
            SNStockStatusViewController *ctrl = [[SNStockStatusViewController alloc] init];
            ctrl.channelName = @"mgyw";
            [self addChildViewController:ctrl];
        } else if([titleName isEqualToString:@"全球股市"]) {
            SNLiveViewController *ctrl = [[SNLiveViewController alloc] init];
            ctrl.column = @"105";
            ctrl.cellStyle = @"digestStyle";
            [self addChildViewController:ctrl];
        }
    }
}

#pragma mark scrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / self.pageScrollView.width;
    UIViewController *ctrl = self.childViewControllers[index];
    [self.tagsView titleAction:index];

    if (ctrl.view.superview) return;
    
    ctrl.view.frame = scrollView.bounds;
    [self.pageScrollView addSubview:ctrl.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
