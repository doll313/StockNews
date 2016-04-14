/*
 #####################################################################
 # File    : TableView.h
 # Project : 
 # Created : 2013-03-30
 # DevTeam : thomas only one
 # Author  : roronoa
 # Notes   : 封装tableview
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

#import "SBTableData.h"               //列表数据

//TableView 中用到的 UITableViewCell 协议
@protocol SBTableViewCellDelegate <NSObject>
@required

/** 单元格的表格视图，当单元格显示时会被重新赋值 */
@property (nonatomic,assign) SBTableView *table;

/** 单元格在表格中的位置，当单元格显示时会被重新赋值 */
@property (nonatomic,retain) NSIndexPath *indexPath;

/** 单元格对应的数据，当单元格显示时会被重新赋值 */
@property (nonatomic,retain) DataItemDetail *cellDetail;

/** 单元个所在的表格节点对应的节点数据 */
@property (nonatomic,retain) SBTableData *tableData;

/** 绑定数据到单元格上的UI，单元格显示时会被调用 */
- (void)bindCellData;

/** 获取一个新的单元格 */
+ (id)createCell:(NSString *)reuseIdentifier;

/** 获取单元格的ID */
+ (NSString *)cellID:(SBTableView *)table;

@end

#pragma mark -
#pragma mark 回调接口
// 网络请求
typedef void (^tableViewDataBlock)(SBTableData *tableViewData);

// 网络请求
typedef SBHttpDataLoader *(^requestDataBlock)(SBTableData *tableViewData);

// 网络加载数据完成时触发的事件
typedef void (^receiveDataBlock)(SBTableView *tableView, SBTableData *tableViewData, DataItemResult *result);

//加载完成时的回调
typedef void (^cacheLoadBlock)(SBTableView *tableView, SBTableData *tableViewData, DataItemResult *result);

//滑动
typedef void (^scrollDelegateBlock)(UIScrollView *scroll);

// 处理单元格
typedef void (^operateRowBlock)(SBTableView *tableView, NSIndexPath *indexPath);

// 能否处理单元格
typedef BOOL (^canOperateRowBlock)(SBTableView *tableView, NSIndexPath *indexPath);

// 单元格高度
typedef CGFloat (^heightForRowBlock)(SBTableView *tableView, NSIndexPath *indexPath);

// 显示单元格
typedef void (^showRowBlock)(SBTableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

// 单元格高度
typedef UIView *(^viewForSectionBlock)(SBTableView *tableView, NSInteger section);

// 编辑单元格
typedef BOOL (^commitEditRowBlock)(SBTableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);

// 临时修改单元格的显示样式
typedef Class(^modifiRowClassBlock)(SBTableView *tableView, Class<SBTableViewCellDelegate> originClass, NSIndexPath *indexPath);

// 移动某行
typedef void (^moveRowToIndexBlock)(SBTableView *tableView, NSIndexPath *fromindexPath, NSIndexPath *toIndexPath);

// 处理网络载入错误
typedef void (^errorHandleBlock)(SBTableView *tableView, SBTableData *section);

// 列表手势处理
typedef void (^tapGestureBlock)(SBTableView *table);

// 空单元格点击事件
typedef void (^clickEmptyCellBlock)(SBTableData *tableViewData);


#pragma mark -
#pragma mark 分装列表类
/** 该类用于 UITableView 表格二次封装显示 */
@interface SBTableView : UITableView <UITableViewDelegate, UITableViewDataSource> {
@private
    
}

/** 一般对应列表所在的viewctroller **/
@property (nonatomic, assign) UIViewController *ctrl;

/** 是否是下拉类型的列表 */
@property (nonatomic, assign) BOOL isRefreshType;

/** 扩展一个列表的节点，做应急用，请不要随意使用这个节点 **/
@property (nonatomic, assign) int emunTag;

// 将要发起网络请求
@property (nonatomic, strong) NSMutableArray *arrTableData;                     //列表数据

// 将要发起网络请求
@property (nonatomic, copy) tableViewDataBlock willRequestData;
// 发起网络请求
@property (nonatomic, copy) requestDataBlock requestData;
// 接受网络数据
@property (nonatomic, copy) receiveDataBlock receiveData;
// cache加载完成时的block
@property (nonatomic, copy) cacheLoadBlock cacheLoad;
// 点击单元格
@property (nonatomic, copy) operateRowBlock didSelectRow;
// 点击更多单元格
@property (nonatomic, copy) operateRowBlock didSelectMore;
// 单元格高度
@property (nonatomic, copy) heightForRowBlock heightForRow;
// 段的头部视图
@property (nonatomic, copy) viewForSectionBlock headerForSection;
// 段的尾部视图
@property (nonatomic, copy) viewForSectionBlock footerForSection;
// 能否编辑单元格
@property (nonatomic, copy) canOperateRowBlock canEditRow;
//删除Row数据之前执行
@property (nonatomic, copy) commitEditRowBlock preCommitEditRow;
//删除Row数据 默认是 [self removeCell:]，如果实现了这个block则覆盖默认行为
@property (nonatomic, copy) commitEditRowBlock commitEditRow;
//删除Row之后执行
@property (nonatomic, copy) commitEditRowBlock postCommitEditRow;
// 点击箭头
@property (nonatomic, copy) operateRowBlock tapAccessoryButton;
// 临时修改单元格的显示样式
@property (nonatomic, copy) modifiRowClassBlock modifiRowClass;
// 临时修改单元格背景
@property (nonatomic, copy) showRowBlock willDisplayRow;
// scrollview delegate引出
@property (nonatomic, copy) scrollDelegateBlock scrollViewDidScroll;
// 移动单元格
@property (nonatomic, copy) canOperateRowBlock canMoveRow;
// 移动单元格回调
@property (nonatomic, copy) moveRowToIndexBlock moveRowToIndex;
// 网络异常处理
@property (nonatomic, copy) errorHandleBlock errorHandle;
// 结束滑动
@property (nonatomic, copy) tapGestureBlock endDecelerating;
// 开始拖动
@property (nonatomic, copy) tapGestureBlock willBeginDragging;
// 结束拖动
@property (nonatomic, copy) tapGestureBlock willEndDragging;
// 空单元格点击事件
@property (nonatomic, copy) clickEmptyCellBlock emptyCellClicked;


/** 初始化表格，isGrouped为YES时，表示初始化一个圆角表格 */
- (id)initWithStyle:(BOOL)isGrouped;

/**  表格初始化，会在initWithStyle:时调用 */
- (void)customInit;

/** 为表格添加一个表格段 */
- (void)addSectionWithData:(SBTableData *)sectionData;

/** 删除一个表格段 */
- (void)removeSection:(NSUInteger)section;

/** 删除一个单元格  ui和 数据上  */
- (void)removeCell:(NSIndexPath *)indexPath;
- (void)removeCell:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation;

/** 获取指定表格段的数据 */
- (SBTableData *)dataOfSection:(NSInteger)section;

/** 获取指定单元格的数据 */
- (DataItemDetail *)dataOfIndexPath:(NSIndexPath *)indexPath;

/** 获取指定单元格的数据 */
- (DataItemDetail *)dataOfCellTag:(NSInteger)cellTag;

/** 清除所有表内容 */
- (void)clearTableData;

@end
