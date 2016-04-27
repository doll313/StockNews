//
//  SNNewsManager.m
//  StockNews
//
//  Created by MengWang on 16/4/27.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNNewsManager.h"
#import "SBArticleListCell.h"
#import "SNLiveCell.h"
#import "SNYWCell.h"
#import "SNStockStatusCell.h"

@interface SNNewsManager()
@property (nonatomic, copy)NSString *titleName;
@end

@implementation SNNewsManager

- (id)initWithTitleName:(NSString *)titleName {
    self = [super init];
    if (self) {
        self.titleName = titleName;
        self.hasHeaderView = NO;
        [self initialParams];
    }
    return self;
}

- (void)initialParams {
    if ([self.titleName isEqualToString:@"要闻"]) {
        self.channelName = @"ywjh";
        self.column = @"";
        self.dataClass = [SNYWCell class];
        self.dataKey = @"kCacheKeyStockNewsImportNewsKey";
    } else if([self.titleName isEqualToString:@"直播"]) {
        self.channelName = @"zhibo";
        self.column = @"";
        self.dataClass = [SNLiveCell class];
        self.hasHeaderView = YES;
        self.dataKey = @"kCacheKeyStockNewsLiveKey";
    } else if([self.titleName isEqualToString:@"个股"]) {
        self.channelName = @"ggdj";
        self.column = @"";
        self.dataClass = [SNStockStatusCell class];
        self.dataKey = @"kCacheKeyStockNewsStockKey";
    } else if([self.titleName isEqualToString:@"看盘"]) {
        self.channelName = @"";
        self.column = @"";
        self.dataClass = [SBArticleListCell class];
        self.dataKey = @"kCacheKeyStockNewsArticleKey";
    } else if([self.titleName isEqualToString:@"滚动"]) {
        self.channelName = @"";
        self.column = @"102";
        self.dataClass = [SNLiveCell class];
        self.dataKey = @"kCacheKeyStockNewsScrollKey";
        self.cellStyle = @"digestStyle";
        self.hasHeaderView = YES;
    } else if([self.titleName isEqualToString:@"公司"]) {
        self.channelName = @"";
        self.column = @"103";
        self.dataClass = [SNLiveCell class];
        self.dataKey = @"kCacheKeyStockNewsCompanyKey";
        self.cellStyle = @"digestStyle";
        self.hasHeaderView = YES;
    } else if([self.titleName isEqualToString:@"基金"]) {
        self.channelName = @"";
        self.column = @"109";
        self.dataClass = [SNLiveCell class];
        self.dataKey = @"kCacheKeyStockNewsFundKey";
        self.cellStyle = @"digestStyle";
        self.hasHeaderView = YES;
    } else if([self.titleName isEqualToString:@"股市播报"]) {
        self.channelName = @"gszb";
        self.column = @"";
        self.dataClass = [SNStockStatusCell class];
        self.dataKey = @"kCacheKeyStockNewsBroadCastKey";
    } else if([self.titleName isEqualToString:@"大盘"]) {
        self.channelName = @"dpfx";
        self.column = @"";
        self.dataClass = [SNStockStatusCell class];
        self.dataKey = @"kCacheKeyStockNewsMarketKey";
    } else if([self.titleName isEqualToString:@"交易提示"]) {
        self.channelName = @"jyts";
        self.column = @"";
        self.dataClass = [SNStockStatusCell class];
        self.dataKey = @"kCacheKeyStockNewsTradingTipsKey";
    } else if([self.titleName isEqualToString:@"产经新闻"]) {
        self.channelName = @"cjxw";
        self.column = @"";
        self.dataClass = [SNStockStatusCell class];
        self.dataKey = @"kCacheKeyStockNewsNewsKey";
    } else if([self.titleName isEqualToString:@"报刊头条"]) {
        self.channelName = @"bktt";
        self.column = @"";
        self.dataClass = [SNStockStatusCell class];
        self.dataKey = @"kCacheKeyStockNewsNewsPaperKey";
    } else if([self.titleName isEqualToString:@"美股要闻"]) {
        self.channelName = @"mgyw";
        self.column = @"";
        self.dataClass = [SNStockStatusCell class];
        self.dataKey = @"kCacheKeyStockNewsUSStockKey";
    } else if([self.titleName isEqualToString:@"全球股市"]) {
        self.channelName = @"";
        self.column = @"105";
        self.dataClass = [SNLiveCell class];
        self.dataKey = @"kCacheKeyStockNewsGlobalStockKey";
        self.cellStyle = @"digestStyle";
        self.hasHeaderView = YES;
    }
}

@end
