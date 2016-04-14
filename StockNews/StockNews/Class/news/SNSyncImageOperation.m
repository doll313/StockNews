//
//  SNSyncImageOperation.m
//  IosDemo
//
//  Created by MengWang on 16/3/30.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNSyncImageOperation.h"

@interface SNSyncImageOperation()
@property (nonatomic, copy )NSString *imageUrl;
@property (nonatomic, weak)id<SBHttpTaskDelegate> delegate;
@end

@implementation SNSyncImageOperation

- (instancetype)initWithURL:(NSString *)url andDelegate:(id<SBHttpTaskDelegate>)delegate {
    self = [super init];
    if (self) {
        self.imageUrl = url;
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc {
    if (!self.isCancelled && !self.isFinished) {
        [self cancel];
    }
}

- (void)main {
    if (![self isCancelled]) {
        
       // NSURLConnection sync request
        NSURL *imageUrl = [NSURL URLWithString:self.imageUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
        NSError *error = nil;
        NSURLResponse *response = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error == nil) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(task:onReceived:)]) {
                SBHttpTask *task = [[SBHttpTask alloc] init];
                task.aURLString = self.imageUrl;
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 注意:放入主线程执行
                    [self.delegate task:task onReceived:data];
                });
            }
        }
    }
}

@end
