//
//  NSArray+HYCategory.h
//  HYKit
//
//  Created by wuhaiyang on 2016/11/17.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//  数组范围越界判断：index >= count 

#import <Foundation/Foundation.h>
#import <HYPathTool.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HYCategory)

#pragma mark - 空值判断
/**
 判断数组是否为空

 @param array 需要判断的数组
 @return YES:为空；NO:不为空
 */
+ (BOOL)hy_isNullArray:(nullable NSArray *)array;

#pragma mark - 写入和读取
/**
 写入到app沙盒的常用路径

 @param path 沙盒路径类型
 @param fileName 文件名称
 @return 成功/失败
 */
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName;

/**
 初始化方法，通过app沙盒文件进行初始化
 
 @param path 沙盒路径类型
 @param fileName 文件名称
 @return 实例
 */
+ (nullable instancetype)hy_arrayWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName;

/**
 查询、获取元素
 */
- (nullable id)hy_firstObject;
- (nullable id)hy_lastObject;
- (nullable id)hy_objectAtIndex:(NSUInteger)index;  //index超过数组范围，返回值为nil；系统的方法索引超过范围会崩溃
- (nullable NSArray *)hy_subarrayWithRange:(NSRange)range;//range超过数组范围，返回值为nil；系统的方法range超过范围会崩溃

- (nullable NSArray *)hy_reverseArray; //本身不会被反向、倒序；得到的新的数组是反向、倒序的；

#pragma mark - 排序
/**
 升序/降序排列

 @param ascending YES：升序；NO：降序；
 @return 排序之后的新的数组
 */
- (NSArray *)hy_sortByAscending:(BOOL)ascending;

/**
 对数组进行排序，针对数组模型

 @param descriptors 排序规则描述
 @return 排序之后的新的数组
 */
- (NSArray *)hy_sortByDescriptors:(nonnull NSArray<NSSortDescriptor *> *)descriptors;


#pragma mark - NSData 和 NSArray 互相转化
/**
 数组转二进制数据
 */
@property (nonatomic, strong, readonly) NSData *hy_dataValue;


@end


@interface NSMutableArray (HYCategory)

#pragma mark - 数组元素处理 ： 增/删/改/查/交换/倒序
#pragma mark - 对于数组的操作，涉及到“索引位置”时，如果“索引位置”超过范围，则操作失败，其他情况下默认是操作成功的；
/**
 增加元素方法，单个元素
 */
- (void)hy_addObjectAtFirst:(id)anObject;
- (void)hy_addObjectAtLast:(id)anObject;
- (void)hy_addObjectAtIndex:(NSUInteger)index object:(id)anObject; //如果index超过数组范围，操作失败

/**
 增加元素方法，多个元素
 */
- (void)hy_addObjectsAtFirst:(NSArray *)objects;
- (void)hy_addObjectsAtLast:(NSArray *)objects;
- (void)hy_addObjectsAtIndex:(NSUInteger)index objects:(NSArray *)objects; //如果index超过数组范围，操作失败

/**
 删除元素方法
 */
- (void)hy_removeObjectAtFirst; 
- (void)hy_removeObjectAtLast;
- (void)hy_removeObjectAtIndex:(NSUInteger)index; //如果index超过数组范围，操作失败;
- (void)hy_removeObjectsInRange:(NSRange)range; //如果range超过数组范围，操作失败
- (void)hy_removeObject:(id)anObject;
- (void)hy_removeObject:(id)anObject inRange:(NSRange)range;//如果range超过数组范围，操作失败
- (void)hy_removeAllObjects;

/**
 修改元素内容方法
 */
- (void)hy_replaceObjectAtFirstWithObject:(id)anObject; //如果数组为空，直接返回，操作失败
- (void)hy_replaceObjectAtLastWithObject:(id)anObject; //如果数组为空，直接返回，操作失败
- (void)hy_replaceObjectAtIndex:(NSUInteger)index WithObject:(id)anObject; //如果index超过数组范围，直接返回，操作失败

/**
 交换元素
 注意： index 和 otherIndex 若超过数组的范围的话，会直接返回，交换操作失败
       index 和 otherIndex 可以传相同的数值
 */
- (void)hy_exchangeObjectAtIndex:(NSUInteger)index withObjectAtIndex:(NSUInteger)otherIndex;

/**
 反向、倒序
 */
- (void)hy_reverse;  //本身被反向、倒序

@end

NS_ASSUME_NONNULL_END
