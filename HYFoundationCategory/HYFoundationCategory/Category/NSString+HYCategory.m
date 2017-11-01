//
//  NSString+HYCategory.m
//  Category
//
//  Created by wuhaiyang on 16/9/12.
//  Copyright © 2016年 wuhaiyang. All rights reserved.
//

#import "NSString+HYCategory.h"
#import "NSObject+HYCategory.h"
#import "NSData+HYCategory.h"
#import "NSNumberFormatter+HYCategory.h"
#import "NSDate+HYCategory.h"

@implementation NSString (HYCategory)

+ (BOOL)hy_isNullString:(NSString *)string {
    if (string == nil ||
        string.length == 0 ||
        [string isEqualToString:@"NULL"] ||
        [string isEqualToString:@"Null"] ||
        [string isEqualToString:@"null"] ||
        [string isEqualToString:@"(NULL)"] ||
        [string isEqualToString:@"(Null)"] ||
        [string isEqualToString:@"(null)"] ||
        [string isEqualToString:@"<NULL>"] ||
        [string isEqualToString:@"<Null>"] ||
        [string isEqualToString:@"<null>"] ||
        [string isKindOfClass:[NSNull class]] ||
        string == NULL) {
        return YES;
    }
    return NO;
}


- (CGSize)hy_getSizeAtArea:(CGSize)area parameters:(NSDictionary *)parameters {
    if ([NSObject hy_isNull:parameters]) return CGSizeZero;
    return [self boundingRectWithSize:area options:NSStringDrawingUsesLineFragmentOrigin attributes:parameters context:nil].size;
}

- (CGSize)hy_getSizeAtMaxAreaWithparameters:(NSDictionary *)parameters {
    return [self hy_getSizeAtArea:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) parameters:parameters];
}

- (CGSize)hy_getSizeAtArea:(CGSize)area font:(UIFont *)font color:(UIColor *)color {
    return [self hy_getSizeAtArea:area parameters:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
}

- (CGSize)hy_getSizeAtMaxAreaWithFont:(UIFont *)font color:(UIColor *)color {
    return [self hy_getSizeAtArea:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:font color:color];
}


- (NSNumber *)hy_numberValue {
    NSMutableCharacterSet *set = [NSMutableCharacterSet decimalDigitCharacterSet];
    [set addCharactersInString:@"."];
    NSString *temp = [self hy_stringByTrimmingCharactersInSet:[set invertedSet] isAll:YES];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [temp length] == 0 ? nil : [numberFormatter numberFromString:temp];
}


- (NSString *)hy_stringByTrimmingCharactersInSet:(NSCharacterSet *)set isAll:(BOOL)isAll {
    if (self.length <= 0) return nil;
    if (isAll) {
        NSMutableString *string = [NSMutableString string];
        for (NSUInteger i = 0; i < self.length; i++) {
            unichar ch = [self characterAtIndex:i];
            if (![set characterIsMember:ch]) {
                [string appendString:[NSString stringWithUTF8String:(char *)&ch]];
            }
        }
        return string;
    } else {
        return [self stringByTrimmingCharactersInSet:set];
    }
}

- (NSString *)hy_stringByTrimmingCharactersInSet:(NSCharacterSet *)set limitLength:(NSUInteger)limit {
    NSString *str = [self hy_stringByTrimmingCharactersInSet:set isAll:YES];
    return str.length > limit ? [str substringToIndex:limit] : str;
}


+ (NSString *)hy_stringByASCIIIndex:(unichar)index {
    return [NSString stringWithUTF8String:(char *)&index];
}

+ (unichar)hy_indexByASCIIString:(NSString *)string {
    if ([NSString hy_isNullString:string]) return HYUnicharNotFound;
    return [string characterAtIndex:0];
}

- (NSString *)hy_ASCIICharacter {
    if ([NSString hy_isNullString:self]) return nil;
    return [self substringToIndex:1];
}

- (unichar)hy_ASCIIIndex {
    if ([NSString hy_isNullString:self]) return HYUnicharNotFound;
    return [self characterAtIndex:0];
}

- (NSString *)hy_stringAtFirst {
    if ([NSString hy_isNullString:self]) return nil;
    return [self substringToIndex:1];
}

- (NSString *)hy_stringAtLast {
    if ([NSString hy_isNullString:self]) return nil;
    return [self substringFromIndex:self.length - 1];
}

- (NSString *)hy_stringAtIndex:(NSUInteger)index {
    if ([NSString hy_isNullString:self] || index >= self.length) return nil;
    return [self substringWithRange:NSMakeRange(index, 1)];
}

- (NSString *)hy_stringInRange:(NSRange)range {
    NSUInteger endIndex = range.location + range.length - 1;
    if ([NSString hy_isNullString:self] || endIndex >= self.length) return nil;
    return [self substringWithRange:range];
}

#pragma mark - 是否包含子字符串
- (BOOL)hy_containsString:(NSString *)string {
    if ([NSString hy_isNullString:string] || [NSString hy_isNullString:self]) return NO;
    NSRange range = [self rangeOfString:string];
    return range.location == NSNotFound ? NO : YES;
}

/**
 * 文字密锁方式
 */
+ (NSString *)hy_getLockStringWith:(NSString *)string {
    NSMutableString *result = [NSMutableString string];
    if (string.length >= 6) {
        NSString *headString = [string substringToIndex:2];
        NSString *backString = [string substringFromIndex:string.length - 3];
        [result appendFormat:@"%@", headString];
        for (int i = 0; i < string.length - 2 - 3; i++) {
            [result appendString:@"*"];
        }
        [result appendFormat:@"%@", backString];
    }else if (string.length == 5){
        NSString *headString = [string substringToIndex:2];
        NSString *backString = [string substringFromIndex:string.length - 2];
        result = [NSMutableString stringWithFormat:@"%@*%@", headString, backString];
    }else if (string.length == 4 ){
        NSString *headString = [string substringToIndex:1];
        NSString *backString = [string substringFromIndex:string.length - 1];
        result = [NSMutableString stringWithFormat:@"%@**%@", headString, backString];
    }else if (string.length == 3){
        NSString *headString = [string substringToIndex:1];
        NSString *backString = [string substringFromIndex:string.length - 1];
        result = [NSMutableString stringWithFormat:@"%@*%@", headString, backString];
    }else if (string.length == 2){
        NSString *backString = [string substringFromIndex:string.length - 1];
        result = [NSMutableString stringWithFormat:@"*%@", backString];
    }else {
        result = [NSMutableString stringWithFormat:@"*"];
    }
    return result;
}

#pragma mark - 暂不使用 -----------------------------------
#pragma mark - 判断是否含有emoji表情
+ (BOOL)hy_stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

#pragma mark - 过滤emoji表情
- (instancetype)hy_removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring hy_isEmoji])? @"": substring];
                          }];
    return buffer;
}

#pragma mark - 是不是emoji表情
- (BOOL)hy_isEmoji {
    const unichar high = [self characterAtIndex: 0];
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}
#pragma mark - 暂不使用 -----------------------------------


#pragma mark - 写入和读取
- (BOOL)hy_writeToFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return NO;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [self writeToFile:name atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (instancetype)hy_stringWithContentsOfFileWithPath:(HYAPPSandboxPath)path fileName:(NSString *)fileName {
    if ([NSString hy_isNullString:fileName]) return nil;
    NSString *name = [HYPathTool hy_getAPPSandboxPathWithType:path fileName:fileName];
    return [NSString stringWithContentsOfFile:name encoding:NSUTF8StringEncoding error:nil];
}

#pragma mark - 去掉首位0的情况


#pragma mark - NSString 和 NSDictionary 互转
+ (NSString *)hy_stringFromDictionary:(NSDictionary *)dictionary {
    NSData *data = [NSData hy_dataFromDictionary:dictionary];
    return [NSData hy_stringFromData:data];
}

+ (NSDictionary *)hy_dictionaryFromString:(NSString *)string {
    NSData *data = [NSData hy_dataFromString:string];
    return [NSData hy_dictionaryFromData:data];
}

- (NSDictionary *)hy_dictionaryValue {
    return [NSString hy_dictionaryFromString:self];
}

#pragma mark - NSString 和 NSData 互转
- (NSData *)hy_dataValue {
    return [NSData hy_dataFromString:self];
}

#pragma mark - NSString 和 NSArray 互转
- (NSArray *)hy_arrayValue {
    NSData *data = [NSData hy_dataFromString:self];
    return [NSData hy_arrayFromData:data];
}

#pragma mark - NSString 和 NSDate 互转
- (NSDate *)hy_dateWithFormatter:(NSString *)formatter {
    if ([NSString hy_isNullString:self]) return nil;
    return [NSDate hy_dateWithString:self formatter:formatter];
}

- (NSDate *)hy_dateWithDefaultDateFormatter {
    return [self hy_dateWithFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark - NSString 和 c语言string 互转
+ (NSString *)hy_stringFromCString:(const char *)cString {
    if (cString == nil || cString == NULL) return nil;
    return [NSString stringWithUTF8String:cString];
}

+ (const char *)hy_cStringFromString:(NSString *)string {
    if ([NSString hy_isNull:string]) return nil;
    return [string cStringUsingEncoding:NSUTF8StringEncoding];
}

- (const char *)cString {
    return [NSString hy_cStringFromString:self];
}

#pragma mark - 四舍五入相关处理
- (NSString *)hy_roundedWithRoundingMode:(NSRoundingMode)roundingMode scale:(short)scale fullPrecision:(BOOL)precision {
    if ([NSString hy_isNull:self]) return nil;
    NSDecimalNumberHandler *handler;
    if (precision) {
        handler = [NSDecimalNumberHandler defaultDecimalNumberHandler];
    } else {
        handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    }
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *result = [number decimalNumberByRoundingAccordingToBehavior:handler];
    return result.stringValue;
}

#pragma mark - 富文本
- (NSAttributedString *)hy_attributedStringWithAttributes:(nullable NSDictionary<NSString *, id> *)attrs {
    if ([NSString hy_isNullString:self] || [NSObject hy_isNull:attrs]) return nil;
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:self attributes:attrs];
    return att;
}

- (NSAttributedString *)hy_attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    if (font) [att setObject:font forKey:NSFontAttributeName];
    if (textColor) [att setObject:textColor forKey:NSForegroundColorAttributeName];
    return [self hy_attributedStringWithAttributes:att];
}

- (NSAttributedString *)hy_strikethroughAttributedString {
    NSDictionary *att = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)};
    return [self hy_attributedStringWithAttributes:att];
}

- (NSAttributedString *)hy_strikethroughAttributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    NSDictionary *att = @{
                          NSFontAttributeName:font,
                          NSForegroundColorAttributeName:textColor,
                          NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)
                          };
    return [self hy_attributedStringWithAttributes:att];
}

#pragma mark - 货币，价格，显示
- (NSString *)hy_currencyString {
    if ([NSString hy_isNullString:self]) return nil;
    return [NSString stringWithFormat:@"¥%.2f", [[self hy_numberValue] doubleValue]];
    //注：用下面的方法会导致价格中间的删除线没法显示出来！！！
//    NSNumberFormatter *currencyFormatter = [NSNumberFormatter hy_currencyFormatter];
//    return [currencyFormatter stringFromNumber:[self hy_numberValue]];
}

#pragma mark - 商品价格，原价、折扣价
- (NSString *)hy_originalPriceString {
    return [self hy_currencyString];
}

- (NSAttributedString *)hy_originalPriceStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    return [[self hy_currencyString] hy_attributedStringWithFont:font textColor:textColor];
}

- (NSAttributedString *)hy_discountPriceString {
    return [[self hy_currencyString] hy_strikethroughAttributedString];
}

- (NSAttributedString *)hy_discountPriceStringWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    NSAttributedString *price = [self hy_discountPriceString];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:price];
    if (font) {
        [att addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, price.string.length)];
    }
    if (textColor) {
        [att addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, price.string.length)];
    }
    return att;
}

@end



