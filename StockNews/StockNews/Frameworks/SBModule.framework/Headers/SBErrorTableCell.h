/*
#####################################################################
# File    : SBErrorTableCell.h
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

#import "SBDataTableCell.h"

@interface SBErrorTableCell : SBDataTableCell {
@protected
	UILabel *displayLabel;
    NSString *errorMessage;
}

@property (nonatomic, copy) NSString *errorMessage;

//加载错误数据
-(void)loadErrorMessage;

@end

