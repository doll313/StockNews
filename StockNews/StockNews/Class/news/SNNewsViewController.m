//
//  SNNewsViewController.m
//  IosDemo
//
//  Created by MengWang on 16/3/18.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNNewsViewController.h"
#import "SNNewsChildViewController.h"
#import "SNTagsView.h"

@interface SNNewsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)NSArray *channelList;    // 频道号列表
@property (nonatomic, strong)SNTagsView *tagsView;
@property (nonatomic, strong)UIScrollView *pageScrollView;
@end

@implementation SNNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"stock_navi_bg_128"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stock_navigation_back"] highlightedImage:[UIImage imageNamed:@"stock_navigation_back"]]];
    self.navigationItem.backBarButtonItem.title = @"";
    
    self.channelList = @[@"要闻", @"直播", @"个股", @"看盘", @"滚动", @"公司", @"基金", @"股市播报", @"大盘", @"交易提示", @"产经新闻", @"报刊头条", @"美股要闻", @"全球股市"];
    
    [self initTagsView];
    [self addControllers];

    [self initPageScrollView];
    
    SNNewsChildViewController *ctrl = [self.childViewControllers firstObject];
    [self.pageScrollView addSubview:ctrl.view];
    ctrl.view.frame = self.pageScrollView.frame;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tagsView.frame = CGRectMake(0, 0, self.view.width, 40);
    self.pageScrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

- (void)initTagsView {
    SBWS(__self);
    _tagsView = [[SNTagsView alloc] initWithChannelList:self.channelList];
    self.navigationItem.titleView = _tagsView;

    _tagsView.titleClick = ^(NSInteger tag) {
        CGFloat offsetX = tag * __self.pageScrollView.frame.size.width;
        CGFloat offsetY = __self.pageScrollView.contentOffset.y;
        CGPoint offset = CGPointMake(offsetX, offsetY);
        [__self.pageScrollView setContentOffset:offset animated:YES];
    };
}

- (void)initPageScrollView {
    _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_pageScrollView];
    
    CGFloat contentX = self.childViewControllers.count * self.view.width;
    self.pageScrollView.contentSize = CGSizeMake(contentX, 0);
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.pageScrollView.delegate = self;
}

- (void)addControllers {
    for (int i = 0; i < self.channelList.count; i++) {
        SNNewsChildViewController *ctrl = [[SNNewsChildViewController alloc] init];
        ctrl.channelNum = i;
        [self addChildViewController:ctrl];
    }
}

#pragma mark scrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / self.pageScrollView.width;
    SNNewsChildViewController *ctrl = self.childViewControllers[index];
    ctrl.channelNum = index;
    [self.tagsView titleAction:index];

    if (ctrl.view.superview) return;
    
    ctrl.view.frame = scrollView.bounds;
    [self.pageScrollView addSubview:ctrl.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
