/*
#####################################################################
# File    : EmptyTableCell.h
# Project : 
# Created : 2013-03-30
# DevTeam : Thomas Develop
# Author  : 
# Notes   :
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

#import "SBErrorTableCell.h"

/** 空数据单元格 */
@interface SBEmptyTableCell : SBErrorTableCell {
}
@end
/**  空数据单元格 不能点击 */
@interface SBEmptyNotClickCell : SBEmptyTableCell {
}
@end

/** 股吧全屏空单元格 */
@interface SBFullEmptyCell : SBEmptyTableCell {
}
@property (nonatomic, strong) UIImageView *emptyImageView;//空图片
@property (nonatomic, strong) UILabel *emptyTipsLbl;         //空提示

@end

//全屏不能点击空单元格
@interface SBFullEmptyNotClickCell :SBFullEmptyCell
@end

@interface SBFullErrorCell : SBFullEmptyCell
@end