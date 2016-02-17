//
//  CoreStorage.h
//  sma11case
//
//  Created by sma11case on 15/8/18.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"
#import "SCModel.h"
#import "../ExternalsSource/ExternalsSource.h"
#import "../typedef.h"

extern NSString *const kDBColumnTypeText;
extern NSString *const kDBColumnTypeInteger;
extern NSString *const kDBColumnTypeFloat;
extern NSString *const kDBColumnTypeNumeric;
extern NSString *const kkDBColumnTypeDecimal;
extern NSString *const kDBColumnTypeBit;
extern NSString *const kDBColumnTypeBlob;
extern NSString *const kDBColumnTypeNull;

@interface SCDBModel : SCModel
@property (nonatomic, assign) int type;
@property (nonatomic, assign) UINT length;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id data;
@end

typedef void(^DataBaseUpdateBlock)(FMDatabase *database, BOOL state);
typedef void(^DataBaseQueryBlock)(FMDatabase *database, FMResultSet *rs);

id getDBNullValue(int type);
NSMutableDictionary *dictionaryToDBColumnNameAndTypes(NSDictionary *source);
NSString *SCDBModelGetColumnTypeString(SCDBModel *model);
NSString *SCDBModelToColumnNameAndTypeString(SCDBModel *model);
NSMutableDictionary *columnInfosToNSDictionary(NSArray *columnInfos);
NSMutableArray *FMDBResultToNSArray(FMResultSet *rs);

@interface FMResultSet(sma11case_shareClass)
- (NSMutableDictionary *)toDictionary;
- (NSMutableArray *)toColumnDetails;
@end

@interface CoreStorage : NSObject
@property (nonatomic, strong, readonly) NSString *dataBaseFilePath;
@property (nonatomic, strong, readonly) FMDatabase *fmdb;

#if IS_SMA11CASE_VERSION
typedef BOOL(^DataBaseFilterBlok)(FMDatabase *database, SEL selector, NSArray *params);
@property (nonatomic, strong) DataBaseFilterBlok dataBaseFilterBlock;
#endif

// @[sql, arg1, arg2, arg3, ...]
- (BOOL)executeUpdateWithSQL: (NSString *)sql params: (NSArray *)params block: (DataBaseUpdateBlock)block;
- (void)executeQueryWithSQL: (NSString *)sql params: (NSArray *)params block: (DataBaseQueryBlock)block;

- (BOOL)openDataBase: (NSString *)path;
- (BOOL)closeDataBase;

- (NSMutableArray *)queryAllTableNames;

- (BOOL)createDataTable: (NSString *)table fromDemoData: (NSDictionary *)data;
- (BOOL)createDataTable: (NSString *)table fromTypeList: (NSDictionary *)data;
- (BOOL)createDataTable: (NSString *)table columnName: (NSString *)name, ...;

- (BOOL)existsDataTable: (NSString *)table;
- (NSMutableDictionary *)getDataTableColumnInfo: (NSString *)table;
- (NSString *)getDataTableCreateSQLCMD: (NSString *)table;

- (BOOL)clearDataTable: (NSString *)table;
- (BOOL)removeDataTable: (NSString *)table;
- (BOOL)renameDataTable: (NSString *)table to: (NSString *)name;

- (BOOL)addColumnWithTable: (NSString *)table columnName: (NSString *)name;
- (BOOL)removeColumnWithTable: (NSString *)table columnName: (NSString *)name;
- (BOOL)renameColumnWithTable: (NSString *)table oldName: (NSString *)oName newName: (NSString *)nName;

- (NSUInteger)batchInsertWithTable: (NSString *)table columnData: (NSArray *)data;
- (BOOL)insertDataWithTable:(NSString *)table columnDetailData:(NSArray *)data;
- (BOOL)insertDataWithTable: (NSString *)table columnData: (NSDictionary *)data;
- (BOOL)updateDataWithTable: (NSString *)table indexName: (NSString *)iName indexData: (id)iData columnData: (NSDictionary *)data;
- (BOOL)autoUpdateWithTable: (NSString *)table columnData: (NSDictionary *)data indexName: (NSString *)name indexData: (id)iData;

- (NSMutableDictionary *)removeInvalidKeyWithTable: (NSString *)table data: (NSDictionary *)data;
- (BOOL)removeRowWithTable: (NSString *)table indexName: (NSString *)name indexData: (id)data;

- (BOOL)deleteDataWithTable: (NSString *)table indexName: (NSString *)iName indexData: (id)iData;

- (NSUInteger)rowsCountWithTable: (NSString *)table;
- (NSUInteger)rowsCountWithTable: (NSString *)table indexName: (NSString *)name indexData: (id)data;
- (BOOL)existsRowWithTable: (NSString *)table indexName: (NSString *)name indexData: (id)data;

- (NSMutableDictionary *)queryDataWithTable: (NSString *)table indexName: (NSString *)iName indexData: (id)iData;
- (NSMutableArray *)queryColumnDetailWithTable: (NSString *)table indexName: (NSString *)iName indexData: (id)iData;

- (NSMutableArray *)queryAllDataFromTable:(NSString *)table;
- (NSMutableArray *)queryAllColumnDetailFromTable: (NSString *)table;

- (NSMutableArray *)queryWithSQL: (NSString *)sql params: (NSArray *)params;
- (NSMutableArray *)queryDetailWithSQL: (NSString *)sql params: (NSArray *)params;
@end


