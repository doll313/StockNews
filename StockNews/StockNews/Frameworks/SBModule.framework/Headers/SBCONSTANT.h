/*
 #####################################################################
 # File    : SBCONSTANT.h
 # Project :
 # Created : 14-2-14
 # DevTeam : eastmoney
 # Author  : Thomas
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>                         //UI
#import <QuartzCore/QuartzCore.h>               //绘制


//三方
#import "MBProgressHUD.h"           //hud
#import "MJRefresh.h"           //下拉刷新
#import "YAMLSerialization.h"       //yaml格式
#import "Masonry.h"             //自动布局
#import "WebImage.h"            // 下载图片

//数据库键值对宏
#import "STORE.h"
//单例
#import "SBObjectSingleton.h"

//股吧数据类
#import "DataItemDetail.h"
#import "DataItemResult.h"
//缓存数据库
#import "DataAppCacheDB.h"
//核心数据库
#import "DataAppCoreDB.h"
//文件管理
#import "SBFileManager.h"

//应用级别全局方法
#import "SBAppCoreInfo.h"

//网络
#import "SBHttpTask.h"
#import "SBHttpDataLoader.h"

//扩展
#import "UIView+SBMODULE.h" //视图扩展
#import "NSString+SBMODULE.h"   //字符串扩展
#import "Component+SBMODULE.h"      //一些空间的扩展
#import "UIBarButtonItem+SBMODULE.h"    //导航条按钮扩展
#import "UIButton+SBMODULE.h"           //按钮扩展
#import "UIImage+SBMODULE.h"            //图片扩展
#import "NSData+SBMODULE.h"         //数据扩展
#import "NSDate+SBMODULE.h"     //日期扩展
#import "NSObject+SBMODULE.h"
#import "NSDictionary+SBMODULE.h"       //字典扩展

//方法集合
#import "SBPureColorImageGenerator.h"       //纯色图
#import "SBURLAction.h"                 //界面跳转 （url形式）
#import "SBCrashManager.h"              //异常崩溃检测

//列表
#import "SBTableView.h"
#import "SBDataTableCell.h"
#import "SBErrorTableCell.h"
#import "SBEmptyTableCell.h"
#import "SBMoreTableCell.h"

#import "SBLoadingTableCell.h"
#import "SBFinishedTableCell.h"

#import "SBTitleCell.h"
#import "SBSwitchCell.h"

//图文标签，点击使用
#import "SBLinkLabel.h"
#import "NSAttributedString+Attributes.h"


#define N2S(num) [NSString stringWithFormat:@"%lu", (num ? (unsigned long)num : 0)]
// 应用程序常规数据加密密码
#define APPCONFIG_APP_DATA_ENCRYPT_PASS     @"APPCONFIG_APP_DATA_ENCRYPT_PASS"

// 数据库用到的常量
#define APPCONFIG_DB_FOLDER_NAME            @"ClientDB"       // 数据库存放目录
#define APPCONFIG_DB_CACHE_NAME             @"CacheData.db"       // 缓存数据库名
#define APPCONFIG_DB_CORE_NAME              @"CoreData.db"        // 核心数据库名
#define APPCONFIG_DB_DICT_NAME              @"DictData.db"        // 字典数据库名
#define APPCONFIG_DB_CODE_LIST_NAME         @"CodeListData.db"    // 码表数据库
#define APPCONFIG_CONN_ERROR_MSG_DOMAIN     @"SBHttpTaskError"  // 连接出错信息标志

//常用路径
#define APPCONFIG_PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]   //document目录

/** 色值 RGBA **/
#define RGB_A(r, g, b, a) [UIColor colorWithRed:(CGFloat)(r)/255.0f green:(CGFloat)(g)/255.0f blue:(CGFloat)(b)/255.0f alpha:(CGFloat)(a)]

/** 色值 RGB **/
#define RGB(r, g, b) RGB_A(r, g, b, 1)
#define RGB_HEX(__h__) RGB((__h__ >> 16) & 0xFF, (__h__ >> 8) & 0xFF, __h__ & 0xFF)

/** 弱引用自己 */
#define SBWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

// 应用程序版本检查
#define APPCONFIG_APP_MSG_RELOAD_INTERVAL   300                         // 提示信息多长事件重新刷新一次（当前定为5分钟，调试时可修改）。
#define APPCONFIG_APP_LOGIN_INTERVAL        900                         // 挂起多长时间后，激活时重新登录，单位秒（约定为15分钟，调试时可修改）。
#define APPCONFIG_APP_VERSION_INTERVAL      7200                        // 版本检测间隔时间，单位秒（约定值为2小时，调试时可修改）
#define APPCONFIG_APP_IMAGE_CACHE           86400                       // 图片缓存的秒数 (调试时可修改)
#define APPCONFIG_APP_ONEMINUTE_INTERVAL    60                          // 一分钟的秒数 (调试时可修改)
#define APPCONFIG_APP_ONEDAY_INTERVAL       86400                       // 一天的秒数 (调试时可修改)
#define APPCONFIG_APP_ONEMONTH_INTERVAL     2592000                     // 30天的秒数 (调试时可修改)
#define APPCONFIG_APP_TWOMONTH_INTERVAL     5184000                     // 60天的秒数 (调试时可修改)
#define APPCONFIG_APP_SIXMONTH_INTERVAL     15552000                    // 180天的秒数 (调试时可修改)

// UI控件常规像素
#define APPCONFIG_UI_TABLE_CELL_HEIGHT      44.0f                       // UITableView 单元格默认高度
#define APPCONFIG_UI_TIPS_SHOW_SECONDS      3.0f                        // 自动隐藏的弹窗，显示的时间（单位秒）
#define APPCONFIG_UI_STATUSBAR_HEIGHT       20.0f                       // 系统自带的状态条的高度
#define APPCONFIG_UI_NAVIGATIONBAR_HEIGHT   44.0f                       // 系统自带的导航条的高度
#define APPCONFIG_UI_TOOLBAR_HEIGHT         44.0f                       // 系统自带的工具条的高度
#define APPCONFIG_UI_TABBAR_HEIGHT          49.0f                       // 系统自带分页条的高度
#define APPCONFIG_UI_SEARCHBAR_HEIGHT       44.0f                       // 系统自带的搜索框的高度

#define APPCONFIG_UI_TABLE_PADDING          10.0f                       // UITableView 的默认边距
#define APPCONFIG_UI_WIDGET_PADDING          5.0f                       // 控件 的默认边距
#define APPCONFIG_UI_THUMBNAIL_BOARD        120.0f                      // 缩略图的长宽 的默认边距
#define APPCONFIG_UI_CELL_STATUS_PADDING    7.0f                        // 常用cell 背景边距
#define APPCONFIG_UI_STATUS_PADDING         12.0f                       //新版常用边距
#define APPCONFIG_UI_STATUS_SPACING         15.0f                       //间距



// UI 界面大小
#define APPCONFIG_UI_SCREEN_FHEIGHT             ([UIScreen mainScreen].bounds.size.height)              //界面的高度 iphone5 568 其他480
#define APPCONFIG_UI_SCREEN_FWIDTH              ([UIScreen mainScreen].bounds.size.width)               //界面的宽度 iphone 320
#define APPCONFIG_UI_CONTROLLER_FHEIGHT         (self.view.frame.size.height)                           //界面的高度 iphone5 548 其他460
#define APPCONFIG_UI_CONTROLLER_FWIDTH          APPCONFIG_UI_SCREEN_FWIDTH                              //界面的宽度 iphone 320
#define APPCONFIG_UI_VIEW_FHEIGHT               (self.frame.size.height)                                //界面的高度 iphone5 548 其他460
#define APPCONFIG_UI_VIEW_FWIDTH                APPCONFIG_UI_SCREEN_FWIDTH                              //界面的宽度 iphone 320
#define APPCONFIG_UI_SCREEN_SIZE                ([UIScreen mainScreen].bounds.size)         //屏幕大小

#define APPCONFIG_VERSION_OVER_5                 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0f)
#define APPCONFIG_VERSION_OVER_6                 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f)
#define APPCONFIG_VERSION_OVER_7                 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
#define APPCONFIG_VERSION_OVER_8                 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
#define APPCONFIG_VERSION_OVER_9                 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)


#define APPCONFIG_UNIT_LINE_WIDTH                (1/[UIScreen mainScreen].scale)       //常用线宽

#define APPCONFIG_AES_KEY                       @"l$LmR+s]7,=t^i+[#m!~]S.nCgKEh*mT"      //AES用的key（32位的）
#define APPCONFIG_LOGIN_DES_KEY                 @"b154054573c72ecd66ab57b1e35c0671"      //登录用的key


/** 全局调试开关
//#ifdef assert
//#undef assert
//#endif
//
//#define assert(x)
//#define NSLog(s, ...)
 */


