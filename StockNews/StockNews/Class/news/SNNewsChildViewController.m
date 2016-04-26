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
#import <SBBusiness/SNJSONNODE.h>
#import <SBBusiness/SBTimeManager.h>

@interface SNNewsChildViewController ()
@property (nonatomic, strong)SBTableView *tableView;
@property (nonatomic, strong)NSMutableArray *dateArray;
@end

@implementation SNNewsChildViewController

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
        
        NSString *channelName = @"";
        if (__self.channelNum == 0) {
            // 要闻
            channelName = @"ywjh";
        } else if(__self.channelNum == 1) {
            // 直播
            channelName = @"zhibo";
            if (tableViewData.pageAt == 1 && __self.dateArray.count > 0) {
                // 重新刷新的时候，清除时间数组
                [__self.dateArray removeAllObjects];
            }
        } else if(__self.channelNum == 2) {
            // 个股
            channelName = @"ggdj";
        } else if(__self.channelNum == 3) {
            // 看盘
            return [SBV3Process sbset_sepcial_blog_list:tableViewData.pageAt type:0 delegate:tableViewData];
        } else if(__self.channelNum == 4) {
            // 滚动
            return [SNDataProcess snget_news_list:minid column:@"102" delegate:tableViewData];
        } else if(__self.channelNum == 5) {
            // 公司
            return [SNDataProcess snget_news_list:minid column:@"103" delegate:tableViewData];
        } else if(__self.channelNum == 6) {
            // 基金
            return [SNDataProcess snget_news_list:minid column:@"109" delegate:tableViewData];
        } else if(__self.channelNum == 7) {
            // 股市播报
            channelName = @"gszb";
        } else if(__self.channelNum == 8) {
            // 大盘
            channelName = @"dpfx";
        } else if(__self.channelNum == 9) {
            // 交易提示
            channelName = @"jyts";
        } else if(__self.channelNum == 10) {
            // 产经新闻
            channelName = @"cjxw";
        } else if(__self.channelNum == 11) {
            // 报刊头条
            channelName = @"bktt";
        } else if(__self.channelNum == 12) {
            // 美股要闻
            channelName = @"mgyw";
        } else if(__self.channelNum == 13) {
            // 全球股市
            return [SNDataProcess snget_news_list:minid column:@"105" delegate:tableViewData];
        }
        return [SNDataProcess snget_important_news_list:minid encode:channelName delegate:tableViewData];
    };
    
    self.tableView.receiveData= ^(SBTableView *tableView ,SBTableData *tableViewData, DataItemResult *result) {
        if (result.hasError) {
            return;
        }
        
        if (__self.channelNum == 1) {
            tableViewData.tableDataResult.maxCount = result.maxCount;
            tableViewData.tableDataResult.statusCode = result.statusCode;
            tableViewData.tableDataResult.message = result.message;
            tableViewData.tableDataResult.itemUniqueKeyName = result.itemUniqueKeyName;

            //信息数据
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
            return;
        }
        
        [tableViewData.tableDataResult appendItems:result];
    };
    
    self.tableView.headerForSection = ^(SBTableView *tableView, NSInteger section) {
        if (__self.channelNum == 1) {
            if (__self.dateArray.count > 0) {
                return [__self headerView:__self.dateArray[section]];
            }
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
    if (__self.channelNum == 0) {
        sectionData.mDataCellClass = [SNYWCell class];
    } else if(__self.channelNum == 1) {
        sectionData.mDataCellClass = [SNLiveCell class];
        sectionData.hasHeaderView = YES;   // 直播是有时间分割的
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
