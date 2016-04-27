//
//  SNNewsManager.h
//  StockNews
//
//  Created by MengWang on 16/4/27.
//  Copyright © 2016年 YukiWang. All rights reserved.
//  资讯管理类

#import <Foundation/Foundation.h>

@interface SNNewsManager : NSObject
@property (nonatomic, copy)NSString *column;     // 编号
@property (nonatomic, copy)NSString *channelName;// 频道名称

@property (nonatomic, assign)BOOL hasHeaderView;// 是否有时间分割，类似直播
@property (nonatomic, assign)Class dataClass;    // 单元格cell类型
@property (nonatomic, copy)NSString *cellStyle;   // 单元格cell类型
@property (nonatomic, copy)NSString *dataKey;    // 键值

- (id)initWithTitleName:(NSString *)titleName;
@end
