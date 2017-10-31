//
//  NSArray+HYCategory.m
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "NSArray+HYCategory.h"
#import "NSData+HYCategory.h"
#import "NSString+HYCategory.h"

@implementation NSArray (HYCategory)

#pragma mark - 空值判断
+ (BOOL)hy_isNullArray:(NSArray *)array {
    if (array == nil || array.count == 0 || [array isKindOfClass:[NSNull class]] || array == NULL) {
        return YES;
    }
    return NO;
}

#pragma mark - 写入和读取
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return NO;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self writeToFile:name atomically:YES];
}

+ (instancetype)hy_arrayWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return nil;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self arrayWithContentsOfFile:name];
}

#pragma mark -  查询、获取元素
- (nullable id)hy_firstObject {
    return [self firstObject];
}

- (nullable id)hy_lastObject {
    return [self lastObject];
}

- (nullable id)hy_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) return nil;
    return [self objectAtIndex:index];
}

- (nullable NSArray *)hy_subarrayWithRange:(NSRange)range {
    NSUInteger endIndex = range.location + range.length - 1;
    if (endIndex >= self.count) return nil;
    return [self subarrayWithRange:range];
}

- (NSArray *)hy_reverseArray {
    return [[self reverseObjectEnumerator] allObjects];
}

#pragma mark - 排序
- (NSArray *)hy_sortByAscending:(BOOL)ascending {
    if ([NSArray hy_isNullArray:self]) return nil;
    return [self sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ascending ? [obj1 compare:obj2] : [obj2 compare:obj1];
    }];
}

- (NSArray *)hy_sortByDescriptors:(nonnull NSArray<NSSortDescriptor *> *)descriptors {
    if ([NSArray hy_isNullArray:self] || [NSArray hy_isNullArray:descriptors]) return nil;
    return [self sortedArrayUsingDescriptors:descriptors];
}

#pragma mark - NSData 和 NSArray 互相转化
- (NSData *)hy_dataValue {
    return [NSData hy_dataFromArray:self];
}

@end


@implementation NSMutableArray (HYCategory)

- (void)hy_addObjectAtFirst:(id)anObject {
    if (anObject == nil) return;
    [self insertObject:anObject atIndex:0];
}

- (void)hy_addObjectAtLast:(id)anObject {
    if (anObject == nil) return;
    [self addObject:anObject];
}

- (void)hy_addObjectAtIndex:(NSUInteger)index object:(id)anObject {
    if (index > self.count || anObject == nil)  return;
    [self insertObject:anObject atIndex:index];
}

- (void)hy_addObjectsAtFirst:(NSArray *)objects {
    if ([NSArray hy_isNullArray:objects]) return;
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, objects.count)];
    [self insertObjects:objects atIndexes:set];
}

- (void)hy_addObjectsAtLast:(NSArray *)objects {
    if ([NSArray hy_isNullArray:objects]) return;
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.count, objects.count)];
    [self insertObjects:objects atIndexes:set];
}

- (void)hy_addObjectsAtIndex:(NSUInteger)index objects:(NSArray *)objects {
    if (index > self.count || [NSArray hy_isNullArray:objects]) return;
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, objects.count)];
    [self insertObjects:objects atIndexes:set];
}

- (void)hy_removeObjectAtFirst {
    if (self.count == 0) return;
    [self removeObjectAtIndex:0];
}

- (void)hy_removeObjectAtLast {
    [self removeLastObject];
}

- (void)hy_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) return;
    [self removeObjectAtIndex:index];
}

- (void)hy_removeObjectsInRange:(NSRange)range {
    NSUInteger endIndex = range.location + range.length - 1;
    if (endIndex >= self.count) return;
    [self removeObjectsInRange:range];
}

- (void)hy_removeObject:(id)anObject {
    if (anObject == nil || self.count == 0) return;
    [self removeObject:anObject];
}

- (void)hy_removeObject:(id)anObject inRange:(NSRange)range {
    NSUInteger endIndex = range.location + range.length - 1;
    if (endIndex >= self.count) return;
    [self removeObject:anObject inRange:range];
}

- (void)hy_removeAllObjects {
    [self removeAllObjects];
}

- (void)hy_replaceObjectAtFirstWithObject:(id)anObject {
    if (self.count == 0 || anObject == nil) return;
    [self replaceObjectAtIndex:0 withObject:anObject];
}

- (void)hy_replaceObjectAtLastWithObject:(id)anObject {
    if (self.count == 0 || anObject == nil) return;
    [self replaceObjectAtIndex:self.count-1 withObject:anObject];
}

- (void)hy_replaceObjectAtIndex:(NSUInteger)index WithObject:(id)anObject {
    if (index >= self.count || anObject == nil) return ;
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)hy_exchangeObjectAtIndex:(NSUInteger)index withObjectAtIndex:(NSUInteger)otherIndex {
    if (MAX(index, otherIndex) >= self.count) return;
    id object = [self objectAtIndex:index];
    id otherObject = [self objectAtIndex:otherIndex];
    [self replaceObjectAtIndex:index withObject:otherObject];
    [self replaceObjectAtIndex:otherIndex withObject:object];
}

/**
 反向、倒序
 */
- (void)hy_reverse {
    //方案一： 以中间为轴，进行交换元素
//    NSUInteger count = self.count;
//    int mid = floor(count / 2.0);
//    for (NSUInteger i = 0; i < mid; i++) {
//        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
//    }
    //方案二： 系统方法，反向所有元素，移除所有元素，把反向得到的数组加入到“自己”中
    NSArray *temp = [[self reverseObjectEnumerator] allObjects];
    [self removeAllObjects];
    [self addObjectsFromArray:temp];
}

@end
