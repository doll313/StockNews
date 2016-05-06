//
//  SNTopicViewController.m
//  StockNews
//
//  Created by MengWang on 16/5/3.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNTopicViewController.h"
#import <SBBusiness/SNDataProcess.h>
#import <SBModule/SBURLAction.h>
#import "SNTopicCell.h"
#import <SBBusiness/SNJSONNODE.h>
#import <SBModule/UIImageView+WebCache.h>
#import "SNTopicCell.h"

@interface SNTopicViewController ()
@property (nonatomic, strong)SBTableView *tableView;
@property (nonatomic, copy)NSString *topicName;
@property (nonatomic, strong)DataItemResult *result;
@property (nonatomic, strong)NSMutableDictionary *filterDic;
@property (nonatomic, strong)NSArray *filterArray;
@end

@implementation SNTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯专题";
    _filterDic = [NSMutableDictionary dictionary];
    _filterArray = [[NSMutableArray alloc] init];
    self.topicName = [self.urlAction stringForKey:@"topicName"];
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
        return [SNDataProcess snget_simtopic:__self.topicName delegate:tableViewData];
    };
    
    self.tableView.receiveData= ^(SBTableView *tableView ,SBTableData *tableViewData, DataItemResult *result) {
        if (result.hasError) {
            return;
        }
       
        DataItemResult *r = [__self parserTopicData:result.rawData];
        __self.result = r;
        __self.tableView.tableHeaderView = [__self initialHeaderView];
        __self.filterArray = [__self filterDicToArray];
        
        for (NSDictionary *dic in __self.filterArray) {
            NSArray *content = dic[__SN_TOPIC_CONTENT];
            if (content.count > 0 && [__self.filterArray indexOfObject:dic] > 0) {
                SBTableData *sectionData = [[SBTableData alloc] init];
                sectionData.mDataCellClass = [SNTopicCell class];
                sectionData.httpStatus = SBTableDataStatusFinished;
                sectionData.hasHeaderView = YES;
                [tableView addSectionWithData:sectionData];
                for (DataItemDetail *detail in content) {
                    [sectionData.tableDataResult addItem:detail];
                }
            } else {
                for (DataItemDetail *detail in content) {
                    [tableViewData.tableDataResult addItem:detail];
                }
            }
        }
    };
    
    _tableView.headerForSection = ^UIView *(SBTableView *tableView, NSInteger section) {
        if ([tableView dataOfSection:0].httpStatus != SBTableDataStatusFinished || [tableView dataOfSection:0].tableDataResult.dataList.count == 0) {
            return nil;
        }
        return [__self initialSectionHeader:section];
    };
    
    self.tableView.didSelectRow = ^(SBTableView *tableView, NSIndexPath *indexPath) {
        DataItemDetail *detail = [tableView dataOfIndexPath:indexPath];
        if ([detail getString:SN_TOPIC_LIST_SIMTPYE].length > 0) {
            // 专题
            SBURLAction *action = [SBURLAction actionWithClassName:@"SNTopicViewController"];
            [action setObject:[detail getString:SN_TOPIC_LIST_TOPICNAME] forKey:@"topicName"];
            [__self sb_openCtrl:action];
        } else {
            SBURLAction *action = [SBURLAction actionWithClassName:@"SNContentController"];
            [action setObject:detail forKey:@"detail"];
            [__self sb_openCtrl:action];
        }
    };
    
    // 添加表格数据
    SBTableData *sectionData = [[SBTableData alloc] init];
    sectionData.mDataCellClass = [SNTopicCell class];
    sectionData.hasHeaderView = YES;
    [self.tableView addSectionWithData:sectionData];
    [sectionData refreshData];
}

- (UIView *)initialSectionHeader:(NSInteger)section {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(APPCONFIG_UI_TABLE_PADDING, 0, self.view.width - 2 * APPCONFIG_UI_TABLE_PADDING, 30)];
    v.backgroundColor = RGB(234,234,234);
    
    NSDictionary *atts = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    
    UILabel *guidance = [[UILabel alloc] initWithFrame:v.frame];
    NSString *title = self.filterArray[section][__SN_TOPIC_TITLE];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@/%@    %@", @(section + 1), @(self.filterArray.count), title] attributes:atts];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,1)];
    guidance.attributedText = attr;
    [v addSubview:guidance];
    
    return v;
}

- (UIView *)initialHeaderView {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    
    UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
    DataItemDetail *topicDetail = (DataItemDetail *)[self.result.resultInfo getArray:@"Topic1"][0];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[topicDetail getString:SN_TOPIC_TOPICBANNER]] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    [v addSubview:imageView];
    
    UILabel *guidance = [[UILabel alloc] initWithFrame:CGRectMake(APPCONFIG_UI_TABLE_PADDING, imageView.bottom + APPCONFIG_UI_TABLE_PADDING, self.view.width - 2 * APPCONFIG_UI_TABLE_PADDING, 0)];
    guidance.font = [UIFont systemFontOfSize:12];
    guidance.backgroundColor = [UIColor whiteColor];
    DataItemDetail *detail = [(NSDictionary *)[self.result.resultInfo getObject:@"TopicHeadLine2"]  objectForKey:__SN_TOPIC_CONTENT][0];
    guidance.text = [NSString stringWithFormat:@"       %@",[detail getString:SN_TOPIC_HEADGUIDANCE]];
    guidance.numberOfLines = 0;
    [guidance sizeToFit];
    [v addSubview:guidance];
    
    v.height = guidance.bottom + APPCONFIG_UI_TABLE_PADDING;
    return v;
}

// 把字段转换成数组
- (NSArray *)filterDicToArray {
    // 根据key排序
    NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]];
    NSArray *sortedArray = [self.filterDic.allKeys sortedArrayUsingDescriptors:sortDesc];
    
    NSMutableArray *filterArr = [[NSMutableArray alloc] init];
    for (NSString *key in sortedArray) {
        if (self.filterDic[key] != nil) {
            [filterArr addObject:self.filterDic[key]];
        }
    }
    return [NSArray arrayWithArray:filterArr];
}

// 把rawData解析成result
- (DataItemResult *)parserTopicData:(NSData *)rawData {
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
    id contentValue = dataDict[@"topicinfo"];
    if(!contentValue || [contentValue isKindOfClass:[NSNull class]]) {
        contentValue = dataDict[@"topicinfo"];
    }
    
    if (contentValue && ![contentValue isKindOfClass:[NSNull class]]) {
        NSDictionary *resultDict = [NSDictionary dictionaryWithDictionary:contentValue];
        if (!resultDict || [resultDict isKindOfClass:[NSNull class]]) {
            return result;
        }
        
        for (NSString *resultKey in resultDict.allKeys) {
            id resultValue = resultDict[resultKey];
            if (resultValue && ![resultValue isKindOfClass:[NSNull class]]) {
                if ([resultValue isKindOfClass:[NSArray class]]) {
                    NSArray *array = [NSArray arrayWithArray:resultValue];
                    NSMutableArray *replaceArray = [NSMutableArray array];
                    for (NSDictionary *subDict in array) {
                        DataItemDetail *itemDetail = [DataItemDetail detailFromDictionary:subDict];
                        [replaceArray addObject:itemDetail];
                    }
                    [result.resultInfo setObject:replaceArray forKey:resultKey];
                } else if ([resultValue isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    for (NSString *k in [(NSDictionary *)resultValue allKeys]) {
                        if ([resultValue[k] isKindOfClass:[NSArray class]]) {
                            NSArray *array = [NSArray arrayWithArray:resultValue[k]];
                            NSMutableArray *replaceArray = [NSMutableArray array];
                            for (NSDictionary *subDict in array) {
                                DataItemDetail *itemDetail = [DataItemDetail detailFromDictionary:subDict];
                                [replaceArray addObject:itemDetail];
                            }
                            [dic setObject:replaceArray forKey:k];
                        } else {
                            [dic setObject:resultValue[k] forKey:k];
                        }
                    }
                    [result.resultInfo setObject:dic forKey:resultKey];
                }
                if ([resultKey hasPrefix:SN_TOPIC_CUTIMG_PREFIX]) {
                    [self.filterDic setObject:[result.resultInfo getObject:resultKey] forKey:resultKey];
                }
            }
        }
    }
    return result;
}

@end
