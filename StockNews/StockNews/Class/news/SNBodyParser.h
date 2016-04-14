//
//  SNBodyParser.h
//  IosDemo
//
//  Created by MengWang on 16/3/28.
//  Copyright © 2016年 YukiWang. All rights reserved.
//  资讯正文解析

#import <Foundation/Foundation.h>

@interface SNBodyParser : NSObject
//解析资讯正文接口
+ (DataItemResult *)parserBodyData:(NSData *)rawData ;
//解析最终生成模板的 html字段 新闻
+ (void)generateNewsHTML:(DataItemResult *)result onFinished:(void(^)(NSString *result))callback;
//解析处理相关新闻
+ (void)generateRelatedNewsLink:(DataItemResult *)result;
//获取图片信息
+ (NSArray *)generateBodyImages:(DataItemResult *)result;
//获取超链信息
+ (NSArray *)generateBodyLinks:(DataItemResult *)result;
@end
