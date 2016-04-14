//
//  SNTagsView.m
//  IosDemo
//
//  Created by MengWang on 16/3/22.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNTagsView.h"

#define SCROLL_HEIGHT   40
#define TITLE_WIDTH     70
#define SCROLL_PADDING  4

@interface SNTagsView()
@property (nonatomic, strong)UIScrollView *tagsScrollView;
@property (nonatomic, strong)UIView *sepLine;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, assign)NSInteger beforeMinX;
@property (nonatomic, strong)NSArray *channelList;
@end

@implementation SNTagsView

- (instancetype)initWithChannelList:(NSArray *)channelList {
    self = [super init];
    if (self) {
        _channelList = channelList;
        
        _tagsScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _tagsScrollView.showsHorizontalScrollIndicator = NO;
        _tagsScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_tagsScrollView];
        
        [self.tagsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@SCROLL_HEIGHT);
        }];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < _channelList.count; i++) {
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_WIDTH * i, 0, TITLE_WIDTH, SCROLL_HEIGHT)];
            titleLbl.text = self.channelList[i];
            titleLbl.textAlignment = NSTextAlignmentCenter;
            titleLbl.textColor = [UIColor blackColor];
            titleLbl.font = [UIFont systemFontOfSize:16];
            titleLbl.tag = i;
            titleLbl.userInteractionEnabled = YES;
            [titleLbl addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)]];
            [self.tagsScrollView addSubview:titleLbl];
            [arr addObject:titleLbl];
        }
        _titleArray = [arr mutableCopy];
        self.tagsScrollView.contentSize = CGSizeMake(TITLE_WIDTH * self.channelList.count, self.tagsScrollView.height);
        
        UILabel *lable = [self.titleArray firstObject];
        lable.textColor = [UIColor blueColor];
        
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = [UIColor blueColor];
        [self.tagsScrollView addSubview:_sepLine];
        _sepLine.frame = CGRectMake(TITLE_WIDTH * lable.tag + SCROLL_PADDING, 38, TITLE_WIDTH - 2 * SCROLL_PADDING, 2);
        _beforeMinX = _sepLine.x;
    }
    return self;
}

- (void)titleClick:(UITapGestureRecognizer *)ges {
    UILabel *titleLbl = (UILabel *)ges.view;
    [self titleAction:titleLbl.tag];
}

- (void)titleAction:(NSInteger)index {
    UILabel *titleLbl = self.titleArray[index];
    
    [self.titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *temlabel = (UILabel *)self.titleArray[idx];
        temlabel.textColor = [UIColor blackColor];
    }];
    
    titleLbl.textColor = [UIColor blueColor];
    [UIView animateWithDuration:0.3 animations:^{
        [_sepLine sb_setMinX:titleLbl.tag * TITLE_WIDTH + SCROLL_PADDING];
        _beforeMinX = _sepLine.x;
    }];
    
    CGFloat offsetx = titleLbl.center.x - self.tagsScrollView.frame.size.width * 0.5;
    CGFloat offsetMax = self.tagsScrollView.contentSize.width - self.tagsScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.tagsScrollView.contentOffset.y);
    [self.tagsScrollView setContentOffset:offset animated:YES];
    
    if (self.titleClick) {
        self.titleClick(titleLbl.tag);
    }
}

- (void)dealloc {
    
}

@end
