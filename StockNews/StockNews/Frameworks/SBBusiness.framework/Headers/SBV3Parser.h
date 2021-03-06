/*
 #####################################################################
 # File    : SBV3Parser.h
 # Project : GubaModule
 # Created : 14/12/26
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

//V3接口解析  v1接口也用了这个解析方式
@interface SBV3Parser : NSObject

/** 解析v3的数据架构 **/
+ (DataItemResult *)parseV3Json:(NSData *)data;

@end
