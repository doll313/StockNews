//
//  SNLiveViewController.m
//  StockNews
//
//  Created by MengWang on 16/4/27.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNLiveViewController.h"
#import <SBBusiness/SNDataProcess.h>
#import "SBCommentView+Private.h"
#import <SBModule/SBURLAction.h>
#import <SBBusiness/SNJSONNODE.h>
#import <SBBusiness/SBTimeManager.h>
#import <SBModule/STORE.h>
#import "SNLiveCell.h"

@interface SNLiveViewController ()
@property (nonatomic, strong)SBTableView *tableView;
@property (nonatomic, strong)NSMutableArray *dateArray;
@end

@implementation SNLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dateArray = [[NSMutableArray alloc] init];
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
        
        // 类似直播这种有分割时间显示的
        if (tableViewData.pageAt == 1 && __self.dateArray.count > 0) {
            // 重新刷新的时候，清除时间数组
            [__self.dateArray removeAllObjects];
        }
        
        if (__self.column.length == 0 && __self.channelName.length > 0) {
            return [SNDataProcess snget_important_news_list:minid encode:__self.channelName delegate:tableViewData];
        }
        
        return [SNDataProcess snget_news_list:minid column:__self.column delegate:tableViewData];
    };
    
    self.tableView.receiveData= ^(SBTableView *tableView ,SBTableData *tableViewData, DataItemResult *result) {
        if (result.hasError) {
            return;
        }
        
        tableViewData.tableDataResult.maxCount = result.maxCount;
        tableViewData.tableDataResult.statusCode = result.statusCode;
        tableViewData.tableDataResult.message = result.message;
        tableViewData.tableDataResult.itemUniqueKeyName = result.itemUniqueKeyName;
        
        NSDictionary *itemInfo = result.resultInfo.dictData;
        for(NSString *key in [itemInfo allKeys]){
            NSString *value = (NSString *)itemInfo[key];
            [tableViewData.tableDataResult.resultInfo setString:value forKey:key];
        }
        
        SBTableData *lastTableData = tableViewData;
        for (DataItemDetail *detail in result.dataList) {
            NSString *date = [detail getString:SN_OTHER_LIST_TIME];
            date = [SBTimeManager sb_formatStr:date preFormat:@"yyyy-MM-dd HH:mm:ss" newFormat:@"yyyy年MM月dd日"];
            if (![__self.dateArray containsObject:date]) {
                [__self.dateArray addObject:date];
                if (__self.dateArray.count > 1) {
                    // 创建新的section
                    SBTableData *sectionData = [[SBTableData alloc] init];
                    sectionData.hasHeaderView = YES;
                    sectionData.mDataCellClass = [SNLiveCell class];
                    sectionData.hasFinishCell = YES;
                    sectionData.httpStatus = SBTableDataStatusFinished;
                    [__self.tableView addSectionWithData:sectionData];
                    [sectionData.tableDataResult addItem:detail];
                    lastTableData = sectionData;
                    
                    sectionData.tableDataResult.resultInfo = tableViewData.tableDataResult.resultInfo;
                    sectionData.tableDataResult.maxCount = result.maxCount;
                    sectionData.pageSize = tableViewData.pageSize;
                    sectionData.pageAt = tableViewData.pageAt;
                    continue;
                }
            }
            [lastTableData.tableDataResult addItem:detail];
        }
        if (lastTableData != tableViewData) {
            [lastTableData loadData];
        }
    };
    
    self.tableView.headerForSection = ^(SBTableView *tableView, NSInteger section) {
        if (__self.dateArray.count > 0) {
            return [__self headerView:__self.dateArray[section]];
        }
        return [[UIView alloc] initWithFrame:CGRectZero];
    };
    
    self.tableView.didSelectRow = ^(SBTableView *tableView, NSIndexPath *indexPath) {
        SBURLAction *action = [SBURLAction actionWithClassName:@"SNContentController"];
        [action setObject:[tableView dataOfIndexPath:indexPath] forKey:@"detail"];
        [__self sb_openCtrl:action];
    };
    
    // 添加表格数据
    SBTableData *sectionData = [[SBTableData alloc] init];
    sectionData.mDataCellClass = [SNLiveCell class];
    sectionData.hasHeaderView = YES;
    if ([self.cellStyle isEqualToString:@"digestStyle"]) {
        [sectionData.tableDataResult.resultInfo setString:@"digestStyle" forKey:@"cell-style"];
    }
    [self.tableView addSectionWithData:sectionData];
    [sectionData refreshData];
}

- (UIView *)headerView:(NSString *)title {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.frame];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = RGB(49,111,201);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:label];
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t1_cell_seperate_line"]];
    bottomLine.frame = CGRectMake(0, 19, self.view.width, 1);
    [headerView addSubview:bottomLine];
    return headerView;
}

@end
