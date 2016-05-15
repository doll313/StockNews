//
//  SBCommentCell.m
//  IosDemo
//
//  Created by MengWang on 16/1/21.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBCommentCell.h"
#import <SBBusiness/SBJSONNODEV3.h>
#import <SBModule/UIImageView+WebCache.h>
#import "SBStarView.h"
#import <SBBusiness/SBTimeManager.h>
#import "SBReplyView.h"

#define CommentMargin 10

@interface SBCommentCell() <UITextViewDelegate>
@property (nonatomic, strong)UIImageView *avatarImageView;     // 头像
@property (nonatomic, strong)UILabel *userNameLbl;    // 用户名
@property (nonatomic, strong)UITextView *replyTextView;   // 回复文本
@property (nonatomic, strong)UILabel *ageLbl;         // 吧龄
@property (nonatomic, strong)UILabel *userAgeLbl;     // 显示吧龄
@property (nonatomic, strong)UILabel *timeLbl;        // 发布时间
@property (nonatomic, strong)UILabel *likeCountLbl;   // 点赞数量
@property (nonatomic, strong)UILabel *infuLbl;        // 影响力
@property (nonatomic, strong)SBStarView *starView;    // 星级
@property (nonatomic, strong)SBReplyView *replyView;  // 回复view
@end

@implementation SBCommentCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.avatarImageView.image = nil;
    self.userNameLbl.text = nil;
    self.replyTextView.attributedText = nil;
    self.ageLbl.text = nil;
    self.userAgeLbl.text = nil;
    self.timeLbl.text = nil;
    self.likeCountLbl.text = nil;
    self.infuLbl.text = nil;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_avatarImageView];
        
        _userNameLbl = [[UILabel alloc] init];
        _userNameLbl.textColor = [UIColor blackColor];
        _userNameLbl.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_userNameLbl];
       
        _infuLbl = [[UILabel alloc] init];
        _infuLbl.textColor = [UIColor grayColor];
        _infuLbl.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_infuLbl];
        [_infuLbl sizeToFit];
       
        _starView = [[SBStarView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_starView];
        
        _ageLbl = [[UILabel alloc] init];
        _ageLbl.textColor = [UIColor grayColor];
        _ageLbl.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_ageLbl];
        [_ageLbl sizeToFit];
        
        _userAgeLbl = [[UILabel alloc] init];
        _userAgeLbl.textColor = [UIColor orangeColor];
        _userAgeLbl.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_userAgeLbl];
        [_userAgeLbl sizeToFit];

        _timeLbl = [[UILabel alloc] init];
        _timeLbl.textColor = [UIColor grayColor];
        _timeLbl.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_timeLbl];
        [_timeLbl sizeToFit];

        _likeCountLbl = [[UILabel alloc] init];
        _likeCountLbl.textColor = [UIColor grayColor];
        _likeCountLbl.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_likeCountLbl];
        [_likeCountLbl sizeToFit];
      
        _replyView = [[SBReplyView alloc] init];
        [self.contentView addSubview:_replyView];
        
        _replyTextView = [[UITextView alloc] init];
        _replyTextView.scrollEnabled = NO;
        _replyTextView.editable = NO;
        _replyTextView.backgroundColor = [UIColor clearColor];
        _replyTextView.delegate = self;
        _replyTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _replyTextView.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
        // 设置link的样式
        _replyTextView.linkTextAttributes = @{NSForegroundColorAttributeName: RGB(49,111,201),
                                              NSUnderlineColorAttributeName: [UIColor blackColor],
                                              NSUnderlineStyleAttributeName: @(NSUnderlinePatternDash)};
        [self.contentView addSubview:_replyTextView];
      
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.size.mas_equalTo(CGSizeMake(35, 35));
        }];
        
        [self.userNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.height.equalTo(@22);
        }];
        
        [self.infuLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userNameLbl.mas_bottom);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userNameLbl.mas_bottom);
            make.left.equalTo(self.infuLbl.mas_right).with.offset(2);
            make.size.mas_equalTo(CGSizeMake(50, 10));
        }];
        
        [self.ageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infuLbl.mas_top);
            make.left.equalTo(self.starView.mas_right).with.offset(2);
        }];
        
        [self.userAgeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.ageLbl.mas_top);
            make.left.equalTo(self.ageLbl.mas_right).with.offset(2);
        }];
        
        [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userAgeLbl.mas_bottom).with.offset(2);
            make.left.equalTo(self.userNameLbl);
        }];
        
        [self.likeCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userNameLbl.mas_top);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.replyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLbl.mas_bottom).offset(APPCONFIG_UI_TABLE_PADDING);
            make.left.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [_replyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.top.equalTo(self.timeLbl.mas_bottom).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.bottom.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        //长按手势屏蔽系统的长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
        longPress.delegate = self;   //记得在.h文件里加上<UIGestureRecognizerDelegate>委托
        longPress.minimumPressDuration = 0.4;  //这里为什么要设置0.4，因为只要大于0.5就无效
        [self.replyTextView addGestureRecognizer:longPress];
    }
    
    return self;
}

- (void)dealloc {
    
}

- (void)bindCellData {
    [super bindCellData];

    DataItemDetail *detail = [self.cellDetail getDetail:JNV3_REPLY_USER];
    NSString *nickName = [detail getString:JNV3_USER_NICKNAME];
    self.userNameLbl.textColor = nickName.length > 0 ? RGB(49,111,201) : [UIColor blackColor];
    self.userNameLbl.text = (nickName.length > 0 ? nickName : [self.cellDetail getString:JNV3_REPLY_IP]);
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://avator.eastmoney.com/qface/%@/120",[detail getString:JNV3_USER_ID] ]] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    
    self.infuLbl.text = @"影响力";
    [self.starView setStarCount:[[detail getString:JNV3_USER_INFLU_LEVEL] intValue]];
    self.ageLbl.text = @"吧龄";
    self.userAgeLbl.text = [detail getString:JNV3_USER_BAR_AGE];
    self.timeLbl.text = [SBTimeManager sb_formatStatusTime:[self.cellDetail getString:JNV3_REPLY_PUBLISH_TIME]];
    self.likeCountLbl.text = [NSString stringWithFormat:@"赞 %@  |  评论", [self.cellDetail getString:JNV3_REPLY_LIKE_COUNT]];
    [self.replyView setDetail:self.cellDetail];
    self.replyTextView.attributedText = [self.cellDetail getATTString:@"attr"];
    [self.replyTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
        make.top.equalTo((self.replyView.hidden == YES ? self.timeLbl.mas_bottom : self.replyView.mas_bottom)).with.offset(APPCONFIG_UI_TABLE_PADDING);
        make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        make.bottom.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
    }];
}

-(void)attachMenu
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
}

-(BOOL)canBecomeFirstResponder {
    return NO;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"http://"]) {
        NSString *url = [URL host];
        NSLog(@"url = %@", url);
        return NO;
    }
    return YES;
}

@end
