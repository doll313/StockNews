//
//  SNNewsChildViewController.m
//  IosDemo
//
//  Created by MengWang on 16/3/21.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNNewsChildViewController.h"
#import "SNYWCell.h"
#import <SBBusiness/SNDataProcess.h>
#import "SBCommentView+Private.h"
#import "SNLiveCell.h"
#import "SNStockStatusCell.h"
#import <SBBusiness/SBV3Process.h>
#import "SBArticleListCell.h"
#import <SBModule/SBURLAction.h>

@interface SNNewsChildViewController ()
@property (nonatomic, strong)SBTableView *tableView;
@end

@implementation SNNewsChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)tableDidLoad {
    _tableView = [[SBTableView alloc] initWithStyle:NO];
    _tableView.isRefreshType = YES;
    _tableView.ctrl = self;
    _tableView.estimatedRowHeight = 80;
    [self.view addSubview:_tableView];
    
    SBWS(__self);
    self.tableView.requestData = ^(SBTableData *tableViewData) {
        NSString *minid = @"";
        if (tableViewData.pageAt > 1) {
            minid = [tableViewData.tableDataResult.resultInfo getString:@"MinID"];
        }

        NSString *channelName = @"";
        if (__self.channelNum == 0) {
            // 要闻
            channelName = @"ywjh";
        } else if(__self.channelNum == 1) {
            // 直播
            channelName = @"zhibo";
        } else if(__self.channelNum == 2) {
            // 个股
            channelName = @"ggdj";
        } else if(__self.channelNum == 3) {
            return [SBV3Process sbset_sepcial_blog_list:tableViewData.pageAt type:0 delegate:tableViewData];
        } else if(__self.channelNum == 4) {
            return [SNDataProcess snget_news_list:minid column:@"102" delegate:tableViewData];
        } else if(__self.channelNum == 5) {
            return [SNDataProcess snget_news_list:minid column:@"103" delegate:tableViewData];
        } else if(__self.channelNum == 6) {
            return [SNDataProcess snget_news_list:minid column:@"109" delegate:tableViewData];
        } else if(__self.channelNum == 7) {
            channelName = @"gszb";
        } else if(__self.channelNum == 8) {
            channelName = @"dpfx";
        } else if(__self.channelNum == 9) {
            channelName = @"jyts";
        } else if(__self.channelNum == 10) {
            channelName = @"cjxw";
        } else if(__self.channelNum == 11) {
            channelName = @"bktt";
        } else if(__self.channelNum == 12) {
            channelName = @"mgyw";
        } else if(__self.channelNum == 13) {
            return [SNDataProcess snget_news_list:minid column:@"105" delegate:tableViewData];
        }
        return [SNDataProcess snget_important_news_list:minid encode:channelName delegate:tableViewData];
    };
    
    self.tableView.receiveData= ^(SBTableView *tableView ,SBTableData *tableViewData, DataItemResult *result) {
        if (result.hasError) {
            return;
        }
        [tableViewData.tableDataResult appendItems:result];
    };
    
    self.tableView.didSelectRow = ^(SBTableView *tableView, NSIndexPath *indexPath) {
        SBURLAction *action = [SBURLAction actionWithClassName:@"SNContentController"];
        [action setObject:[tableView dataOfIndexPath:indexPath] forKey:@"detail"];
        [__self sb_openCtrl:action];
    };
    
    // 添加表格数据
    SBTableData *sectionData = [[SBTableData alloc] init];
    if (__self.channelNum == 0) {
        sectionData.mDataCellClass = [SNYWCell class];
    } else if(__self.channelNum == 1) {
        sectionData.mDataCellClass = [SNLiveCell class];
    } else if(__self.channelNum == 2) {
        sectionData.mDataCellClass = [SNStockStatusCell class];
    } else if(__self.channelNum == 3) {
        sectionData.mDataCellClass = [SBArticleListCell class];
    } else if(__self.channelNum == 4) {
        sectionData.mDataCellClass = [SNLiveCell class];
        [sectionData.tableDataResult.resultInfo setString:@"digestStyle" forKey:@"cell-style"];
    } else if(__self.channelNum == 5) {
        sectionData.mDataCellClass = [SNLiveCell class];
        [sectionData.tableDataResult.resultInfo setString:@"digestStyle" forKey:@"cell-style"];
    } else if(__self.channelNum == 6) {
        sectionData.mDataCellClass = [SNLiveCell class];
        [sectionData.tableDataResult.resultInfo setString:@"digestStyle" forKey:@"cell-style"];
    } else if(__self.channelNum == 7) {
        sectionData.mDataCellClass = [SNStockStatusCell class];
    } else if(__self.channelNum == 8) {
        sectionData.mDataCellClass = [SNStockStatusCell class];
    } else if(__self.channelNum == 9) {
        sectionData.mDataCellClass = [SNStockStatusCell class];
    } else if(__self.channelNum == 10) {
        sectionData.mDataCellClass = [SNStockStatusCell class];
    } else if(__self.channelNum == 11) {
        sectionData.mDataCellClass = [SNStockStatusCell class];
    } else if(__self.channelNum == 12) {
        sectionData.mDataCellClass = [SNStockStatusCell class];
    } else if(__self.channelNum == 13) {
        sectionData.mDataCellClass = [SNLiveCell class];
        [sectionData.tableDataResult.resultInfo setString:@"digestStyle" forKey:@"cell-style"];
    }
    
    [self.tableView addSectionWithData:sectionData];
    [sectionData refreshData];
}

@end
