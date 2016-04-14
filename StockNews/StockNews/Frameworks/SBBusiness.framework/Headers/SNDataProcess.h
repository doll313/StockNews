/*
 #####################################################################
 # File    : SNDataProcess.h
 # Project : GubaModule
 # Created : 14-8-8
 # DevTeam : eastmoney
 # Author  : Thomas
 # Notes   : 资讯的网络请求
 #####################################################################
 ### Change Logs   ###################################################
 #####################################################################
 ---------------------------------------------------------------------
 # Date  :
 # Author:
 # Notes :
 # 测试地址 http://120.55.120.11
 #####################################################################
 */
#import <SBModule/SBHttpProcess.h>
@class SNDataLoader;

/**
 *  股吧帖子状态
 */
typedef NS_ENUM(NSInteger, EMNewsType){
    /** 为资讯正文 */
    EMNewsTypeNews = 1,
    /** 直播正文 */
    EMNewsTypeLive = 2,
    /** 股吧资讯 */
    EMNewsTypeStockNews = 3,
};

@interface SNDataProcess : SBHttpProcess

#pragma mark - 资讯列表相关接口
//获取要闻新接口 统一接口
+ (SBHttpDataLoader *)snget_important_news_list:(NSString *)min_id
                                     encode:(NSString *)encode
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate ;

//获取新闻新接口 统一接口
+ (SBHttpDataLoader *)snget_news_list:(NSString *)min_id
                           column:(NSString *)column
                         delegate:(id<SBHttpDataLoaderDelegate>)delegate;

//获取专题
+ (SBHttpDataLoader *)snget_simtopic:(NSString *)topicName
                            delegate:(id<SBHttpDataLoaderDelegate>)delegate ;

//获取用户的资讯频道
+ (SBHttpDataLoader *)snget_user_cannels:(NSString *)userId
                                delegate:(id<SBHttpDataLoaderDelegate>)delegate;
//设置用户的资讯频道
+ (SBHttpDataLoader *)snset_user_cannels:(NSString *)userId
                                 channels:(NSString *)channels
                                delegate:(id<SBHttpDataLoaderDelegate>)delegate;


#pragma mark - 资讯正文相关接口

/**
 获取资讯正文
 
 @param newsId   新闻ID
 @param newsType 1为资讯正文，2为直播正文
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)snget_news_content:(NSString *)newsId
                                      newsType:(EMNewsType)newsType
                                      delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 获取资讯正文 第一次失败之后调用的接口
 
 @param newsId   新闻ID
 @param newsType 1为资讯正文，2为直播正文
 @param delegate delegate
 
 @return SNDataLoader
 */
+ (SNDataLoader *)snget_news_firstAid_content:(NSString *)newsId
                                     newsType:(EMNewsType)newsType
                                     delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 收藏资讯正文
 
 @param newsId   新闻ID
 @param uid 用户id
 @param title 标题
 @param simTitle 手机标题
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)snset_fav_news:(NSString *)newsId
                                         title:(NSString *)title
                                         simTitle:(NSString *)simTitle
                                      uid:(NSString *)uid
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 取消收藏资讯正文
 
 @param newsId   新闻ID
 @param uid 用户id
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)snset_disfav_news:(NSString *)newsId
                                       uid:(NSString *)uid
                                      delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 资讯收藏列表
 
 @param uid 用户id
 @param p 页码
 @param ps 每页大小
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)snget_fav_news:(NSString *)uid
                                         ps:(NSInteger)ps
                                          p:(NSInteger)p
                                      delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 下载附件PDF
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sn_down_pdf:(NSString *)urlStr
                          delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  资讯研报内容 个股研报、行情研报 (不是自选里面的公告研报)
 *
 *  @param code 资讯
 */
+ (SNDataLoader *)snget_report_content:(NSString *)returnUrl
                              delegate:(id<SBHttpDataLoaderDelegate>)delegate;

//获取重大消息接口 统一接口
+ (SNDataLoader *)snget_bigNews_list:(NSString *)returnStr
                            delegate:(id<SBHttpDataLoaderDelegate>)delegate;

//股民学校
+ (SNDataLoader *)snget_stockSchool:(id<SBHttpDataLoaderDelegate>)delegate;

//获取首页组合四个section的数据
+ (SNDataLoader *)snget_getFrontPageGroup:(id)tableData;
@end
