//
//  SBCommentView.h
//  IosDemo
//
//  Created by MengWang on 16/1/21.
//  Copyright © 2016年 YukiWang. All rights reserved.
//  评论页面

#import <UIKit/UIKit.h>
#import "SBEmojiModel.h"

/** 评论列表 */
@interface SBCommentView : UIView
@property (nonatomic, assign) UIViewController *ctrl;
@property (nonatomic, strong)SBTableView *tableView;
@property (nonatomic, strong)SBEmojiModel *model;

- (instancetype)initWithPostId:(NSString *)postid type:(NSInteger)type;

/** 刷新评论列表 */
- (void)refreshComments;
@end
