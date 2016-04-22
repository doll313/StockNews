//
//  SNTagsView.m
//  IosDemo
//
//  Created by MengWang on 16/3/22.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNTagsView.h"

#define SCROLL_HEIGHT   40
#define PADDING         10

@interface SNTagsView()
@property (nonatomic, strong)UIScrollView *tagsScrollView;
@property (nonatomic, strong)UIImageView *backgroundImg;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, assign)NSInteger beforeMinX;
@property (nonatomic, strong)NSArray *channelList;
@end

@implementation SNTagsView

- (instancetype)initWithChannelList:(NSArray *)channelList {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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
        
        _backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newslist_item_bg"]];
        _backgroundImg.image = [_backgroundImg.image stretchableImageWithLeftCapWidth:_backgroundImg.width / 2 topCapHeight:_backgroundImg.size.height / 2];
        [self.tagsScrollView addSubview:_backgroundImg];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        CGFloat locationX = 0;
        for (int i = 0; i < _channelList.count; i++) {
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 0, 16)];
            titleLbl.text = self.channelList[i];
            titleLbl.textAlignment = NSTextAlignmentCenter;
            titleLbl.textColor = [UIColor whiteColor];
            titleLbl.font = [UIFont systemFontOfSize:14];
            titleLbl.tag = i;
            titleLbl.userInteractionEnabled = YES;
            [titleLbl addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)]];
            [titleLbl sizeToFit];
            titleLbl.left = PADDING + locationX;
            [self.tagsScrollView addSubview:titleLbl];
            [arr addObject:titleLbl];
            locationX += (titleLbl.width + 2 * PADDING);
        }
        
        _titleArray = [arr mutableCopy];
        self.tagsScrollView.contentSize = CGSizeMake(locationX, self.tagsScrollView.height);
        
        UILabel *titleLbl = [self.titleArray firstObject];
        _backgroundImg.frame = CGRectMake(titleLbl.left - 5, (SCROLL_HEIGHT - _backgroundImg.height) / 2, titleLbl.width + 10, _backgroundImg.height);
        _beforeMinX = _backgroundImg.x;
    }
    return self;
}

- (void)titleClick:(UITapGestureRecognizer *)ges {
    UILabel *titleLbl = (UILabel *)ges.view;
    [self titleAction:titleLbl.tag];
}

- (void)titleAction:(NSInteger)index {
    UILabel *titleLbl = self.titleArray[index];
    
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundImg.frame = CGRectMake(titleLbl.left - 5, (SCROLL_HEIGHT - _backgroundImg.height) / 2, titleLbl.width + 10, _backgroundImg.height);
        _beforeMinX = self.backgroundImg.x;
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
