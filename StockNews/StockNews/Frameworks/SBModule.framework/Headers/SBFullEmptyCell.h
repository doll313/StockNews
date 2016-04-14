/*
 #####################################################################
 # File    : SBFullEmptyCell.h
 # Project : StockBar
 # Created : 14-6-18
 # DevTeam : Thomas
 # Author  : Thomas
 # Notes   : 股吧全屏空单元格
 #####################################################################
 ### Change Logs   ###################################################
 #####################################################################
 ---------------------------------------------------------------------
 # Date  :
 # Author:
 # Notes :
 #
 #####################################################################
 */

#import "SBEmptyTableCell.h"


/**
 *  股吧全屏空单元格
 */
@interface SBFullEmptyCell : SBEmptyTableCell {
}
@property (nonatomic, strong) UIImageView *emptyImageView;//空图片
@property (nonatomic, strong) UILabel *emptyTipsLbl;         //空提示
@property (nonatomic, strong) UIButton *emptyNextBtn;            //空界面的按钮

@end


//全屏不能点击空单元格
@interface SBFullEmptyNotClickCell :SBFullEmptyCell

@end
