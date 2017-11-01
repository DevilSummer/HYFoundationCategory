//
//  NSObject+HYCategory.m
//  HYKit
//
//  Created by wuhaiyang on 2017/2/15.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import "NSObject+HYCategory.h"
#import <objc/runtime.h>
#import "NSString+HYCategory.h"
#import "NSArray+HYCategory.h"
#import "NSDictionary+HYCategory.h"
#import "NSData+HYCategory.h"

@implementation NSObject (HYCategory)

#pragma mark - 私有方法
//将NSDictionary中的Null类型的项目转化成@""
+ (NSDictionary *)nullDic:(NSDictionary *)myDic{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++){
        id obj = [myDic objectForKey:keyArr[i]];
        obj = [self changeType:obj];
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSArray中的Null类型的项目转化成@""
+ (NSArray *)nullArr:(NSArray *)myArr{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++){
        id obj = myArr[i];
        obj = [self changeType:obj];
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+ (NSString *)stringToString:(NSString *)string{
    return string;
}

//将Null类型的项目转化成@""
+ (NSString *)nullToString{
    return @"";
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+ (id)changeType:(id)myObj{
    if ([myObj isKindOfClass:[NSDictionary class]]){
        return [self nullDic:myObj];
    } else if([myObj isKindOfClass:[NSArray class]]){
        return [self nullArr:myObj];
    } else if([myObj isKindOfClass:[NSString class]]){
        return [self stringToString:myObj];
    } else if([myObj isKindOfClass:[NSNull class]]){
        return [self nullToString];
    } else {
        return myObj;
    }
}

+ (BOOL)hy_isNull:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        return [NSString hy_isNullString:object];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [NSArray hy_isNullArray:object];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        return [NSDictionary hy_isNullDictionary:object];
    } else if ([object isKindOfClass:[NSData class]]) {
        return [NSData hy_isNullData:object];
    } else if ([object isKindOfClass:[NSNull class]] || object == [NSNull null]) {
        return YES;
    } else {
        return object == nil;
    }
}

+ (NSString *)hy_className {
    return NSStringFromClass([self class]);
}

- (NSString *)hy_className {
    return NSStringFromClass([self class]);
}

@end
