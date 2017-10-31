//
//  NSString+HYCategory.h
//  Category
//
//  Created by wuhaiyang on 16/9/12.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#if __has_include(<HYTool/HYPathTool.h>)
#import <HYTool/HYPathTool.h>
#else
#import "HYPathTool.h"
#endif

NS_ASSUME_NONNULL_BEGIN

static const unichar HYUnicharNotFound = UCHAR_MAX;

@interface NSString (HYCategory)

#pragma mark - 空值判断
/**
 用于判断字符串的“空值”，包含常用的后台服务器返回的“空数据”

 @param string 需要判断的字符串
 @return YES:为空；NO:不为空

 备注：使用类方法而不是对象方法进行判断，是因为当对象为nil时，是不会调用对象方法的；
 */
+ (BOOL)hy_isNullString:(nullable NSString *)string;

#pragma mark - 计算文字显示区域大小-----
/**
 获取文本的范围

 @param area 显示的区域
 @param parameters 文本参数
 @return 范围
 */
- (CGSize)hy_getSizeAtArea:(CGSize)area parameters:(NSDictionary *)parameters;

/**
 获取文本显示的范围，显示区域没有限制，为最大区域

 @param parameters 文本参数
 @return 范围
 */
- (CGSize)hy_getSizeAtMaxAreaWithparameters:(NSDictionary *)parameters;

/**
 获取文本范围

 @param area 显示的区域
 @param font 字体
 @param color 颜色
 @return 范围
 */
- (CGSize)hy_getSizeAtArea:(CGSize)area font:(UIFont *)font color:(UIColor *)color;

/**
 获取文本范围

 @param font 字体
 @param color 颜色
 @return 范围
 */
- (CGSize)hy_getSizeAtMaxAreaWithFont:(UIFont *)font color:(UIColor *)color;
#pragma mark - 计算文字显示区域-----


/**
 *  NSString 转 NSNumber
 *  注意1：NSString内容为数字,默认会去除所有非数字字符（0123456789.）
 *  注意2：NSString只有含了一个“.”，才会转化成果，多个"."会导致转化失败
 */
- (NSNumber *)hy_numberValue;

#pragma mark - 过滤字符
/**
 *  过滤指定的字符集合，过滤的对立面是保留invertedSet；
 *
 *  @param set   需要过滤的字符集合
 *  常用的字符集合有：
 *  //---------------------------
 *  whitespaceCharacterSet//空格
 *  newlineCharacterSet//换行符
 *  whitespaceAndNewlineCharacterSet//空格和换行
 *  decimalDigitCharacterSet//数字
 *  letterCharacterSet//字母，包含大写和小写
 *  lowercaseLetterCharacterSet//小写字母
 *  uppercaseLetterCharacterSet//大写字母
 *  alphanumericCharacterSet//数字，字母，包含大写和小写字母
 *  //---------------------------
 *  controlCharacterSet//控制符
 *  nonBaseCharacterSet//非基础
 *  decomposableCharacterSet//可分解
 *  illegalCharacterSet//非法
 *  punctuationCharacterSet//标点符号
 *  capitalizedLetterCharacterSet//大写
 *  symbolCharacterSet//符号
 *  //---------------------------
 *
 *  @param isAll YES：过滤所有位置；NO：过滤首尾位置；
 *
 *  @return 过滤之后的字符串
 */
- (NSString *)hy_stringByTrimmingCharactersInSet:(NSCharacterSet *)set isAll:(BOOL)isAll;

/**
 过滤字符集合并且限制长度，比如密码的字符和长度限制，6-20位英文字母或数字

 @param set 需要过滤的字符集合，经常借助invertedSet获取保留的集合
 @param limit 字符的限制长度
 @return 处理后的字符串
 */
- (NSString *)hy_stringByTrimmingCharactersInSet:(NSCharacterSet *)set limitLength:(NSUInteger)limit;

#pragma mark - ASCII表和字符的映射
/**
 *  获取ASCII表中的字符
 *
 *  @param index 索引，0-127
 *
 *  @return 相应字符
 */
+ (NSString *)hy_stringByASCIIIndex:(unichar)index;

/**
 *  获取某个字符在ASCII表中的位置
 *
 *  @param string 字符，只能填入单个字符，多个字符取第一个字符的结果，空字符@""返回HYUnicharNotFound，也就是UCHAR_MAX；
 *
 *  @return 相应位置
 */
+ (unichar)hy_indexByASCIIString:(NSString *)string;

/**
 *  和方法hy_stringByASCIIIndex:等价
 */
@property (nonatomic, copy, readonly) NSString *hy_ASCIICharacter;

/**
 *  和方法hy_indexByASCIIString:等价
 */
@property (nonatomic, assign, readonly) unichar hy_ASCIIIndex;

#pragma mark - 字符获取
/**
 获取字符串的第一个字符
 
 @return nil表示没有获取到；
 */
- (nullable NSString *)hy_stringAtFirst;

/**
 获取字符串的最后一个字符

 @return nil表示没有获取到；
 */
- (nullable NSString *)hy_stringAtLast;

/**
 获取字符串index位置的字符

 @param index 索引位置，index超过length范围获取为nil
 @return nil表示没有获取到
 */
- (nullable NSString *)hy_stringAtIndex:(NSUInteger)index;

/**
 获取字符串range范围的字符

 @param range 范围，range超过length范围获取为nil
 @return nil表示没有获取到
 */
- (nullable NSString *)hy_stringInRange:(NSRange)range;

#pragma mark - 是否包含子字符串
/**
 字符串是否包含子字符串

 @param string 子字符串
 @return YES：包含；NO：不包含s
 */
- (BOOL)hy_containsString:(NSString *)string;


/**
 * 文字密锁方式
 */
+ (NSString *)hy_getLockStringWith:(NSString *)string;

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
+ (instancetype)hy_stringWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName;

#pragma mark - 去掉首位0的情况 -- TODO
//- (void)hy_removeZeroAtFirst;

#pragma mark - NSString 和 NSDictionary 互转

/**
 字典转字符串
 
 @param dictionary 字典
 @return 字符串
 */
+ (NSString *)hy_stringFromDictionary:(NSDictionary *)dictionary;

/**
 字符串转字典
 
 @param string 字符串
 @return 字典
 */
+ (NSDictionary *)hy_dictionaryFromString:(NSString *)string;

/**
 字符串转字典，等价于方法：
 + (NSDictionary *)hy_dictionaryFromString:(NSString *)string;
 */
@property (nonatomic, strong, readonly) NSDictionary *hy_dictionaryValue;


#pragma mark - NSString 和 NSData 互转
/**
 字符串转二进制数据
 */
@property (nonatomic, strong, readonly) NSData *hy_dataValue;


#pragma mark - NSString 和 NSArray 互转
/**
 字符串转数组
 */
@property (nonatomic, strong, readonly) NSArray *hy_arrayValue;


#pragma mark - NSString 和 NSDate 互转
/**
 字符串转日期

 @param formatter 日期格式
 @return NSDate
 */
- (NSDate *)hy_dateWithFormatter:(NSString *)formatter;

/**
 字符串转日期,日期格式为 yyyy-MM-dd HH:mm:ss

 @return NSDate
 */
- (NSDate *)hy_dateWithDefaultDateFormatter;


#pragma mark - NSString 和 c语言string 互转

/**
 c语言字符串转OC字符串

 @param cString c语言字符串
 @return OC字符串
 */
+ (NSString *)hy_stringFromCString:(const char *)cString;

/**
 OC字符串转c语言字符串

 @param string OC字符串
 @return c语言字符串
 */
+ (const char *)hy_cStringFromString:(NSString *)string;

/**
 OC字符串转c语言字符串，等价于方法：
 + (const char *)hy_cStringFromString:(NSString *)string;
 */
@property (nonatomic, readonly) const char *cString;

#pragma mark - 四舍五入相关处理

/**
 对数值的字符串形式进行四舍五入的相关处理
 
 @param roundingMode NSRoundingMode
 举例：
 // Rounding policies :
 // Original
 //    value 1.2  1.21  1.25  1.35  1.27
 // Plain    1.2  1.2   1.3   1.4   1.3     ---- 四舍五入
 // Down     1.2  1.2   1.2   1.3   1.2     ---- 舍弃
 // Up       1.2  1.3   1.3   1.4   1.3     ---- 进位
 // Bankers  1.2  1.2   1.2   1.4   1.3 
 
 @param scale 保留小数点位数
 举例：
 //value              RoundingMode          scale         result
 //--------------------------------------------------------------
 //1236.6345          NSRoundPlain            2           1236.63
 //1236.6355          NSRoundPlain            2           1236.64
 //--------------------------------------------------------------
 //1236.4345          NSRoundPlain            0           1236
 //1236.5345          NSRoundPlain            0           1237
 //--------------------------------------------------------------
 //1246.6345          NSRoundPlain           -2           1200
 //1256.6345          NSRoundPlain           -2           1300
 //--------------------------------------------------------------
 
 @param precision 是否保留原有的精度；即原来数值多少位，处理过后也是多少位；
 YES：保留；这种情况下：
 设置roundingMode和scale“没有”效果；
 roundingMode = NSRoundPlain；
 scale设置无效；可以传0；
 NO：不保留；这种情况下：
 设置roundingMode和scale“有”效果；
 
 @return 处理后的数值的字符串形式
 
 补充：使用此方法对字符串的形式有所限定，如下：
 1、传入正确的数字才可以转换；包含正负 + - ；数字 0-9 ；小数点 . ；
 2、如果存在非数字的字符，则从第一个非字符开始截断，后面的无法显示；
 3、对于 + 和 - ，只有在第一位才会起到正负的作用，其他的位置也会被当成字符，也会截断后面的字符；
 4、如果第一个字符就是非数字字符，结果为NaN；
 举例：
 //NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:@"+127.7308"]; //127.7308
 //NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:@"-127.7308"]; //-127.7308
 //NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:@"-127.7308f"]; //-127.7308
 //NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:@"-12f7.7308"]; //-12
 //NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:@"12+7.7308"]; //12
 //NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:@"-f127.7308"]; //0
 //NSDecimalNumber *deci = [NSDecimalNumber decimalNumberWithString:@"f-127.7308"]; //NaN

 */
- (NSString *)hy_roundedWithRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale fullPrecision:(BOOL)precision;

#pragma mark - 富文本
/**
 获取字符串的富文本字符串

 @param attrs 字符串的相关属性
 @return 富文本
 */
- (NSAttributedString *)hy_attributedStringWithAttributes:(nullable NSDictionary<NSString *, id> *)attrs;

/**
 获取给定字体和颜色的富文本字符串

 @param font 字体
 @param textColor 文字颜色
 @return 富文本
 */
- (NSAttributedString *)hy_attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor;

/**
 带有删除线的富文本字符串，常用于商品价格的折扣显示，删除线是“单实线”

 @return 带有删除线的富文本
 */
- (NSAttributedString *)hy_strikethroughAttributedString;

/**
 带有删除线的富文本字符串，常用于商品价格的折扣显示，删除线是“单实线”，颜色和textColor相同
 
 @param font 字体
 @param textColor 文字颜色
 @return 带有删除线的富文本
 */
- (NSAttributedString *)hy_strikethroughAttributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor;

#pragma mark - 货币，显示
/**
 货币/商品价格显示，保留两位小数
 
 @return 处理后的商品显示价格
 
 例子：
 120.205402 -> ￥120.21
 120 -> ￥120.00
 */
- (NSString *)hy_currencyString;

#pragma mark - 商品价格，原价、折扣价
/**
 商品的原价显示处理

 @return 商品原价
 */
- (NSString *)hy_originalPriceString;

/**
 商品的原件富文本显示处理

 @param font 字体
 @param textColor 文字颜色
 @return 原价的富文本显示
 */
- (NSAttributedString *)hy_originalPriceStringWithFont:(UIFont *)font textColor:(UIColor *)textColor;

/**
 商品的折扣价显示处理

 @return 折扣价的显示处理
 */
- (NSAttributedString *)hy_discountPriceString;

/**
 商品的折扣价显示处理

 @param font 字体
 @param textColor 文字颜色
 @return 折扣价的富文本显示
 */
- (NSAttributedString *)hy_discountPriceStringWithFont:(UIFont *)font textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
