//
//  SNStockStatusViewController.m
//  StockNews
//
//  Created by MengWang on 16/4/27.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNStockStatusViewController.h"
#import <SBBusiness/SNDataProcess.h>
#import <SBModule/SBURLAction.h>
#import <SBBusiness/SNJSONNODE.h>
#import <SBModule/STORE.h>
#import "SNStockStatusCell.h"

@interface SNStockStatusViewController ()
@property (nonatomic, strong)SBTableView *tableView;
@end

@implementation SNStockStatusViewController

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
    sectionData.mDataCellClass = [SNStockStatusCell class];
    [self.tableView addSectionWithData:sectionData];
    [sectionData refreshData];
}

@end
