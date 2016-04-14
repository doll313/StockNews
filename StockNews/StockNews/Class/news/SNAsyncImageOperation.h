//
//  SNAsyncImageOperation.h
//  IosDemo
//
//  Created by MengWang on 16/3/31.
//  Copyright © 2016年 YukiWang. All rights reserved.
//  图片异步下载器

#import <UIKit/UIKit.h>

@interface SNAsyncImageOperation : NSOperation
- (instancetype)initWithURL:(NSString *)url andDelegate:(id<SBHttpTaskDelegate>)delegate;
@end
