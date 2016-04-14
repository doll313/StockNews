//
//  SNSyncImageOperation.h
//  IosDemo
//
//  Created by MengWang on 16/3/30.
//  Copyright © 2016年 YukiWang. All rights reserved.
//  图片同步下载器

#import <UIKit/UIKit.h>

@interface SNSyncImageOperation : NSOperation
- (instancetype)initWithURL:(NSString *)url andDelegate:(id<SBHttpTaskDelegate>)delegate;
@end
