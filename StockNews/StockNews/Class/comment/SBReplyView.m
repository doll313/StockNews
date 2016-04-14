//
//  SBReplyView.m
//  IosDemo
//
//  Created by MengWang on 16/3/11.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBReplyView.h"
#import <SBBusiness/SBJSONNODEV3.h>
#import <SBModule/UIImageView+WebCache.h>

@interface SBReplyView() <UITextViewDelegate>
@property (nonatomic, strong)UIImageView *avatarImageView;     // 头像
@property (nonatomic, strong)UILabel *userNameLbl;    // 用户名
@property (nonatomic, strong)DataItemDetail *detail;
@property (nonatomic, strong)UITextView *replyTextView;   // 回复文本
@end

@implementation SBReplyView

- (instancetype)init {
    self = [super init];
    if (self) {
        _avatarImageView = [[UIImageView alloc] init];
        [self addSubview:_avatarImageView];
        
        _userNameLbl = [[UILabel alloc] init];
        _userNameLbl.textColor = [UIColor blackColor];
        _userNameLbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:_userNameLbl];
        
        _replyTextView = [[UITextView alloc] init];
        _replyTextView.scrollEnabled = NO;
        _replyTextView.editable = NO;
        _replyTextView.backgroundColor = [UIColor clearColor];
        _replyTextView.delegate = self;
        _replyTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _replyTextView.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
        // 设置link的样式
        _replyTextView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                              NSUnderlineColorAttributeName: [UIColor blackColor],
                                              NSUnderlineStyleAttributeName: @(NSUnderlinePatternDash)};
        
        [self addSubview:_replyTextView];
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(2 * APPCONFIG_UI_TABLE_PADDING);
            make.top.equalTo(self).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.userNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.right.equalTo(self).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.height.equalTo(@20);
        }];
        
        [_replyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.top.equalTo(self.userNameLbl.mas_bottom).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.right.equalTo(self).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)setDetail:(DataItemDetail *)detail {
    if ([detail getString:JNV3_SOURCE_REPLY_USER_ID].length == 0) {
        self.hidden = YES;
        return;
    }
    
    self.hidden = NO;

    NSString *nickName = [detail getString:JNV3_SOURCE_REPLY_USER_NICKNAME];
    self.userNameLbl.text = (nickName.length > 0 ? nickName : [detail getString:JNV3_SOURCE_REPLY_IP]);
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://avator.eastmoney.com/qface/%@/120",[detail getString:JNV3_SOURCE_REPLY_USER_ID] ]] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    self.replyTextView.attributedText = [detail getATTString:@"replyattr"];
    
    [self.replyTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(APPCONFIG_UI_TABLE_PADDING);
        make.top.equalTo(self.userNameLbl.mas_bottom).with.offset(APPCONFIG_UI_TABLE_PADDING);
        make.right.equalTo(self).with.offset(-APPCONFIG_UI_TABLE_PADDING);
    }];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.replyTextView.mas_bottom).offset(APPCONFIG_UI_TABLE_PADDING);
    }];
}

-(void)dealloc {
    
}

@end
