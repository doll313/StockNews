//
//  SNYWViewController.m
//  StockNews
//
//  Created by MengWang on 16/4/27.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNYWViewController.h"
#import <SBBusiness/SNDataProcess.h>
#import <SBModule/SBURLAction.h>
#import <SBBusiness/SNJSONNODE.h>
#import <SBModule/STORE.h>
#import "SNYWCell.h"

@interface SNYWViewController ()
@property (nonatomic, strong)SBTableView *tableView;
@end

@implementation SNYWViewController

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
        return [SNDataProcess snget_important_news_list:minid encode:__self.channelName delegate:tableViewData];
    };
    
    self.tableView.receiveData= ^(SBTableView *tableView ,SBTableData *tableViewData, DataItemResult *result) {
        // 根据类名+频道名称组合成key
        NSString *key = [NSString stringWithFormat:@"%@%@", NSStringFromClass(__self.class), __self.channelName];
        if (result.hasError) {
            if (tableViewData.pageAt == 1 && tableViewData.tableDataResult.dataList.count == 0) {
                DataItemResult *cacheResult = [[SBAppCoreInfo getCacheDB] getResultValue:STORE_CACHE_TABLEDATA dataKey:key];
                [tableViewData.tableDataResult appendItems:cacheResult];
            }
            return;
        }
        
        if (tableViewData.pageAt == 1) {
            // 对数据第一页做缓存
            [[SBAppCoreInfo getCacheDB] setResultValue:STORE_CACHE_TABLEDATA dataKey:key data:result];
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
    sectionData.mDataCellClass = [SNYWCell class];
    [self.tableView addSectionWithData:sectionData];
    [sectionData refreshData];
}

@end
