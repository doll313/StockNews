//
//  SBCommentController.m
//  IosDemo
//
//  Created by MengWang on 16/3/29.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBCommentController.h"
#import "SBCommentView.h"
#import <SBBusiness/SNJSONNODE.h>

@interface SBCommentController ()
@property (nonatomic, strong)SBCommentView *sb;
@end

@implementation SBCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Comment";
    
    DataItemDetail *detail = (DataItemDetail *)[self.urlAction objectForKey:@"detail"];
    self.sb = [[SBCommentView alloc] initWithPostId:[detail getString:__SN_BIGNEWS_LIST_NEWSID] type:[[detail getString:@"ty"] intValue]];
    self.sb.backgroundColor = [UIColor greenColor];
    self.sb.ctrl = self;
    [self.view addSubview:self.sb];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.sb.width = self.view.width;
    self.sb.height = self.view.height;
}

@end
