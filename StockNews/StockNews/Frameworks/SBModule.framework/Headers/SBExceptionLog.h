/*
 #####################################################################
 # File    : SBExceptionLog.h
 # Project : GubaModule
 # Created : 14/12/29
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
#import "SBObjectSingleton.h"

/** *  异常信息等级 */
typedef NS_ENUM(NSInteger, SBExcetionLevel){
    /** 没有异常需要上报*/
    SBExcetionLevelNone= 0,
    /** 仅仅只有网络api异常 */
    SBExcetionLevelOnlyAPI = 1,
    /** 仅仅只有程序崩溃异常 */
    SBExcetionLevelOnlyCrash = 2,
    /** 网络api异常+程序崩溃异常 */
    SBExcetionLevelAPIAndCrash = 3,
};

@class SBHttpTask;

//记录股吧的错误日子
@interface SBExceptionLog : NSObject {
}

SB_ARC_SINGLETON_DEFINE(SBExceptionLog);

/** 记录股吧的接口错误日志 */
+ (void)logSBHttpException:(SBHttpTask *)httpTask;

/** 记录股吧的崩溃日志 */
+ (void)logSBCrashException:(NSException *)exception;

/** 记录操作点 */
+ (void)recordOperation:(NSString *)operation;

/** 记录Ctrl堆栈 */
+ (void)recordCtrl:(NSString *)actionurl;

/** * 获取股吧的接口错误日志 */
+ (NSString *)getSBHttpException;

/** * 获取股吧的接口错误日志 */
+ (NSString *)getSBOperation;

@end
