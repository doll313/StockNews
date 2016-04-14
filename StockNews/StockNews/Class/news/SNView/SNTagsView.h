//
//  SNTagsView.h
//  IosDemo
//
//  Created by MengWang on 16/3/22.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNTagsView : UIView
@property (nonatomic, copy) void(^titleClick)(NSInteger);
- (instancetype)initWithChannelList:(NSArray *)channelList;
- (void)titleAction:(NSInteger)index;
@end
