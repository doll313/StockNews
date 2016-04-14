//
//  DemoController.m
//  IosDemo
//
//  Created by roronoa on 16/3/17.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBNewsController.h"
#import <SBBusiness/SNDataProcess.h>


@interface SBNewsCell : SBTitleCell

@end
@implementation SBNewsCell

- (void)bindCellData {
    [super bindCellData];
    
    self.titleLbl.text = [self.cellDetail getString:@"title"];
}

@end

@interface SBNewsController ()

@property (nonatomic, strong) SBTableView *aTable;

@end

@implementation SBNewsController

- (void)dealloc {
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.aTable.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableDidLoad];
}

- (void)tableDidLoad {
    self.aTable = [[SBTableView alloc] initWithStyle:NO];
    self.aTable.isRefreshType = YES;
    self.aTable.ctrl = self;
    [self.view addSubview:self.aTable];
    
    // 请求个人关注表格数据
    self.aTable.requestData = ^(SBTableData *tableViewData) {
        //TODO 翻页
        return [SNDataProcess snget_important_news_list:@"" encode:@"ywjh" delegate:tableViewData];
    };
    
    // 处理个人关注表格数据
    self.aTable.receiveData= ^(SBTableView *tableView ,SBTableData *tableViewData, DataItemResult *result) {
        if (result.hasError) {
            return;
        }
        
        [tableViewData.tableDataResult appendItems:result];
    };
    
    // 计算单元格高度
    self.aTable.heightForRow = ^CGFloat(SBTableView *tableView, NSIndexPath *indexPath) {
        return APPCONFIG_UI_TABLE_CELL_HEIGHT;
    };
    
    // 点击单元格
    self.aTable.didSelectRow = ^(SBTableView *tableView, NSIndexPath *indexPath) {
    };
    
    // 添加表格数据
    SBTableData *sectionData = [[SBTableData alloc] init];
    sectionData.mDataCellClass = [SBNewsCell class];
    [self.aTable addSectionWithData:sectionData];
    
    [sectionData refreshData];
}
@end

