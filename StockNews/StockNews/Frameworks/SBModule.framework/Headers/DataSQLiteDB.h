/*
#####################################################################
# File    : DataSQLiteDB.h
# Project : 
# Created : 2013-03-30
# DevTeam : 
# Author  : roronoa
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

#import <sqlite3.h>

/**
 *   1.该类用于操作SQLite数据库。
 *   2.该类已封装了一些基本的SQLite操作方法，包括执行SQL语句；使用绑定变量；查、增、删、改数据记录等。
 */
@interface DataSQLiteDB : NSObject 

/** 初始化数据库，不存在则创建 */
- (id)init:(NSString *)dbname;

/** 执行一句SQL，不返回数据 */
- (BOOL)execSQL:(NSString *)SQL;

/** 打开一个SQL查询语句的游标 */
- (sqlite3_stmt *)query:(NSString *)SQL;

/** 插入数据到指定表中 */
- (sqlite3_int64)insertData:(NSString *)tableName data:(NSDictionary *)data;

/** 删除指定表中符合条件的数据 */
- (int)deleteData:(NSString *)tableName whereParam:(NSString *)whereParam;

/** 更新一条数据库记录 */
- (int)updateData:(NSString *)tableName data:(NSDictionary *)data whereParam:(NSString *)whereParam;

/** 获取指定表中符合条件的数据条数 */
- (sqlite3_int64)tableRows:(NSString *)tableName whereParam:(NSString *)whereParam;

/** 判断数据库中是否存在某张表 */
- (BOOL)hasTable:(NSString *)tableName;

/** 获取列表数据，返回一个数据键值对的数组 */
- (NSArray *)getAllDBData:(NSString *)SQL;

/** 获取单条数据，返回一个对应的键值对 */
- (NSDictionary *)getColumnItem:(NSString *)SQL;

/** 获取一个数据单元中的数据 */
- (NSString *)getColumnText:(NSString *)SQL;

/** 绑定变量到一个SQL查询游标 */
- (BOOL)bind:(sqlite3_stmt *)pStmt data:(NSDictionary *)data;

/** 关闭数据库 */
- (void)closeDB;

/** 事务处理：开始事务处理 */
- (BOOL)beginEvent;

/** 事务处理：提交事务 */
- (BOOL)commitEvent;

/** 事务处理：回滚事务 */
- (BOOL)rollbackEvent;

/** 清空一张表 */
- (void)truncateTable:(NSString *)tableName;

/** 清理并压缩数据库 */
- (void)compressDB;

@end
