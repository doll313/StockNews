//
//  SBCommentView.m
//  IosDemo
//
//  Created by MengWang on 16/1/21.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBCommentView.h"
#import <SBBusiness/SBV3Process.h>
#import "SBCommentCell.h"
#import "SBCommentView+Private.h"

@interface SBCommentView()
@property (nonatomic, strong)UIButton *lookCommentBtn;
@property (nonatomic, assign)SBV3ReplysSort sortType;
@property (nonatomic, copy)  NSString *foward_count;   // 转发数，前面传过来的
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UIImageView *bottomLine;
@property (nonatomic, strong)UILabel *commentCountLbl;
@property (nonatomic, assign)BOOL isHotList;          // 是否热门
@end

@implementation SBCommentView

- (instancetype)initWithPostId:(NSString *)postid type:(NSInteger)type foward_count:(NSString *)foward_count {
    self = [super init];
    if (self) {
        _model = [[SBEmojiModel alloc] init];
        _sortType = SBV3ReplysSortASC;
        _foward_count = foward_count;
        _isHotList = NO;
        
        _tableView = [[SBTableView alloc] initWithStyle:NO];
        _tableView.ctrl = self.ctrl;
        _tableView.estimatedRowHeight = 80;
        [self addSubview:_tableView];
        
        [self initTopView];
        
        SBWS(__self);
        
        // request相关
        _tableView.requestData = ^(SBTableData *tableViewData) {
            return [SBV3Process sbget_mainpost_replys:postid type:type p:tableViewData.pageAt sort:__self.sortType delegate:tableViewData];
        };
        
        _tableView.receiveData = ^(SBTableView *tableView, SBTableData *tableViewData, DataItemResult *result) {
            if (result.hasError) {
                return;
            }
            
            NSArray *hotList = [(DataItemDetail *)result.resultInfo getArray:@"point_re"];
            if (hotList.count > 0 && tableViewData.pageAt == 1) {
                // 显示热门评论
                __self.isHotList = YES;
                
                DataItemResult *hotResult = [[DataItemResult alloc] init];
                hotResult.dataList = [hotList mutableCopy];
                [__self calculateHeight:hotResult];
                [tableViewData.tableDataResult appendItems:hotResult];
                
                SBTableData *sectionData = [[SBTableData alloc] init];
                sectionData.hasHeaderView = YES;
                sectionData.mDataCellClass = [SBCommentCell class];
                sectionData.hasFinishCell = YES;
                sectionData.httpStatus = SBTableDataStatusFinished;
                
                [__self calculateHeight:result];
                [sectionData.tableDataResult appendItems:result];
                [tableView addSectionWithData:sectionData];
                
                __self.commentCountLbl.text = [NSString stringWithFormat:@"评论 %@ 转发 %@", @(result.maxCount), __self.foward_count];
            } else {
            
                [__self calculateHeight:result];
                [tableViewData.tableDataResult appendItems:result];
            }
            __self.commentCountLbl.text = [NSString stringWithFormat:@"评论 %@ 转发 %@", @(result.maxCount), __self.foward_count];
        };
        
        _tableView.headerForSection = ^UIView *(SBTableView *tableView, NSInteger section) {
            if ([tableView dataOfSection:0].httpStatus != SBTableDataStatusFinished) {
                return nil;
            }
            return [__self initWithHeaderView:(section == 0 && __self.isHotList == YES) ? @"热门评论" : @"全部评论"];
        };
        
        _tableView.didSelectRow = ^(SBTableView *tableView, NSIndexPath *indexPath) {
            
        };
        
        SBTableData *sectionData = [[SBTableData alloc] init];
        sectionData.hasHeaderView = YES;
        sectionData.mDataCellClass = [SBCommentCell class];
        sectionData.hasFinishCell = YES;
        [_tableView addSectionWithData:sectionData];
        
        [sectionData loadData];
    }
    return self;
}

- (UIView *)initWithHeaderView:(NSString *)title {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showButton.frame = CGRectMake(10, 10, 54, 24);
    showButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [showButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [showButton setBackgroundColor:RGB(49,111,201)];
    [showButton setTitle:title forState:UIControlStateNormal];
    [headerView addSubview:showButton];
    
    return headerView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.topView.frame = CGRectMake(0, 0, self.width, 44);
    self.bottomLine.frame = CGRectMake(0, self.topView.height - 1, self.width, 1);

    self.tableView.frame = self.bounds;
    self.tableView.top = self.topView.bottom;
    self.tableView.height -= self.topView.height;
}

-(void)dealloc {
    
}

- (void)initTopView {
    _topView = [[UIView alloc] init];
    
    _commentCountLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentCountLbl.textColor = [UIColor blackColor];
    _commentCountLbl.font = [UIFont systemFontOfSize:13];
    _commentCountLbl.backgroundColor = [UIColor clearColor];
    [_topView addSubview:_commentCountLbl];
    
    _commentCountLbl.text = @"评论 0 转发 0";
    [_commentCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topView.mas_centerY);
        make.left.equalTo(@10);
    }];
    
    _lookCommentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _lookCommentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_lookCommentBtn setTitle:[NSString stringWithFormat:@"%@评论", (self.sortType == SBV3ReplysSortDES) ? @"最早" : @"最近"] forState:UIControlStateNormal];
    [_lookCommentBtn setTitleColor:RGB(49,111,201) forState:UIControlStateNormal];
    [_lookCommentBtn addTarget:self action:@selector(lookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_lookCommentBtn];
   
    [_lookCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topView.mas_centerY);
        make.right.equalTo(@-20);
    }];

    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t1_stock_tips_list_into"]];
    [_topView addSubview:arrow];
    
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@(_topView.centerY));
        make.width.and.height.equalTo(@10);
        make.right.equalTo(@-10);
    }];
    
    _bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t1_cell_seperate_line"]];
    [_topView addSubview:_bottomLine];
    
    [self addSubview:_topView];
}

- (void)lookCommentClick:(id)sender {
    if (self.sortType == SBV3ReplysSortASC) {
        self.sortType = SBV3ReplysSortDES;
        [_lookCommentBtn setTitle:@"最早评论" forState:UIControlStateNormal];
    } else {
        self.sortType = SBV3ReplysSortASC;
        [_lookCommentBtn setTitle:@"最近评论" forState:UIControlStateNormal];
    }
    [self refreshComments];
}

/** 刷新评论列表 */
- (void)refreshComments {
    // 之前数据全部清空，重新刷新数据
    [self.tableView clearTableData];
    
    SBTableData *sectionData = [[SBTableData alloc] init];
    sectionData.hasHeaderView = YES;
    sectionData.mDataCellClass = [SBCommentCell class];
    sectionData.hasFinishCell = YES;
    [_tableView addSectionWithData:sectionData];
    
    [sectionData refreshData];
}

@end