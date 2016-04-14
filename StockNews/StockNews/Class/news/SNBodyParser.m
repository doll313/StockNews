//
//  SNBodyParser.m
//  IosDemo
//
//  Created by MengWang on 16/3/28.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNBodyParser.h"
#import <SBModule/NSData+SBMODULE.h>
#import <SBBusiness/SNJSONNODE.h>
#import <SBBusiness/SBTimeManager.h>
#import <SBModule/MGTemplateEngine.h>
#import <SBModule/ICUTemplateMatcher.h>

#define JSON_MAIN_NODE_NEWS_CONTENT                   @"news"            //资讯正文信息
#define JSON_MAIN_NODE_DIGEST_CONTENT                 @"digest"          //直播正文信息
#define JSON_MAIN_NODE_GUBA_LIST                      @"guba"            //资讯对应的股吧信息

#define JSON_NODE_IMAGES                              @"images"          //图片
#define JSON_NODE_LINKS                               @"links"           //链接
#define JSON_NODE_RELATEDNEWS                         @"relatedNewsArr"  //链接

#define __SN_NOUSE_URL @"(<a href=\"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%#|_\\./-~-]*)?\"><!--IMG)"           //去掉没用的url
#define __SN_REGEX_IMG_TAG     @"((<!-- ?EM_StockImg_Start ?-->.*?<!-- ?EM_StockImg_End ?-->)|(<!-- ?IMG#\\d+ ?-->))"


@interface SNBodyParser()

@end

@implementation SNBodyParser

// 解析资讯正文接口
+ (DataItemResult *)parserBodyData:(NSData *)rawData {
    DataItemResult *result = [[DataItemResult alloc] init];
    
    // 是否数据为空
    id jsonDict = [rawData sb_objectFromJSONData];
    if (jsonDict == nil) {
        result.hasError = YES;
        result.message = @"数据加载失败!";
        result.rawData = rawData;
        return result;
    }
    
    // 字典数据
    NSDictionary *dataDict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)jsonDict];
    if (!dataDict) {
        result.hasError = YES;
        result.message = @"数据加载失败!";
        result.rawData = rawData;
        return result;
    }
    
    // 组合数据
    for (NSString *dictKey in dataDict.allKeys) {
        id dictValue = dataDict[dictKey];
        if ([dictKey isEqualToString:@"me"]) {
            result.message = dictValue;
        } else if([dictKey isEqualToString:@"rc"]) {
            BOOL hasError = ([(NSNumber *)dictValue integerValue] == 0);
            result.hasError = hasError;
            if (hasError) {
                return result;
            }
        }
    }
    
    // 资讯
    id contentValue = dataDict[JSON_MAIN_NODE_NEWS_CONTENT];
    if(!contentValue || [contentValue isKindOfClass:[NSNull class]]) {
        contentValue = dataDict[JSON_MAIN_NODE_DIGEST_CONTENT];
    }
    
    if (contentValue && ![contentValue isKindOfClass:[NSNull class]]) {
        NSDictionary *resultDict = [NSDictionary dictionaryWithDictionary:contentValue];
        if (!resultDict || [resultDict isKindOfClass:[NSNull class]]) {
            return result;
        }
        for (NSString *resultKey in resultDict.allKeys) {
            id resultValue = resultDict[resultKey];
            if (resultValue && ![resultValue isKindOfClass:[NSNull class]]) {
                if ([resultKey isEqualToString:JSON_NODE_IMAGES] ||
                    [resultKey isEqualToString:JSON_NODE_LINKS]  ||
                    [resultKey isEqualToString:JSON_NODE_RELATEDNEWS]) {
                    if ([resultValue isKindOfClass:[NSArray class]]) {
                        NSArray *array = [NSArray arrayWithArray:resultValue];
                        NSMutableArray *replaceArray = [NSMutableArray array];
                        for (NSDictionary *subDict in array) {
                            DataItemDetail *itemDetail = [DataItemDetail detailFromDictionary:subDict];
                            [replaceArray addObject:itemDetail];
                        }
                        [result.resultInfo setObject:replaceArray forKey:resultKey];
                    }
                }
                
                // 其他数据
                else {
                    [result.resultInfo setObject:resultValue forKey:resultKey];
                }
            }
        }
    }
    
    // 股吧数据
    id gubaValue = dataDict[JSON_MAIN_NODE_GUBA_LIST];
    if (gubaValue && ![gubaValue isKindOfClass:[NSNull class]]) {
        NSDictionary *gubaDict = [NSDictionary dictionaryWithDictionary:gubaValue];
        [gubaDict.allKeys enumerateObjectsUsingBlock:^(NSString *dictKey, NSUInteger idx, BOOL * _Nonnull stop) {
            id dictValue = gubaDict[dictKey];
            if (dictValue && ![dictValue isKindOfClass:[NSNull class]]) {
                if ([dictKey isEqualToString:@"re"]) {
                    NSArray *resultArray = [NSArray arrayWithArray:dictValue];
                    
                    for (NSDictionary *resultDic in resultArray) {
                        DataItemDetail *detail = [DataItemDetail detailFromDictionary:resultDic];
                        [result addItem:detail];
                    }
                }
                else {
                    result.resultInfo.dictData[dictKey] = dictValue;
                }
            }
        }];
    }
    
    // 分享
    id shareUrl = dataDict[SN_SUMMARY_LIST_SHAREURL];
    if (shareUrl && [shareUrl isKindOfClass:[NSString class]]) {
        [result.resultInfo setObject:shareUrl forKey:SN_SUMMARY_LIST_SHAREURL];
    }
    
    return result;
}

// 最终生成模板的html字段
+ (void)generateNewsHTML:(DataItemResult *)result onFinished:(void(^)(NSString *resultStr))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!result) {
            if (callback) {
                callback(@"");
            }
            return;
        }
        DataItemDetail *contentDetail = result.resultInfo;
        
        NSString *showTime = [contentDetail getString:@"showtime"];
        showTime = [SBTimeManager sb_formatStr:showTime preFormat:@"yyyy-MM-dd HH:mm:ss" newFormat:@"MM-dd HH:mm"];
        if (showTime.length > 0) {
            [contentDetail setString:showTime forKey:@"showtime"];
        }
        
        //去除图片点击没用的url
        [self generateWipeOffNoUseUrl:result];
        //解析图片 替换html
        [SNBodyParser generateImages:result];
        //相关股票解析
        [SNBodyParser generateRelatedStocks:result];
        //屏蔽info
        [SNBodyParser generateInfo:result];
        //其他链接
        [SNBodyParser generateOtherLink:result];
        //处理相关新闻的链接
        [SNBodyParser generateRelatedNewsLink:result];
        
        
        NSString *titleStr = [result.resultInfo getString:@"title"];
        if (titleStr.length == 0) {
            NSString *simTitle = [result.resultInfo getString:@"simtitle"];
            [result.resultInfo setString:simTitle forKey:@"title"];
        }
        
        NSMutableDictionary *contentDict = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *sbInfoData = result.resultInfo.dictData;
        NSString *source = sbInfoData[@"source"];
        if (source && source.length > 0) {
            [sbInfoData setValue:[NSString stringWithFormat:@"来源:%@",source] forKey:@"source"];
        }
        if ((titleStr.length > 0)) {
            sbInfoData[@"title"] = titleStr;
        }
        contentDict[@"newsContentDict"] = sbInfoData;
        if (source && source.length > 0) {
            [contentDict setValue:[NSString stringWithFormat:@"来源:%@",source] forKey:@"source"];
        }
        
        // 模板引擎
        MGTemplateEngine *templateEngine = [MGTemplateEngine templateEngine];
        [templateEngine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:templateEngine]];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SNBodyTemplate" ofType:@"html"];
        NSString *resultStr = [templateEngine processTemplateInFileAtPath:path withVariables:contentDict];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback) {
                callback(resultStr);
            }
        });
    });
}

#pragma mark 去除图片点击没用的url

+(void)generateWipeOffNoUseUrl:(DataItemResult *)result {
    DataItemDetail *contentDetail = result.resultInfo;
    
    NSArray *images = [contentDetail getArray:JSON_NODE_IMAGES];
    NSString *body = [contentDetail getString:@"body"];
    
    if (images.count == 0) {
        return;
    }

    NSMutableString *modifBody = [[NSMutableString alloc] initWithString:body];
    if (modifBody.length == 0) {
        return;
    }
    
    // 图片约定的格式
    if ([modifBody contains:@"<!--IMG#"]) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:__SN_NOUSE_URL options:0 error:nil];
        NSInteger i = 0;
        NSRange nextRange = NSMakeRange(0, modifBody.length);
        NSTextCheckingResult *res = nil;
        
        do {
            res = [regex firstMatchInString:modifBody options:0 range:nextRange];
            
            if (res && res.range.location != NSNotFound) {
                if (i >= images.count) {
                    break;
                }
                NSString *replacingString = @"<a><!--IMG";
                [modifBody replaceCharactersInRange:res.range withString:replacingString];
                nextRange.location = res.range.location + replacingString.length;
                nextRange.length = modifBody.length - nextRange.location;
                i++;
            }
        }while (res && res.range.location != NSNotFound);
    }
    [contentDetail setString:modifBody forKey:@"body"];
}

+ (void)generateImages:(DataItemResult *)result {
    DataItemDetail *contentDetail = result.resultInfo;
    
    NSArray *images = [contentDetail getArray:JSON_NODE_IMAGES];
    NSString *body = [contentDetail getString:@"body"];
    
    if (images.count == 0) {
        return;
    }
    
    NSMutableString *modifBody = [[NSMutableString alloc] initWithString:body];
    if (modifBody.length == 0) {
        return;
    }
    
    if ([modifBody contains:@"<!--IMG#"]) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:__SN_REGEX_IMG_TAG options:0 error:nil];
        NSInteger i = 0;
        NSRange nextRange = NSMakeRange(0, modifBody.length);
        NSTextCheckingResult *res = nil;
        
        do {
            res = [regex firstMatchInString:modifBody options:0 range:nextRange];
            if (res && res.range.location != NSNotFound) {
                if (i >= images.count) {
                    break;
                }
                
                NSString *rangeString = [modifBody substringWithRange:res.range];
                NSString *replacingString = @"";
                BOOL isStockImage = NO;
                if ([rangeString contains:@"EmImageRemark"]) {
                    isStockImage = YES;
                }
                
                DataItemDetail *imageDetail = images[i];
                
                NSString *src = [imageDetail getString:@"src"];
                NSInteger width = [imageDetail getInt:@"width"];
                NSInteger height = [imageDetail getInt:@"height"];
                if (isStockImage) {
                    [imageDetail setString:[NSString stringWithFormat:@"%ld", i] forKey:@"isStockImage"];
                }
                
                if (width == 0) {
                    width = 4;
                    height = 3;
                }
                
                NSString *base64String = @"";
                // 默认灰色背景色图片
                UIImage *placeImage = [UIImage imageWithColor:[UIColor grayColor]];
                if (placeImage && placeImage.size.width > 0) {
                    NSData *placeImageData = UIImagePNGRepresentation(placeImage);
                    if (placeImageData && placeImageData.length > 0) {
                        base64String = [placeImageData base64EncodedString];
                        if (!(base64String && base64String.length > 0)) {
                            base64String = @"";
                        }
                    }
                }
                
                //普通图片
                NSString *artImageDiv = @"<div class=\"art-img\">";
                //行情图片
                NSString *stkImageDiv = @"<div class=\"art-img stk-img\">";
                //图片信息
                NSString *imageIdDiv = [NSString stringWithFormat:@"<div id = \"image_ph_%ld\" class=\"image-placeholder-wrap\" target-url=\"%@\" origin-width=\"%d\" origin-height=\"%d\">", i, src, (int)width, (int)height];
                //图片信息(默认灰色背景图片)
                NSString *placeHolderDiv = [NSString stringWithFormat:@"<img class=\"placeholder\" src=\"data:image/png;base64,%@\" height=\"250px\" target-url=\"%@\" onclick = \"loadImage('%@')\"/>",base64String,src,src];
                
                NSString *tipshowSpan = @"<span class=\"tip show\"></span>";
                //点击查看详情
                NSString *viewStockA = [NSString stringWithFormat:@"<a class=\"link-stkd\" href=\"/viewstock_%ld\">点击查看行情</a>", i];
                
                NSString *divDiv = @"</div>";
                
                //是行情图片
                if (isStockImage) {
                    replacingString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", stkImageDiv, imageIdDiv, placeHolderDiv,tipshowSpan, divDiv,viewStockA, divDiv];
                } else {
                    replacingString = [NSString stringWithFormat:@"%@%@%@%@%@%@", artImageDiv, imageIdDiv, placeHolderDiv,tipshowSpan, divDiv, divDiv];
                }
                
                //把这段替换掉
                [modifBody replaceCharactersInRange:res.range withString:replacingString];
                //开始下一个正则
                nextRange.location = res.range.location + replacingString.length;
                nextRange.length = modifBody.length - nextRange.location;
                i++;
            }
            
        } while (res && res.range.location != NSNotFound);
    }
    
    [contentDetail setString:modifBody forKey:@"body"];
}

//相关股票
+ (void)generateRelatedStocks:(DataItemResult *)result {
    //网络数据包
    DataItemDetail *contentDetail = result.resultInfo;
    if (!contentDetail) {
        return;
    }
    
    NSString *body = [contentDetail getString:@"body"];
    
    //替换后的html
    NSMutableString *modifiedBody = [[NSMutableString alloc] initWithString:body];
    if (modifiedBody.length == 0) {
        return;
    }
    
    //link占位符配置
    NSArray *links = [contentDetail getArray:JSON_NODE_LINKS];
    
    //相关股票
    NSMutableArray *relatedStocks = [[NSMutableArray alloc] init];
    
    //先处理个股的，这部分需要做js上的特殊处理  stock_     bk_      info_      ...
    NSString *pattern = @"<span id=\"(stock|bk)_(.*?)\"><!--Link#(\\d*)--></span>";
    //正则
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    //游标
    int i = 0;
    NSRange nextRange = NSMakeRange(0, modifiedBody.length);
    NSTextCheckingResult *checkResult = nil;
    
    //循环正则
    do {
        @autoreleasepool {
            checkResult = [regex firstMatchInString:modifiedBody options:0 range:nextRange];
            if(checkResult && checkResult.range.location != NSNotFound){
                if (i >= links.count) {
                    break;
                }
                
                //替换
                NSString *replacingString = @"";
                
                //e.g. stock_6007171  bk_0417  info_12313  ..
                //股票类型
                NSRange typeRange = [checkResult rangeAtIndex:1];
                NSString *aType = [modifiedBody substringWithRange:typeRange];
                
                //股票文字范围
                NSRange stockRange = [checkResult rangeAtIndex:2];
                NSString *nCode = [modifiedBody substringWithRange:stockRange];
                NSString *fullCode = [NSString stringWithString:nCode];
                
                //股票全码
                if ([aType isEqualToString:@"stock"]) {
                    fullCode = [SNBodyParser newsCodeToMarketCode:nCode];
                } else if ([aType isEqualToString:@"bk"]) {
                    fullCode = [SNBodyParser newsCodeToBkCode:nCode];
                } else{
                }
                
                //占位符位置
                NSRange linkRange = [checkResult rangeAtIndex:3];
                NSString *linkNumber = [modifiedBody substringWithRange:linkRange];
                NSUInteger linkInt = [linkNumber intValue];
                
                //从接口中找出占位信息
                DataItemDetail *linkDetail = links[linkInt];
                NSString *stockName = [linkDetail getString:@"text"];
                
                NSString *url_m = [linkDetail getString:@"url_m"];
                if (url_m.length == 0) {
                    //pc网页
                    url_m = [linkDetail getString:@"url_w"];
                }
                if(url_m.length == 0){
                    url_m = @"";
                }
                
                //股票代码不为空
                if (nCode.length > 0) {
                    //去重
                    BOOL needAdd = YES;
                    for(NSDictionary *dic in relatedStocks){
                        if([[dic valueForKey:@"fullCode"] isEqualToString:fullCode]){
                            needAdd = NO;
                        }
                    }
                    
                    if (relatedStocks.count <= 6 && needAdd) {
                        [relatedStocks addObject:@{@"fullCode":fullCode,@"stockUrl":url_m, @"stockName":stockName}];
                    }
                    
                    //生成短链
                    replacingString = [NSString stringWithFormat:@"<a class=\"content-link\" href=\"/relatedstock_%@_%@\">%@</a>", fullCode, url_m, stockName];
                }
                
                //替换原有的字符串
                [modifiedBody replaceCharactersInRange:checkResult.range withString:replacingString];
                nextRange.location = checkResult.range.location + replacingString.length;
                nextRange.length = modifiedBody.length - nextRange.location;
                i++;
            }
        }
        
        
    } while (checkResult && checkResult.range.location != NSNotFound);
    
    [contentDetail setString:modifiedBody forKey:@"body"];
    [contentDetail setInt:relatedStocks.count forKey:@"relatedstockscount"];
    [contentDetail setArray:relatedStocks forKey:@"relatedstocks"];
}

#pragma mark
#pragma mark 私有方法
/**
 转换资讯中的不规范的股票代码写法
 @return fullCode 全码
 */
+ (NSString *)newsCodeToMarketCode:(NSString *)newsCode {
    NSString *nCode = [NSString stringWithString:newsCode];
    if(nCode.length == 0){
        return nCode;
    }
    //实际有用的code
    NSString *realCode = [nCode substringToIndex:nCode.length-1];
    NSUInteger _aLength = nCode.length;
    unichar c = [nCode characterAtIndex:nCode.length-1];
    
    //保证长度 7 以2或1结尾 港股是6位，以5结尾的
    if (_aLength != 7&&_aLength != 6) {
        return nCode;
    }
    
    NSString *marketPrefix = nil;
    if (c == '2') {
        //深
        marketPrefix = @"SZ";
    }else if(c == '1'){
        //沪
        marketPrefix = @"SH";
    }else if (c == '5'){
        //港股
        marketPrefix = @"HK|";
    }
    
    if (marketPrefix) {
        return [NSString stringWithFormat:@"%@%@",marketPrefix, realCode];
    } else {
        return nCode;
    }
}

/**
 转换资讯中的不规范的板块代码写法
 @return fullCode 全码
 */
+ (NSString *)newsCodeToBkCode:(NSString *)newsCode {
    NSString *nCode = [NSString stringWithString:newsCode];
    //保证长度 7 以2或1结尾
    if (nCode.length != 3) {
        return nCode;
    }
    
    return [NSString stringWithFormat:@"BI0%@", nCode];
}

//一些info 屏蔽掉
+ (void)generateInfo:(DataItemResult *)result {
    //网络数据包
    DataItemDetail *contentDetail = result.resultInfo;
    
    NSString *body = [contentDetail getString:@"body"];
    
    //替换后的html
    NSMutableString *modifiedBody = [[NSMutableString alloc] initWithString:body];
    if (modifiedBody.length == 0) {
        return;
    }
    
    //link占位符配置
    NSArray *links = [contentDetail getArray:JSON_NODE_LINKS];
    
    //屏蔽Info.
    NSString *pattern = @"<span id=\"(Info..*?)\"><!--Link#(\\d*)--></span>";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    int i = 0;
    NSRange nextRange = NSMakeRange(0, modifiedBody.length);
    NSTextCheckingResult *checkResult = nil;
    
    do {
        @autoreleasepool {
            checkResult = [regex firstMatchInString:modifiedBody options:0 range:nextRange];
            if(checkResult && checkResult.range.location != NSNotFound){
                if (i >= links.count) {
                    break;
                }
                
                //第一个匹配区间
                NSRange range1 = [checkResult rangeAtIndex:1];
                NSString *infoStr1 = [modifiedBody substringWithRange:range1];
                
                //占位数
                NSUInteger link = 0;
                
                NSString *replacingString = @"";
                //是否Info开头
                if ([infoStr1 hasPrefix:@"Info"]) {
                    //第二个匹配区间
                    NSRange range2 = [checkResult rangeAtIndex:2];
                    NSString *infoStr2 = [modifiedBody substringWithRange:range2];
                    link = [infoStr2 intValue];
                    
                    //替换占位符的字符串
                    DataItemDetail *linkDetail = links[link];
                    replacingString = [linkDetail getString:@"text"];
                }
                
                [modifiedBody replaceCharactersInRange:checkResult.range withString:replacingString];
                nextRange.location = checkResult.range.location + replacingString.length;
                nextRange.length = modifiedBody.length - nextRange.location;
                i++;
            }
        }
    } while (checkResult && checkResult.range.location != NSNotFound);
    
    [contentDetail setString:modifiedBody forKey:@"body"];
}

//相关股票
+ (void)generateOtherLink:(DataItemResult *)result {
    
    //网络数据包
    DataItemDetail *contentDetail = result.resultInfo;
    
    NSString *body = [contentDetail getString:@"body"];
    
    //替换后的html
    NSMutableString *modifiedBody = [[NSMutableString alloc] initWithString:body];
    if (modifiedBody.length == 0) {
        return;
    }
    
    //link占位符配置
    NSArray *links = [contentDetail getArray:JSON_NODE_LINKS];
    
    //屏蔽Info.
    NSString *pattern = @"<!--Link#(\\d*)-->";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    int i = 0;
    NSRange nextRange = NSMakeRange(0, modifiedBody.length);
    NSTextCheckingResult *checkResult = nil;
    
    do {
        @autoreleasepool {
            checkResult = [regex firstMatchInString:modifiedBody options:0 range:nextRange];
            if(checkResult && checkResult.range.location != NSNotFound){
                if (i >= links.count) {
                    break;
                }
                
                //占位符区间
                NSRange linkRange = [checkResult rangeAtIndex:1];
                NSString *linkStr = [modifiedBody substringWithRange:linkRange];
                int linkIndex = [linkStr intValue];
                
                DataItemDetail *linkDetail = links[linkIndex];
                //替换占位符的字符串
                NSString *replacingString  = [linkDetail getString:@"text"];
                //手机网页
                NSString *url_m = [linkDetail getString:@"url_m"];
                
                NSString *snStyle = [linkDetail getString:@"style"];
                
                if (url_m.length == 0) {
                    //pc网页
                    url_m = [linkDetail getString:@"url_w"];
                }
                
                if (url_m.length > 0) {
                    //生成短链
                    replacingString = [NSString stringWithFormat:@"<a class=\"content-link\" href=\"/contentlink_%d\" style=\"%@\">%@</a>", linkIndex,snStyle, replacingString];
                }
                
                [modifiedBody replaceCharactersInRange:checkResult.range withString:replacingString];
                nextRange.location = checkResult.range.location + replacingString.length;
                nextRange.length = modifiedBody.length - nextRange.location;
                i++;
            }
        }
    } while (checkResult && checkResult.range.location != NSNotFound);
    
    [contentDetail setString:modifiedBody forKey:@"body"];
}

//获取图片信息
+ (NSArray *)generateBodyImages:(DataItemResult *)result {
    //网络数据包
    DataItemDetail *contentDetail = result.resultInfo;
    
    //图片解析
    NSArray *images = [contentDetail getArray:JSON_NODE_IMAGES];
    return images;
}

#pragma mark 处理相关新闻
+ (void)generateRelatedNewsLink:(DataItemResult *)result {
    //网络数据包
    DataItemDetail *contentDetail = result.resultInfo;
    NSArray *relatedNews = [contentDetail getArray:JSON_NODE_RELATEDNEWS];
    if(relatedNews.count == 0){
        return;
    }
    NSString *relatedStr = @"<div id=\"xgnewst\">相关新闻</div>";
    relatedStr = [relatedStr stringByAppendingString:@"<ul>"];
    for(int i=0;i<relatedNews.count;i++){
        DataItemDetail *detail = relatedNews[i];
        NSString *title = [detail getString:@"title"];
        NSString *url_m = [detail getString:@"url_m"];
        if(url_m.length == 0){
            url_m = [detail getString:@"url_w"];
        }
        relatedStr = [NSString stringWithFormat:@"%@<li><a href=\"%@\" id=\"xgnewsta\">%@</a></li>",relatedStr,url_m,title];
    }
    relatedStr = [relatedStr stringByAppendingString:@"</ul>"];
    [contentDetail setString:relatedStr forKey:@"relateNewsStr"];
}

@end
