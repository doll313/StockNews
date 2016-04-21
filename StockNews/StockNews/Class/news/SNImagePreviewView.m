//
//  SNImagePreviewView.m
//  IosDemo
//
//  Created by MengWang on 16/4/2.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNImagePreviewView.h"

@interface SNImagePreviewView()
@property (nonatomic, strong)UIImageView *bigImageView;
@property (nonatomic, strong)UIActivityIndicatorView *actView;   // loading view
@end

@implementation SNImagePreviewView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        _bigImageView = [[UIImageView alloc] init];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_bigImageView];
        
        _actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:_actView];
        
        UITapGestureRecognizer *panGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBigImageView:)];
        [self addGestureRecognizer:panGesture];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 全屏幕
    self.frame = [UIScreen mainScreen].bounds;
    
    [self.actView setSize:CGSizeMake(50, 50)];
    self.actView.center = self.center;
    self.bigImageView.center = self.center;
    self.bigImageView.bounds = self.frame;
}

// 展示大图，传image进去
- (void)showBigImageView:(UIImage *)bigImage {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [self.actView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.actView stopAnimating];
        self.bigImageView.image = bigImage;
    });
}

- (void)removeBigImageView:(UITapGestureRecognizer *)ges {
    // 缩小动画
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.bigImageView.transform = CGAffineTransformScale(self.bigImageView.transform, 0.001, 0.001);
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
}

@end
