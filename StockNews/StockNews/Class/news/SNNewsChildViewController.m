//
//  SNNewsChildViewController.m
//  IosDemo
//
//  Created by MengWang on 16/3/21.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNNewsChildViewController.h"
#import <SBBusiness/SNDataProcess.h>
#import "SBCommentView+Private.h"
#import <SBBusiness/SBV3Process.h>
#import <SBModule/SBURLAction.h>
#import <SBBusiness/SNJSONNODE.h>
#import <SBBusiness/SBTimeManager.h>
#import <SBModule/STORE.h>
#import "SNNewsManager.h"

@interface SNNewsChildViewController ()
@property (nonatomic, strong)SBTableView *tableView;
@property (nonatomic, strong)NSMutableArray *dateArray;
@property (nonatomic, strong)SNNewsManager *manager;
@end

@implementation SNNewsChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dateArray = [[NSMutableArray alloc] init];
    _manager = [[SNNewsManager alloc] initWithTitleName:self.titleName];
    
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
        
        if (self.manager.column.length == 0 && self.manager.channelName.length == 0) {
            return [SBV3Process sbset_sepcial_blog_list:tableViewData.pageAt type:0 delegate:tableViewData];
        }
        
        if (self.manager.column.length > 0 && self.manager.channelName.length == 0) {
            return [SNDataProcess snget_news_list:minid column:__self.manager.column delegate:tableViewData];
        }
        return [SNDataProcess snget_important_news_list:minid encode:__self.manager.channelName delegate:tableViewData];
    };
    
    self.tableView.receiveData= ^(SBTableView *tableView ,SBTableData *tableViewData, DataItemResult *result) {
        if (result.hasError) {
            return;
        }
        
        [__self appendDataWithResult:result tableViewData:tableViewData isShowDate:__self.manager.hasHeaderView];
    };
    
    self.tableView.headerForSection = ^(SBTableView *tableView, NSInteger section) {
        if (__self.dateArray.count > 0 && __self.manager.hasHeaderView == YES) {
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
    sectionData.mDataCellClass = self.manager.dataClass;
    sectionData.hasHeaderView = self.manager.hasHeaderView;
    if ([self.manager.cellStyle isEqualToString:@"digestStyle"]) {
        [sectionData.tableDataResult.resultInfo setString:@"digestStyle" forKey:@"cell-style"];
    }
    [self.tableView addSectionWithData:sectionData];
    [sectionData refreshData];
}

- (void)appendDataWithResult:(DataItemResult *)result tableViewData:(SBTableData *)tableViewData isShowDate:(BOOL)isShowDate {
    if (isShowDate) {
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
            if (![self.dateArray containsObject:date]) {
                [self.dateArray addObject:date];
                if (self.dateArray.count > 1) {
                    // 创建新的section
                    SBTableData *sectionData = [[SBTableData alloc] init];
                    sectionData.hasHeaderView = YES;
                    sectionData.mDataCellClass = self.manager.dataClass;
                    sectionData.hasFinishCell = YES;
                    sectionData.httpStatus = SBTableDataStatusFinished;
                    [self.tableView addSectionWithData:sectionData];
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
    } else {
        [tableViewData.tableDataResult appendItems:result];
    }
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
