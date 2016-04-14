//
//  SBStarView.m
//  IosDemo
//
//  Created by MengWang on 16/2/14.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBStarView.h"

#define STAR_WIDTH 10

@interface SBStarView()
@property (nonatomic, assign)NSInteger starCount;
@property (nonatomic, strong)NSMutableArray *imgArray;
@end

@implementation SBStarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i * STAR_WIDTH, 0, STAR_WIDTH, STAR_WIDTH)];
            img.image = [UIImage imageNamed:@"sb_icon_star_empty"];
            [self addSubview:img];
            [_imgArray addObject:img];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, STAR_WIDTH * 5, STAR_WIDTH);
}

- (void)setStarCount:(NSInteger)starCount {
    if (starCount == 0) {
        for (int i = 0; i < 5; i++) {
            UIImageView *img = _imgArray[i];
            img.image = [UIImage imageNamed:@"sb_icon_star_empty"];
        }
    } else if(starCount % 2 == 0) {
        for (int i = 0; i < starCount / 2; i++) {
            UIImageView *img = _imgArray[i];
            img.image = [UIImage imageNamed:@"sb_icon_star_full"];
        }
        for (int i = ((int)starCount / 2); i < 5; i++) {
            UIImageView *img = _imgArray[i];
            img.image = [UIImage imageNamed:@"sb_icon_star_empty"];
        }
    } else {
        for (int i = 0; i < (int)starCount / 2; i++) {
            UIImageView *img = _imgArray[i];
            img.image = [UIImage imageNamed:@"sb_icon_star_full"];
        }
        UIImageView *img = _imgArray[(int)starCount / 2];
        img.image = [UIImage imageNamed:@"sb_icon_star_half"];
        for (int i = ((int)starCount / 2) + 1; i < 5; i++) {
            UIImageView *img = _imgArray[i];
            img.image = [UIImage imageNamed:@"sb_icon_star_empty"];
        }
    }
}

- (void)dealloc {
    
}

@end
