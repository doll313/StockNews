//
//  SBCommentController.m
//  IosDemo
//
//  Created by MengWang on 16/3/29.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBCommentController.h"
#import "SBCommentView.h"

@interface SBCommentController ()
@property (nonatomic, strong)SBCommentView *sb;
@end

@implementation SBCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataItemDetail *detail = (DataItemDetail *)[self.urlAction objectForKey:@"detail"];
    self.sb = [[SBCommentView alloc] initWithDataItemDetail:detail];
    self.sb.backgroundColor = [UIColor whiteColor];
    self.sb.ctrl = self;
    [self.view addSubview:self.sb];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.sb.width = self.view.width;
    self.sb.height = self.view.height;
}

@end
