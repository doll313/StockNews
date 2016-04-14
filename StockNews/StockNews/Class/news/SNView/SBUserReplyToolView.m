//
//  SBUserReplyToolView.m
//  IosDemo
//
//  Created by MengWang on 16/3/23.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBUserReplyToolView.h"
#import <SBBusiness/SBJSONNODEV3.h>

#define BTN_HEIGHT 36

@interface SBUserReplyToolView()
@property (nonatomic, strong)NSMutableArray *btnArr;
@property (nonatomic, strong)DataItemDetail *detail;
@property (nonatomic, strong)UIView *sepLine;
@end

@implementation SBUserReplyToolView

- (instancetype)init {
    self = [super init];
    _btnArr = [[NSMutableArray alloc] init];
    
    _sepLine = [[UIView alloc] init];
    _sepLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_sepLine];
    
    if (self) {
        for (NSInteger i = 0; i < 4; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 0, BTN_HEIGHT);
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self addSubview:btn];
            [_btnArr addObject:btn];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _sepLine.frame = CGRectMake(0, 0, self.width, 0.5);
    
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *btn = self.btnArr[i];
        btn.frame = CGRectMake(i * (self.width / 4), 0, self.width / 4, BTN_HEIGHT);
    }
}

- (void)setDetail:(DataItemDetail *)detail {
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *btn = self.btnArr[i];
        NSString *title = @"";
        if (i == 0) {
            title = @"分享";
        } else if(i == 1) {
            title = [NSString stringWithFormat:@"评论 %@", [detail getString:JNV3_POST_COMMENT_COUNT]];
        } else if(i == 2) {
            title = [NSString stringWithFormat:@"赞 %@", [detail getString:JNV3_POST_LIKE_COUNT]];
        } else {
            title = [NSString stringWithFormat:@"阅读 %@", [detail getString:JNV3_POST_CLICK_COUNT]];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)dealloc {
    
}

- (void)resetBtn {
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *btn = self.btnArr[i];
        [btn setTitle:@"" forState:UIControlStateNormal];
    }
}

@end
