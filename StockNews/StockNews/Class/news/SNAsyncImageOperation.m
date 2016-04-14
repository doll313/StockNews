//
//  SNAsyncImageOperation.m
//  IosDemo
//
//  Created by MengWang on 16/3/31.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNAsyncImageOperation.h"

@interface SNAsyncImageOperation()<SBHttpTaskDelegate>
@property (nonatomic, copy )NSString *imageUrl;
@property (nonatomic, weak)id<SBHttpTaskDelegate> delegate;
@property (nonatomic, strong)SBHttpTask *task;
@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@end

@implementation SNAsyncImageOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithURL:(NSString *)url andDelegate:(id<SBHttpTaskDelegate>)delegate {
    self = [super init];
    if (self) {
        self.imageUrl = url;
        self.delegate = delegate;
    }
    return self;
}

- (void)start {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    // async request
    self.task = [[SBHttpTask alloc] initWithURLString:self.imageUrl httpMethod:@"GET" delegate:self];
}

- (void)dealloc {
    if (!self.isCancelled && !self.isFinished) {
        [self.task stopLoading];
        [self cancel];
    }
}

// 告诉系统，并发
- (BOOL)isConcurrent {
    return YES;
}

/** onError 方法，在 SBHttpTask 请求出错时回调的方法 */
- (void)task:(SBHttpTask *)task onError:(NSError *)error {
    [self finish];
    if ([self.delegate respondsToSelector:@selector(task:onError:)]) {
        [self.delegate task:task onError:error];
    }
}

/** onReceived 方法，在 SBHttpTask 数据加载完成后回调的方法 */
- (void)task:(SBHttpTask *)task onReceived:(NSData *)data {
    [self finish];
    if (self.delegate && [self.delegate respondsToSelector:@selector(task:onReceived:)]) {
        [self.delegate task:task onReceived:data];
    }
}

- (void)finish {
    self.task = nil;
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _executing = NO;
    _finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
