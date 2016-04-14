//
//  EMConfig.h
//  东方财富通
//
//  Created by yuanrui on 14-1-28.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, EMConfigFileType) {
    EMConfigFileTypeJSON,
    EMConfigFileTypePlist,
    EMConfigFileTypeYaml
};

@interface EMConfig : NSObject

+ (EMConfig *)sharedConfig ;

/* 适配旧代码，就不删除这些properties了 */
@property (nonatomic, readonly, assign) BOOL jiaoYiGongCe ;
@property (nonatomic, readonly, assign) BOOL guessNotification;
@property (nonatomic, readonly, assign) BOOL stockAlarm;
@property (nonatomic, readonly, assign) BOOL simulateTrade;

/**
 加载配置文件
 
 @param path 文件路径
 @param type 文件类型，目前支持json, plist, yaml
 */
- (void)loadConfigFile:(NSString *)path ofType:(EMConfigFileType)type;

/**
 加载main bundle里面的配置文件
 
 @param fileName 文件名，包含后缀的
 */
- (void)loadConfigFileName:(NSString *)fileName;

/**
 清除所有的config
 */
- (void)clearAllConfig;

/**
 返回所有的mapping
 
 注意，这里不直接给出真正的mapping dictionary，只是给出它的一份
 immutable copy，防止真正的mapping dictionary在程序中被滥用。
 
 @return mapping
 */
- (NSDictionary *)configuredItems;

/* 一些常用的转换， 其余转换请使用objectForKey取得原始数据手动进行 */
- (id)objectForKey:(id<NSCopying>)key;
- (BOOL)boolForKey:(id<NSCopying>)key;
- (int)intForKey:(id<NSCopying>)key;
- (long)longForKey:(id<NSCopying>)key;
- (NSInteger)integerForKey:(id<NSCopying>)key;
- (float)floatForKey:(id<NSCopying>)key;
- (double)doubleForKey:(id<NSCopying>)key;
- (NSString *)stringForKey:(id<NSCopying>)key;

- (id)objectForKey:(id<NSCopying>)key defaultValue:(id)defaultValue;
- (BOOL)boolForKey:(id<NSCopying>)key defaultValue:(BOOL)defaultValue;
- (int)intForKey:(id<NSCopying>)key defaultValue:(int)defaultValue;
- (long)longForKey:(id<NSCopying>)key defaultValue:(long)defaultValue;
- (NSInteger)integerForKey:(id<NSCopying>)key defaultValue:(NSInteger)defaultValue;
- (float)floatForKey:(id<NSCopying>)key defaultValue:(float)defaultValue;
- (double)doubleForKey:(id<NSCopying>)key defaultValue:(double)defaultValue;
- (NSString *)stringForKey:(id<NSCopying>)key defaultValue:(NSString *)defaultValue;

@end
