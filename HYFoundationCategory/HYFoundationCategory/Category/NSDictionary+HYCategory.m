//
//  NSDictionary+HYCategory.m
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "NSDictionary+HYCategory.h"
#import "NSString+HYCategory.h"
#import "NSData+HYCategory.h"
#import "NSObject+HYCategory.h"

@implementation NSDictionary (HYCategory)

#pragma mark - 空值判断
+ (BOOL)hy_isNullDictionary:(NSDictionary *)dict {
    if (dict == nil || [[dict allKeys] count] == 0 || [dict isKindOfClass:[NSNull class]] || dict == NULL) {
        return YES;
    }
    return NO;
}

#pragma mark - 取值
- (nullable id)hy_objectForKey:(NSString *)aKey {
    if ([NSString hy_isNullString:aKey]) return nil;
    id value = [self objectForKey:aKey];
    return [NSObject hy_isNull:value] ? nil : value;
}

#pragma mark - 写入和读取
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return NO;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self writeToFile:name atomically:YES];
}

+ (instancetype)hy_dictionaryWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return nil;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self dictionaryWithContentsOfFile:name];
}

#pragma mark - NSString 和 NSDictionary 互转
+ (NSString *)hy_stringFromDictionary:(NSDictionary *)dictionary {
    if ([NSDictionary hy_isNullDictionary:dictionary]) return nil;
    NSData *data = [NSData hy_dataFromDictionary:dictionary];
    return [NSData hy_stringFromData:data];
}

+ (NSDictionary *)hy_dictionaryFromString:(NSString *)string {
    if ([NSString hy_isNullString:string]) return nil;
    NSData *data = [NSData hy_dataFromString:string];
    return [NSData hy_dictionaryFromData:data];
}

- (NSString *)hy_stringValue {
    return [NSDictionary hy_stringFromDictionary:self];
}

#pragma mark - NSData 和 NSDictionary 互转
- (NSData *)hy_dataValue {
    return [NSData hy_dataFromDictionary:self];
}


@end


@implementation NSMutableDictionary (HYCategory)

- (void)hy_setObject:(id)anObject forKey:(NSString *)aKey {
    [self hy_setObject:anObject forKey:aKey nullOption:[NSNull null]];
}

- (void)hy_setObject:(id)anObject forKey:(NSString *)aKey nullOption:(id)nullOptionObject {
    if ([NSString hy_isNullString:aKey]) return;
    [self setObject:anObject != nil ? anObject : nullOptionObject != nil ? nullOptionObject : [NSNull null] forKey:aKey];
}

@end

