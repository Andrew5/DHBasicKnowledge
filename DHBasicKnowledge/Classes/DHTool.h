//
//  LBHTTPTool.h
//  LeBangYZ
//
//  Created by Rillakkuma on 2016/10/25.
//  Copyright © 2016年 zhongkehuabo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DHTool : NSObject
//**
// *  获取该类的所有属性
// */
//+ (NSDictionary *)getPropertys;
///** 获取所有属性，包含主键pk */
//+ (NSDictionary *)getAllProperties;

+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width otherBorderWidth:(CGFloat)otherWidth topColor:(UIColor *)topColor leftColor:(UIColor *)leftColor bottomColor:(UIColor *)bottomColor  rightColor:(UIColor *)rightColor;


/*获取网络流量信息*/
+ (NSString *)getByteRate;
+ (long long) getInterfaceBytes;
//获取WiFi 信息，返回的字典中包含了WiFi的名称、路由器的Mac地址、还有一个Data(转换成字符串打印出来是wifi名称)
+(NSDictionary *)fetchSSIDInfo;
//网速测试
+(NSMutableDictionary *)getDataCounters;
//获得行高
+ (CGFloat)contentSizeWithText:(NSString *)text;
/*!
 *  判断字符串判断是否为空
 *
 *  @param stirng 传进来的字符
 *
 *  @return YES：为空，NO：不为空
 */

+ (BOOL)IsNSStringNULL:(NSString *)stirng;

/*!
 *  自适应label的宽度
 *
 *  @param text  内容
 *  @param font  字体大小
 *  @param height 高度
 *
 *  @return label的宽度
 */
+ (CGSize)autoSizeOfWidthWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height;
+ (CGSize)autoSizeOfHeghtWithString:(NSString *)calcedString;
/*!
 *  自适应label的高度
 *
 *  @param text  内容
 *  @param font  字体大小
 *  @param width 宽度
 *
 *  @return label的高度
 */
+ (CGSize)autoSizeOfHeghtWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

/**
 * 验证手机号码
 */
+ (BOOL)isValidateMobile:(NSString *)mobileNum;
/**验证码
 */
+ (BOOL)validateVerifyCode:(NSString *)verifyCode;
/**密码
 */
+ (BOOL)validatePassword:(NSString *)passWord;
//获得当前时间
+ (NSString *)getCurrectTimeWithPar:(NSString *)par;
// 将NSlog打印信息保存到Document目录下的文件中
+ (void)redirectNSlogToDocumentFolder;
// 将NSlog打印信息保存到Caches目录下的文件中 写入缓存数据
+ (void)writeLocalCacheDataToCachesFolderWithKey:(NSString *)key fileName:(NSString *)file;
/**
 Preferences：NSLibraryDirectory
 Caches：NSCachesDirectory
 */
// 读缓存
+ (NSData *)readLocalCacheDataWithKey:(NSString *)key;
// 删缓存
+ (void)deleteLocalCacheDataWithKey:(NSString *)key;

+ (NSString *)getIPAddress;
///本地信息保存
+ (void)setToken:(id)tokenObj;
+ (NSDictionary *)userTokenObj;
/**
 富文本实现文章末尾增加自定义后缀文字
 
 @param label 正文内容
 @param morestr 内容末尾强制增加的文字
 @param nameDict 正文内容属性
 @param moreDict 强制增加的文字属性
 @param num 正文内容要展示的行数
 @return 返回富文本
 */
+ (NSMutableAttributedString *)addWithName:(UILabel *)label more:(NSString *)morestr nameDict:(NSDictionary *)nameDict moreDict:(NSDictionary *)moreDict numberOfLines:(NSInteger)num;

+(NSString *)dataInMyCollectionData:(NSString *)dateStr;

+ (NSNumber *) freeDiskSpace;
+ (double)freeMemory;
+ (double)appUsedMemory;
+ (void)pushChatController:(UIViewController *)controller;
/// IDFA编号
+ (NSString *)IDFA;
/// 手机容量
+ (NSString *)diskSpaceType;
/// 手机可用容量
+ (NSNumber *)freeDiskSpace;
/// 实时计算textView高度(包括折行)
- (CGSize)getStrRectInText:(NSString *)string InTextView:(UITextView *)textView;
/// 将文本按长度度截取并加上指定后缀
/// @param str 文本
/// @param suffixStr 指定后缀
/// @param font 文本字体
/// @param length 文本长度
- (NSString*)stringByTruncatingString:(NSString *)str suffixStr:(NSString *)suffixStr font:(UIFont *)font forLength:(CGFloat)length;

- (NSArray<NSNumber *> *)getSamplePixelToImageBackGroundColor:(UIImage *)image;
- (CGSize)handleImage:(CGSize)retSize;
- (NSString *)convertImage:(UIImage *)image;
- (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize;
- (BOOL)writeFile:(NSData *)data toPath:(NSString *)path;
- (void)比较时间:(NSArray *)dataArray;
- (NSInteger)changeStringWithSubstring:(NSString *)param WithSourceStr:(NSString *)param;
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format;
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format;
- (NSDate *)worldTimeToChinaTime:(NSDate *)date;
+ (NSString *)checkTheDate:(NSString *)string;
- (BOOL)isToday:(NSDate *)date;
- (BOOL)isYesterday;
- (BOOL)isThisYear;
- (NSDate *)dateWithYMD;
- (NSString *)getUTCFormateDate:(NSDate *)newsDate;
@end
