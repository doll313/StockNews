/*
 #####################################################################
 # File    : SBTimeManager.h
 # Project : StockBar
 # Created : 14/12/4
 # DevTeam : Thomas
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

//股吧时间控制器
@interface SBTimeManager : NSObject {
    
}

SB_ARC_SINGLETON_DEFINE(SBTimeManager);

@property (nonatomic, strong) NSDateFormatter *formatter;          //控制时间

/** 转换时间格式 **/
+ (NSString *)sb_formatStr:(NSString *)timeStr preFormat:(NSString *)preFormat newFormat:(NSString *)nowFormat;

/**统一的时间字符串*/
+ (NSString *)sb_formatDate:(NSDate *)date nowFormat:(NSString *)nowFormat;

/**统一的时间字符串 (现在时间)*/
+ (NSString *)sb_formatNowTime:(NSString *)nowFormat;

/**统一的时间字符串 股吧时间 传入 @"yyyy-MM-dd HH:mm:ss"  */
+ (NSString *)sb_formatStatusTime:(NSString *)timeStr;

/**统一的时间字符串 资讯其他渠道 传入 @"yyyy-MM-dd HH:mm:ss"  */
+ (NSString *)sn_otherChannel_formatStatusTime:(NSString *)timeStr ;

/**统一的时间字符串 （置顶帖）传入 @"yyyy-MM-dd HH:mm:ss" */
+ (NSString *)sb_formatTopStatusTime:(NSString *)timeStr;
@end
