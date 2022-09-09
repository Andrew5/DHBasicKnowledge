//
//  ApplicationList.h
//  testSingature
//
//  Created by jabraknight on 2022/4/22.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationList : NSObject
/** 获取已安装应用列表  */
- (void)applist;
- (BOOL)isJailBreak;
+ (BOOL)isJailbroken;
- (BOOL)isJailBreakAppList;
- (BOOL)isJailBreakEnv;
+ (void)test;
static BOOL APCheckIfAppInstalled1(NSString *bundleIdentifier); // Bundle identifier (eg. com.apple.mobilesafari) used to track apps

@end

NS_ASSUME_NONNULL_END
