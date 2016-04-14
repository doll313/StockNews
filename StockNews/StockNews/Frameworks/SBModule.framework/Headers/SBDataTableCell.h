/*
#####################################################################
# File    : SBDataTableCell.h
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

#import "SBCONSTANT.h"
#import "SBTableView.h"

//常用键值
#define __KEY_CELL_TITLE      @"<&__KEY_CELL_TITLE&>"           //表示标题
#define __KEY_CELL_VALUE      @"<&__KEY_CELL_VALUE&>"     //表示内容
#define __KEY_CELL_ICON      @"<&__KEY_CELL_ICON&>"     //表示图标
#define __KEY_CELL_CODE       @"<&__KEY_CELL_CODE&>"             //表示代码
#define __KEY_CELL_SKIN       @"<&__KEY_CELL_SKIN&>"             //表示皮肤

#define __KEY_CELL_EMPTY      @"<&__KEY_CELL_EMPTY&>"                //表示空数据
#define __KEY_CELL_SELECTED   @"<&__KEY_CELL_SELECTED&>"             //表示是否选中
#define __KEY_CELL_TAG        @"<&__KEY_CELL_TAG&>"                  //表示标记
#define __KEY_CELL_WIDTH      @"<&__KEY_CELL_WIDTH&>"               //单元格宽度
#define __KEY_CELL_HEIGHT     @"<&__KEY_CELL_HEIGHT&>"               //单元格高度


#define __KEY_SECTION_HEADER_HEIGHT        @"<&__KEY_SECTION_HEADER_HEIGHT&>"       //表示段头的高度
#define __KEY_SECTION_FOOTER_HEIGHT        @"<&__KEY_SECTION_FOOTER_HEIGHT&>"            //表示段尾的高度

#define __SB_FONT_TABLE_DEFAULT_TIPS           14.0f               //提示默认字体
#define __SB_COLOR_TABLE_DEFAULT_TIPS           RGB(0x88, 0x88, 0x88)          //提示默认颜色

@interface DataItemDetail (DataTableCell)

@property (getter = tableCellTag, setter = setTableCellTag:) int tag;

/** 设定单元格数据为空 */
- (void)setEmptyTableCell;

/** 设定单元格数据为空/不为空 */
- (void)setEmptyTableCell:(BOOL)isEmpty;

/** 单元格数据是否为空 */
- (BOOL)tableCellIsEmpty;

/** 设定单元格选中/未选中状态 */
- (void)setSelectedTableCell:(BOOL)isSelected;

/** 单元格是否被选中状态 */
- (BOOL)tableCellIsSelected;

/** 设定单元格标记 */
- (void)setTableCellTag:(int)tag;

/** 获取单元格标记 */
- (int)tableCellTag;

@end


@class SBDataTableCell;

@interface SBDataTableCell : UITableViewCell <SBTableViewCellDelegate>{
}

/** 单元格的表格视图，当单元格显示时会被重新赋值 */
@property (nonatomic,assign) SBTableView *table;

/** 单元格在表格中的位置，当单元格显示时会被重新赋值 */
@property (nonatomic,retain) NSIndexPath *indexPath;

/** 单元格对应的数据，当单元格显示时会被重新赋值 */
@property (nonatomic,retain) DataItemDetail *cellDetail;

/** 单元个所在的表格节点对应的节点数据 */
@property (nonatomic,retain) SBTableData *tableData;


//创建单元格
+ (id)createCell:(NSString *)reuseIdentifier;

/** 获取单元格的ID */
+ (NSString *)cellID:(SBTableView *)table;

//绑定单元格的控件
- (void)bindCellData;

@end
