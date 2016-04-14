//
//  EMServers.h
//  EMModuleUtility
//
//  Created by 贺颖远 on 15/6/25.
//
//

#import <Foundation/Foundation.h>


extern NSString * const __kemServerKeySSOSvr;//SSO登录服务器 @"sso.eastmoney.com";
extern NSString * const __kemServerKeyBARSvr;//股吧正式服务器 @"gubaapi.eastmoney.com/v3";
extern NSString * const __kemServerKeyPortSvr;//组合服务器 @"moniapi.eastmoney.com";
extern NSString * const __kemServerKeyFrontPage4PortSvr;//首页4个组合 @"newsapi.eastmoney.com/app/index_nzh.html";
extern NSString * const __kemServerKeyInfoListSvr;//资讯列表 @"newsapi.eastmoney.com/kuaixun/v2";
extern NSString * const __kemServerKeyInfoUtilitySvr;//资讯频道／收藏 @"mscstorage.eastmoney.com/Api";
extern NSString * const __kemServerKeyStockSchoolSvr;//股民学校 @"cp.eastmoney.com/GmxxMobileApi/gmxx/";
extern NSString * const __kemServerKeyInfoContentSvr;//资讯内容 @"newsapi.eastmoney.com/kuaixun/v2/api/content";
extern NSString * const __kemServerKeyInfoSelfSelContentSvr;//资讯自选研报内容 @"mineapi.eastmoney.com";
extern NSString * const __kemServerKeyInfoSelfSelNotificationListSvr;//资讯自选消息 @"mscstorage.eastmoney.com";
extern NSString * const __kemServerKeyDefaultUserHeadSvr;//用户头像地址 @"avator.eastmoney.com";
extern NSString * const __kemServerKeyInfoContentFirstAidSvr;//资讯内容非wifi网络请求失败再次请求地址 @"newsapi.eastmoney.com/kuaixun/v2/api/content";
extern NSString * const __kemServerKeyTradeSearchAddressSvr;//交易寻址地址 @"180.163.69.187";
extern NSString * const __kemServerKeyTradeSearchAddressSvrNeedOpen;//交易寻址地址是否打开 @"1";
extern NSString * const __kemServerDefaultGetABHMap;//ABH股对应关系文件 @"data.eastmoney.com/webapi/GetABHMap.html";

//服务器模型
@interface serverItem : NSObject<NSCopying> {
    
@public
    NSString * name;
    NSString * ip;
    NSString * port;
    NSInteger  type;
    NSTimeInterval Time;
    int velocityRank;
}

@property (nonatomic, strong) NSString * name, *ip, *port;
@property (nonatomic, assign) NSInteger type;
@property (assign) NSTimeInterval Time;

@property (nonatomic, assign) int velocityRank;

@end


@interface EMServers : NSObject
{
    NSMutableDictionary * __dicOfServers;
}

+ (EMServers *)Instance;        //单例

//更新服务器列表后使用此方法设置对应svrType的服务器地址
- (void)setServerURLStr:(NSString *)urlStr forType:(NSString *)svrType;

//获取sso服务器地址
- (NSString *)ssoServerURLString;

//股吧服务器地址
- (NSString *)barServerURLString;

//获取组合服务器地址
- (NSString *)portServerURLString;

//首页4个组合
- (NSString *)frontpage4PortServerURLString;

//资讯列表
- (NSString *)infoListServerURLString;

//资讯频道／收藏
- (NSString *)infoUtilityServerURLString;

//股民学校
- (NSString *)stockSchoolServerURLString;

//资讯内容
- (NSString *)infoContentServerURLString;

//资讯自选研报内容
- (NSString *)infoSelfSelContentServerURLString;

//资讯自选消息
- (NSString *)infoSelfSelNotificationListServerURLString;

//资讯内容请求失败之后，急救地址
- (NSString *)infoContentFirstAidServerURLString;

//交易寻址地址
- (NSString *)tradeSearchAddressServerURLString;

//交易寻址地址是否打开
- (NSString *)tradeSearchAddressNeedOpenServerURLString;

//ABHMap获取地址
- (NSString *)abhMapURLString;

//头像 默认120
+ (NSString *)portraitURLString:(NSString *)userId;
+ (NSString *)portraitURLString:(NSString *)userId size:(NSInteger)size;

@end
