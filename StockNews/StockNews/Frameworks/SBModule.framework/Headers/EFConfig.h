//
//  EFConfig.h
//  EMProjJijin
//
//  Created by Thomas on 15/4/22.
//
//

/** 天天基金app 本地配置文件 */
@interface EFConfig : NSObject

SB_ARC_SINGLETON_DEFINE(EFConfig);

//配置信息
@property (nonatomic, strong) DataItemDetail *confitDetail;

/** 加载main bundle里面的配置文件 （只允许json） */
+ (void)loadConfigFileName:(NSString *)fileName;

/** 获取配置信息 */
+ (DataItemDetail *)getItem:(NSString *)key;

/** 获取全局配置信息 AppGlobal.json中 appConfig 节点的数据 */
+ (NSString *)getGlobalString:(NSString *)key;

/** 获取全局配置信息 AppGlobal.json中 appConfig 节点的数据 */
+ (int)getGlobalInt:(NSString *)key;

@end
