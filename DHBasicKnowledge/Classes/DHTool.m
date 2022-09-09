//
//  LBHTTPTool.m
//  LeBangYZ
//
//  Created by Rillakkuma on 2016/10/25.
//  Copyright © 2016年 zhongkehuabo. All rights reserved.
//

#import "DHTool.h"
//#import "WKWebViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreText/CoreText.h>
#import <AdSupport/AdSupport.h>
//获取设备当前连接网段IP
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#import <dlfcn.h>
#import <netinet/in.h>
#import <mach/mach.h>
#define DH_FontSize(fontSize) [UIFont systemFontOfSize:fontSize]
#define DH_DeviceWidth  [UIScreen mainScreen].bounds.size.width

@implementation DHTool

#pragma mark - ***** 判断字符串是否为空
//根据需求 待修改
+ (BOOL)IsNSStringNULL:(NSString *)stirng
{
	if([stirng isKindOfClass:[NSNull class]]) return YES;
	if(![stirng isKindOfClass:[NSString class]]) return YES;
	
	if(stirng == nil) return YES;
    if([stirng isEqualToString:@"(null)"]) return YES;
    if([stirng isEqualToString:@"NULL"]) return YES;
    if([stirng isEqualToString:@"<null>"]) return YES;
    if([stirng isEqualToString:@"null"]) return YES;

    if(stirng == nil || stirng == NULL) return YES;
	NSString * string1 = [stirng stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSUInteger len=[string1 length];
	if (len <= 0) return YES;
	return NO;
}
//检查手机是否设置了代理
- (BOOL) checkProxySetting {
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSLog(@"\n%@",proxies);

    NSDictionary *settings = proxies[0];
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);

    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"])
    {
        NSLog(@"没设置代理");
        return NO;
    }
    else
    {
        
        NSLog(@"设置了代理");
        return YES;
    }

}

+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width otherBorderWidth:(CGFloat)otherWidth topColor:(UIColor *)topColor leftColor:(UIColor *)leftColor bottomColor:(UIColor *)bottomColor  rightColor:(UIColor *)rightColor
{
	if (top) {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
		layer.backgroundColor = color.CGColor;
		[view.layer addSublayer:layer];
	} else {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, 0, view.frame.size.width, otherWidth);
		layer.backgroundColor = topColor.CGColor;
		[view.layer addSublayer:layer];
	}
	if (left) {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
		layer.backgroundColor = color.CGColor;
		[view.layer addSublayer:layer];
	} else {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, 0, otherWidth, view.frame.size.height);
		layer.backgroundColor = leftColor.CGColor;
		[view.layer addSublayer:layer];
	}
	if (bottom) {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
		layer.backgroundColor = color.CGColor;
		[view.layer addSublayer:layer];
	} else {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, view.frame.size.height - otherWidth, view.frame.size.width, otherWidth);
		layer.backgroundColor = bottomColor.CGColor;
		[view.layer addSublayer:layer];
	}
	if (right) {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
		layer.backgroundColor = color.CGColor;
		[view.layer addSublayer:layer];
	} else {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(view.frame.size.width - width, 0, otherWidth, view.frame.size.height);
		layer.backgroundColor = rightColor.CGColor;
		[view.layer addSublayer:layer];
	}
}


+ (CGSize)autoSizeOfWidthWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height
{
    CGSize size = CGSizeMake(MAXFLOAT, height);
    //    NSDictionary *attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    //    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [text boundingRectWithSize:size
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    return rect.size;
    
}
+ (CGSize)autoSizeOfHeghtWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width{
	CGSize size = CGSizeMake(width, MAXFLOAT);
	//    NSDictionary *attributesDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
	//    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
	//
	// iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
	// 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
	NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
	NSStringDrawingUsesFontLeading;
	
	NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
	[style setLineBreakMode:NSLineBreakByCharWrapping];
	
	NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
	
	CGRect rect = [text boundingRectWithSize:size
									 options:opts
								  attributes:attributes
									 context:nil];
	return rect.size;
}
//默认字体[UIFont systemFontOfSize:14]
+ (CGSize)autoSizeOfHeghtWithString:(NSString *)calcedString{

    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
     paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
     paragraphStyle.alignment = NSTextAlignmentLeft;
     paragraphStyle.lineSpacing = 2;
//     paragraphStyle.lineSpacing = 10 - (self.font.lineHeight - self.font.pointSize);
     NSMutableAttributedString *attibuteStr = [[NSMutableAttributedString alloc] initWithString:calcedString];
      [attibuteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, calcedString.length)];
     [attibuteStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, calcedString.length)];
         CFAttributedStringRef attributedStringRef = (__bridge CFAttributedStringRef)attibuteStr;
     CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributedStringRef);
     CFRange range = CFRangeMake(0, calcedString.length);
     CFRange fitCFRange = CFRangeMake(0, 0);
     CGSize newSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, NULL, CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX), &fitCFRange);
         if (nil != framesetter) {
         CFRelease(framesetter);
         framesetter = nil;
     }
    return  CGSizeMake(ceilf(newSize.width), ceilf(newSize.height));
    
}
+ (CGFloat)contentSizeWithText:(NSString *)text{
	NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSPlainTextDocumentType } documentAttributes:nil error:nil];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle setLineSpacing:8];//调整行间距
    //     paragraphStyle.lineSpacing = 8 - (self.font.lineHeight - self.font.pointSize);
	NSDictionary * attriBute = @{NSFontAttributeName:DH_FontSize(14)};
	[attrStr addAttributes:attriBute range:NSMakeRange(0, [attrStr length])];
	[attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
	
	CGSize labelSize=[attrStr boundingRectWithSize:CGSizeMake(DH_DeviceWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
	return labelSize.height;
	
}
+ (BOOL)isValidateMobile:(NSString *)mobileNum{

	/**
	 * 手机号码
	 * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
	 * 联通：130,131,132,152,155,156,185,186
	 * 电信：133,1349,153,180,189
	 */
	NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
	/**
	 10         * 中国移动：China Mobile
	 11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,184,187,188
	 12         */
	NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2478])\\d)\\d{7}$";
	/**
	 15         * 中国联通：China Unicom
	 16         * 130,131,132,152,155,156,185,186
	 17         */
	NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
	/**
	 20         * 中国电信：China Telecom
	 21         * 133,1349,153,180,189
	 22         */
	NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
	/**
	 25         * 大陆地区固话及小灵通
	 26         * 区号：010,020,021,022,023,024,025,027,028,029
	 27         * 号码：七位或八位
	 28         */
	// NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
	
	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
	NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
	NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
	NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
	
	if (([regextestmobile evaluateWithObject:mobileNum] == YES)
		|| ([regextestcm evaluateWithObject:mobileNum] == YES)
		|| ([regextestct evaluateWithObject:mobileNum] == YES)
		|| ([regextestcu evaluateWithObject:mobileNum] == YES))
	{
		return YES;
	}
	else
	{
		return NO;
	}
}

+ (BOOL)validateVerifyCode:(NSString *)verifyCode {
	BOOL flag;
	if (verifyCode.length != 5) {
		flag = NO;
		return flag;
	}
	NSString *regex2 = @"^(\\d{5})";
	NSPredicate *verifyCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
	return [verifyCodePredicate evaluateWithObject:verifyCode];
}

//密码
+ (BOOL)validatePassword:(NSString *)passWord {
	NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
	NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
	return [passWordPredicate evaluateWithObject:passWord];
}
//MMM:6月 MM:06 MMMMM:6 K:mm-10:21 上午
+ (NSString *)getCurrectTimeWithPar:(NSString *)par{
	NSDate *currentDate = [NSDate date];//获取当前时间，日期
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:par];
	NSString *dateString = [dateFormatter stringFromDate:currentDate];
	NSLog(@"dateString:%@",dateString);
	return dateString;
}
// 将NSlog打印信息保存到Document目录下的文件中
+ (void)redirectNSlogToDocumentFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"dr.log"];
    // 注意不是NSData!
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:logFilePath]) {
        NSLog(@"大文件小：%llu",[[fileManager attributesOfItemAtPath:logFilePath error:nil] fileSize]);
    }
    [defaultManager removeItemAtPath:logFilePath error:nil]; // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
}
/*******************************************************************************/

// 将NSlog打印信息保存到Caches目录下的文件中 写入缓存数据
+ (void)writeLocalCacheDataToCachesFolderWithKey:(NSString *)key fileName:(NSString *)file{
    // 设置存储路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path1 = [path stringByAppendingPathComponent:file];
    //    // 判读缓存数据是否存在
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesPath]) {
    //        // 删除旧的缓存数据
    //        [[NSFileManager defaultManager] removeItemAtPath:cachesPath error:nil];
    //    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:path1]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * cachesPath = [path1 stringByAppendingPathComponent:key];

    freopen([cachesPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([cachesPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

// 读缓存
+ (NSData *)readLocalCacheDataWithKey:(NSString *)key {
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
                            stringByAppendingPathComponent:key];
    // 判读缓存数据是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesPath]) {
        // 读取缓存数据
        return [NSData dataWithContentsOfFile:cachesPath];
    }
    return nil;
}

// 删缓存
+ (void)deleteLocalCacheDataWithKey:(NSString *)key {
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
                            stringByAppendingPathComponent:key];
    // 判读缓存数据是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesPath]) {
        // 删除缓存数据
        [[NSFileManager defaultManager] removeItemAtPath:cachesPath error:nil];
    }
}

+ (double)freeMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    vm_size_t pageSize;
    mach_port_t selfhost = mach_host_self();
    host_page_size(selfhost, &pageSize);
    kern_return_t kernReturn = host_statistics(selfhost,
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    mach_port_deallocate(mach_task_self(), selfhost);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

+ (double)appUsedMemory
{
    mach_task_basic_info_data_t taskInfo;
    unsigned infoCount = sizeof(taskInfo);
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         MACH_TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}
+ (void)setToken:(id)tokenObj{
    NSMutableDictionary *tokenDic = [NSMutableDictionary new];
    tokenDic[@"access_token"] = tokenObj[@"data"][@"access_token"];
    tokenDic[@"expires_time"] = tokenObj[@"data"][@"expires_in"];
    tokenDic[@"token_getTime"] = [NSDate date];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:tokenDic forKey:@"access_token"];
    [userDefault synchronize];
}
+ (NSDictionary *)userTokenObj{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *tokenObj = [userDefault objectForKey:@"access_token"];
    
    [userDefault synchronize];
    return tokenObj;
}
///TODO: 获取网络流量信息
+ (NSString *)getByteRate {
    long long int currentBytes = [DHTool getInterfaceBytes];
    //格式化一下
    NSString*rateStr = [DHTool formatNetWork:currentBytes];
    NSLog(@"当前网速%@",rateStr);
    return rateStr;
}
+ (long long) getInterfaceBytes
{
	struct ifaddrs *ifa_list = 0, *ifa;
	if (getifaddrs(&ifa_list) == -1)
	{
		return 0;
	}
	
	uint32_t iBytes = 0;
	uint32_t oBytes = 0;
	
	for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
	{
		if (AF_LINK != ifa->ifa_addr->sa_family)
			continue;
		
		if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
			continue;
		
		if (ifa->ifa_data == 0)
			continue;
		
		/* Not a loopback device. */
		if (strncmp(ifa->ifa_name, "lo", 2))
		{
			struct if_data *if_data = (struct if_data *)ifa->ifa_data;
			
			iBytes += if_data->ifi_ibytes;
			oBytes += if_data->ifi_obytes;
		}
	}
	freeifaddrs(ifa_list);
	return iBytes + oBytes;
}
+ (NSString *)formatNetWork:(long long int)rate {
    if (rate <1024) {
        return [NSString stringWithFormat:@"%lldB/秒", rate];
    } else if (rate >=1024&& rate <1024*1024) {
        return [NSString stringWithFormat:@"%.1fKB/秒", (double)rate /1024];
    } else if (rate >=1024*1024&& rate <1024*1024*1024) {
        return [NSString stringWithFormat:@"%.2fMB/秒", (double)rate / (1024*1024)];
    } else {
        return@"10Kb/秒";
    };
}
//获取WiFi 信息，返回的字典中包含了WiFi的名称、路由器的Mac地址、还有一个Data(转换成字符串打印出来是wifi名称)
+ (NSDictionary *)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}
//网速测试
+(NSMutableDictionary *)getDataCounters
{
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    
    NSString *name=[[NSString alloc]init];
    NSMutableDictionary *wifiDic = [[NSMutableDictionary alloc]init];
    
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            //            NSLog(@"ifa_name %s == %@n", cursor->ifa_name,name);
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if ([name hasPrefix:@"en"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                    // NSLog(@"WiFiSent %d ==%d",WiFiSent,networkStatisc->ifi_obytes);
                    //NSLog(@"WiFiReceived %d ==%d",WiFiReceived,networkStatisc->ifi_ibytes);
                }
                
                if ([name hasPrefix:@"pdp_ip"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                    // NSLog(@"WWANSent %d ==%d",WWANSent,networkStatisc->ifi_obytes);
                    //NSLog(@"WWANReceived %d ==%d",WWANReceived,networkStatisc->ifi_ibytes);
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    NSLog(@"nwifiSend:%.2f MBn wifiReceived:%.2f MBn wwansend:%.2f MBn wwanreceived:%.2f MBn",WiFiSent/1024.0/1024.0,WiFiReceived/1024.0/1024.0,WWANSent/1024.0/1024.0,WWANReceived/1024.0/1024.0);
    [wifiDic setValue:[NSString stringWithFormat:@"%.f",WiFiSent/1024.0/1024.0] forKey:@"nwifiSend"];
    [wifiDic setValue:[NSString stringWithFormat:@"%.f",WiFiReceived/1024.0/1024.0] forKey:@"wifiReceived"];
    [wifiDic setValue:[NSString stringWithFormat:@"%.f",WWANSent/1024.0/1024.0] forKey:@"wwansend"];
    [wifiDic setValue:[NSString stringWithFormat:@"%.f",WWANReceived/1024.0/1024.0] forKey:@"wwanreceived"];
    return wifiDic;
}
//获取手机的网络的ip地址
+ (NSString *)getIPAddress
{
	BOOL success;
	struct ifaddrs * addrs;
	const struct ifaddrs * cursor;
	success = getifaddrs(&addrs) == 0;
	if (success) {
		cursor = addrs;
		while (cursor != NULL) {
			// the second test keeps from picking up the loopback address
			if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
			{
				NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
				if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
					NSLog(@"IP:%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)]);
				return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
			}
			cursor = cursor->ifa_next;
		}
		freeifaddrs(addrs);
	}
	return nil;
}
- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    ///过滤非汉字字符
    ///@"[^\u4e00-\u9fa5]"
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}
// add by yangyanhui base64加密
- (NSString *)base64Encode:(NSData *)data
{
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    int length = (int)[data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = (const unsigned char *)[data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}
+ (NSMutableAttributedString *)addWithName:(UILabel *)label more:(NSString *)morestr nameDict:(NSDictionary *)nameDict moreDict:(NSDictionary *)moreDict numberOfLines:(NSInteger)num{
    
    NSArray *array = [self getSeparatedLinesFromLabel:label];
    NSString *showText = @"";
    //    if (array.count == 4){
    //        //最后一行显示的内容
    //        NSString *line4String = array[3];
    //        //整体显示内容拼接
    //        showText = [NSString stringWithFormat:@"%@%@%@%@…%@", array[0], array[1], array[2], [line4String substringToIndex:line4String.length-2],morestr];
    //    }
    //    if (array.count == 3){
    //        NSString *line4String = array[2];
    //        showText = [NSString stringWithFormat:@"%@%@%@…%@", array[0], array[1], [line4String substringToIndex:line4String.length-2],morestr];
    //    }
    //    if (array.count == 2){
    //        NSString *line4String = array[1];
    //        showText = [NSString stringWithFormat:@"%@%@…%@", array[0], [line4String substringToIndex:line4String.length-2],morestr];
    //    }
    //    if (array.count == 1){
    //        NSString *line4String = array[0];
    //        showText = [NSString stringWithFormat:@"%@…%@",[line4String substringToIndex:line4String.length-2],morestr];
    //    }
    //判断行数限制
    if (num == 1){
        if (array.count>0) {
            NSString *line4String = array[0];
            showText = [NSString stringWithFormat:@"%@…%@",[line4String substringToIndex:line4String.length-3],morestr];
        }else{
            showText = label.text;
            //设置label的attributedText富文本
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:showText attributes:nameDict];
            return attStr;
        }
    }
    if (num == 2){
        if (array.count>1) {
            NSString *line4String = array[1];
            showText = [NSString stringWithFormat:@"%@%@…%@", array[0], [line4String substringToIndex:line4String.length-3],morestr];
        }else{
            showText = label.text;
            //设置label的attributedText富文本
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:showText attributes:nameDict];
            return attStr;
        }
    }
    if (num == 3){
        if (array.count>2) {
            NSString *line4String = array[2];
            showText = [NSString stringWithFormat:@"%@%@%@…%@", array[0], array[1], [line4String substringToIndex:line4String.length-3],morestr];
        }else{
            showText = label.text;
            //设置label的attributedText富文本
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:showText attributes:nameDict];
            return attStr;
        }
    }
    if (num == 4){
        if (array.count>3) {
            NSString *line4String = array[3];
            showText = [NSString stringWithFormat:@"%@%@%@%@…%@", array[0], array[1], array[2], [line4String substringToIndex:line4String.length-3],morestr];
        }else{
            showText = label.text;
            //设置label的attributedText富文本
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:showText attributes:nameDict];
            return attStr;
        }
    }
    if (array.count == 0) {
        return nil;
    }
    //设置label的attributedText富文本
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:showText attributes:nameDict];
    [attStr addAttributes:moreDict range:NSMakeRange(showText.length-3, 3)];
    return attStr;
    /*
     4行
     NSString *line4String = array[3];
     NSString *showText = [NSString stringWithFormat:@"%@%@%@%@...更多>", array[0], array[1], array[2], [line4String substringToIndex:line4String.length-5]];
     
     
     //3
     NSString *line4String = array[2];
     NSString *showText = [NSString stringWithFormat:@"%@%@%@%@", array[0], array[1], [line4String substringToIndex:line4String.length-5],str];
     
     //2
     NSString *line4String = array[1];
     NSString *showText = [NSString stringWithFormat:@"%@%@%@%@", array[0], [line4String substringToIndex:line4String.length-5],str];
     
     //1
     NSString *line4String = array[0];
     NSString *showText = [NSString stringWithFormat:@"%@%@%@%@", [line4String substringToIndex:line4String.length-5],str];
     */
}
+ (NSArray *)getSeparatedLinesFromLabel:(UILabel *)name
{
    NSString *text = [name text];
    UIFont   *font = [name font];
    CGRect    rect = [name frame];
    //设置字体属性
    //这里设置了同样的字体格式
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    //设置富文本
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    //对同一段字体进行多属性设置 计算富文本行高
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    //创建绘制路劲
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,MAXFLOAT));
    //设置富文本位置属性
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    //设置富文本的基线
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray;
    
}
//// 这种是路径遮盖法

+ (UIImage*)maskImage:(UIImage*)originImage toPath:(UIBezierPath*)path{
    
    UIGraphicsBeginImageContextWithOptions(originImage.size,NO,0);
    [path addClip];
    [originImage drawAtPoint:CGPointZero];
    UIImage* img =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
////为图像创建透明区域
+ (CGImageRef)CopyImageAndAddAlphaChannel:(CGImageRef)sourceImage{
   CGImageRef retVal = NULL;
   size_t width = CGImageGetWidth(sourceImage);
   size_t height = CGImageGetHeight(sourceImage);
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
   CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,8,0, colorSpace,kCGImageAlphaPremultipliedFirst|kCGBitmapByteOrder32Little);
    if (offscreenContext !=NULL){
        CGContextDrawImage(offscreenContext,CGRectMake(0,0, width, height), sourceImage);
        retVal = CGBitmapContextCreateImage(offscreenContext);
        CGContextRelease(offscreenContext);
    }
    CGColorSpaceRelease(colorSpace);
    return retVal;
}
+(NSString *)dataInMyCollectionData:(NSString *)dateStr {
    NSRange rangeBegin = [dateStr rangeOfString:@"("];
    NSRange rangeEnd = [dateStr rangeOfString:@"+"];
    if (rangeBegin.location != NSNotFound && rangeEnd.location != NSNotFound) {
        NSString *realtme = [dateStr substringWithRange:NSMakeRange(rangeBegin.location + 1, rangeEnd.location - rangeBegin.location - 1)];
        return [self getTimeStringWithTimeInterval:[realtme doubleValue]/1000];
    } else {
        return dateStr;
    }
}

+ (NSString *)getTimeStringWithTimeInterval:(double)tInterval {
    //    发布时间显示规则：发布新闻的时间与手机系统时间的差值，时间间隔为，一个小时内则显示xx分钟前，如11分钟前，52分钟前，10分钟前显示刚刚；一小时后显示xx小时前，如3小时前，23小时前；超过一天则显示具体月日，如01-21；跨年则显示具体年月日，如2014-01-02
    NSDate *origion = [NSDate dateWithTimeIntervalSince1970:tInterval];
    NSDate *currentDate = [NSDate date];
    NSString *str = nil;
    NSInteger startYear=[[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitYear inUnit: NSCalendarUnitEra forDate:origion];
    NSInteger endYear=[[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitYear inUnit: NSCalendarUnitEra forDate:currentDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"]];
    if (endYear > startYear) {
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *dt = origion;
        str = [formatter stringFromDate:dt];
    } else {
        NSTimeInterval time=[currentDate timeIntervalSinceDate:origion];
        long nMinutes = time/60;
        if (nMinutes >= 24 * 60  ) {
            formatter.dateFormat = @"MM-dd";
            NSDate *dt = origion;
            str = [formatter stringFromDate:dt];
        } else if (nMinutes >= 20*60){
            str = [NSString stringWithFormat:@"20小时前"];
        } else if (nMinutes >= 10*60){
            str = [NSString stringWithFormat:@"10小时前"];
        } else if (nMinutes >= 5*60){
            str = [NSString stringWithFormat:@"5小时前"];
        } else if (nMinutes >= 3*60){
            str = [NSString stringWithFormat:@"3小时前"];
        } else if (nMinutes >= 1*60) {
            str = [NSString stringWithFormat:@"1小时前"];
        } else if (nMinutes >= 50){
            str = [NSString stringWithFormat:@"50分钟前"];
        } else if (nMinutes >= 40){
            str = [NSString stringWithFormat:@"40分钟前"];
        } else if (nMinutes >= 30){
            str = [NSString stringWithFormat:@"30分钟前"];
        } else if (nMinutes >= 20){
            str = [NSString stringWithFormat:@"20分钟前"];
        } else if (nMinutes >= 10) {
            str = [NSString stringWithFormat:@"10分钟前"];
        } else {
            str = @"刚刚";
        }
    }
    if (!str) {
        str = [NSString stringWithFormat:@"%f",tInterval];
    }
    return str;
}
+ (void)pushChatController:(UIViewController *)controller {
    
    NSString *url = @"https://www.jianshu.com/p/f646916abd77";
//    if (kUserInfo.userModel.markType == 0) {
//        url = kChatUrl_Normal;
//    }
//    WKWebViewController *chatController = [[WKWebViewController alloc] initWithUrl:url navTitle:@"客服"];
//    [controller.navigationController pushViewController:chatController animated:YES];
    
}
/// IDFA编号
+ (NSString *)IDFA
{
    NSString *IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (!IDFA) {
        IDFA = @"00000000-0000-0000-0000-000000000000";
    }
    return IDFA;
}
/// 手机总容量
+ (NSNumber *)totalDiskSpace
{
    /*
     {
         NSFileSystemFreeNodes = 624404130;
         NSFileSystemFreeSize = 1465380864;//所剩空间
         NSFileSystemNodes = 624794760;
         NSFileSystemNumber = 16777218;
         NSFileSystemSize = 63978983424;//总空间
     }
     */
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}
/// 手机使用容量
+ (NSNumber *) freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}
/// 手机容量
+ (NSString *)diskSpaceType
{
    NSString *diskSpace = @"16GB";
    NSNumber *totalDiskSpace = [self totalDiskSpace];
    long disk_size = totalDiskSpace.longValue / (1024 * 1024 * 1024);
    if (disk_size < 16) {
        diskSpace = @"16GB";
    } else if (disk_size < 32) {
        diskSpace = @"32GB";
    } else if (disk_size < 64) {
        diskSpace = @"64GB";
    } else if (disk_size < 128) {
        diskSpace = @"128GB";
    } else {
        diskSpace = @"256GB";
    }
    return diskSpace;
}

- (CGSize)getStrRectInText:(NSString *)string InTextView:(UITextView *)textView {
    //实际textView显示时我们设定的宽
    CGFloat contentWidth = CGRectGetWidth(textView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
                            + textView.textContainerInset.left
                            + textView.textContainerInset.right
                            + textView.textContainer.lineFragmentPadding/*左边距*/
                            + textView.textContainer.lineFragmentPadding/*右边距*/);

    NSLog(@"broadWith:%f",broadWith);
    CGFloat broadHeight  = (textView.contentInset.top
                            + textView.contentInset.bottom
                            + textView.textContainerInset.top
                            +textView.textContainerInset.bottom);//+self.textview.textContainer.lineFragmentPadding/*top*//*+theTextView.textContainer.lineFragmentPadding*//*there is no bottom padding*/);

    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;

    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};

    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;

    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)
    return adjustedSize;
}
/// 将文本按长度度截取并加上指定后缀
/// @param str 文本
/// @param suffixStr 指定后缀
/// @param font 文本字体
/// @param length 文本长度
- (NSString*)stringByTruncatingString:(NSString *)str suffixStr:(NSString *)suffixStr font:(UIFont *)font forLength:(CGFloat)length {
    if (!str) return nil;
    if (str  && [str isKindOfClass:[NSString class]]) {
        for (int i=(int)[str length] - (int)[suffixStr length]; i< [str length];i = i - (int)[suffixStr length]){
            NSString *tempStr = [str substringToIndex:i];
            CGSize size = [tempStr sizeWithAttributes:@{NSFontAttributeName:font}];
            if(size.width < length){
                tempStr = [NSString stringWithFormat:suffixStr, tempStr];
                CGSize size1 = [tempStr sizeWithAttributes:@{NSFontAttributeName:font}];
                if(size1.width < length){
                    str = tempStr;
                    break;
                }
            }
        }
    }
    return str;
}
// 获取色位，
- (NSArray<NSNumber *> *)getSamplePixelToImageBackGroundColor:(UIImage *)image {
    CGImageRef cgimage = image.CGImage;
    size_t bpr = CGImageGetBytesPerRow(cgimage);//获取位图每一行的字节数
    size_t bpp = CGImageGetBitsPerPixel(cgimage);//获取组成每一像素的位数
    size_t bpc = CGImageGetBitsPerComponent(cgimage);//获取每个色位的位数
    size_t bytes_per_pixel = bpp / bpc;//获取组成每一像素的色位数，这里是4（如(255,255,255,255)）
//    CGBitmapInfo info = CGImageGetBitmapInfo(cgimage);
    CGDataProviderRef provider = CGImageGetDataProvider(cgimage);
    NSData* data1 = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    const uint8_t* bytes = [data1 bytes];
    const uint8_t* pixel = &bytes[1 * bpr + 1 * bytes_per_pixel];//获取位图的第一行第一列像素点作为参考
    return @[@(pixel[0]), @(pixel[1]), @(pixel[2])];//rgb返回前3位
}

// 缩放，临时的方法
- (CGSize)handleImage:(CGSize)retSize {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat scaleH = 0.22;
    CGFloat scaleW = 0.38;
    CGFloat height = 0;
    CGFloat width = 0;
    if (retSize.height / screenH + 0.16 > retSize.width / screenW) {
        height = screenH * scaleH;
        width = retSize.width / retSize.height * height;
    } else {
        width = screenW * scaleW;
        height = retSize.height / retSize.width * width;
    }
    return CGSizeMake(width, height);
}

- (NSString *)convertImage:(UIImage *)image {
    NSData *imageData = nil;
    NSString *mimeType = nil;
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType =  @"png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        mimeType = @"jpg";
    }
    return @"";
    //    return [NSString stringWithFormat: base64, mimeType,
    //            [imageData base64EncodedStringWithOptions: 0]];
}

- (BOOL)imageHasAlpha:(UIImage *)image {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize {
    if (scImg.size.width <= limitSize.width && scImg.size.height <= limitSize.height) {
        return scImg;
    }
    CGSize thumbSize;
    if (scImg.size.width / scImg.size.height > limitSize.width / limitSize.height) {
        thumbSize.width = limitSize.width;
        thumbSize.height = limitSize.width / scImg.size.width * scImg.size.height;
    } else {
        thumbSize.height = limitSize.height;
        thumbSize.width = limitSize.height / scImg.size.height * scImg.size.width;
    }
    UIGraphicsBeginImageContext(thumbSize);
    [scImg drawInRect:(CGRect){CGPointZero,thumbSize}];
    UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImg;
}

- (BOOL)writeFile:(NSData *)data toPath:(NSString *)path {
    NSString *targetDir = [path stringByDeletingLastPathComponent];
    BOOL isDir;
    BOOL isEx = [[NSFileManager defaultManager] fileExistsAtPath:targetDir isDirectory:&isDir];
    if(!isEx){
        [[NSFileManager defaultManager] createDirectoryAtPath:targetDir withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        if(!isDir){
            return NO;
        }
    }
    return [data writeToFile:path atomically:YES];
}
///TODO: 显示规则
- (void)比较时间:(NSArray *)dataArray {
    //今天的：HH:mm
    //昨天的：昨天 HH:mm
    //今年的：MM-dd HH:mm
    //今年以前的：yyyy-MM-dd HH:mm
    NSArray *arr;
    if (dataArray.count <= 0) {
        //今天                        //昨天                        //今年                       //今年以前
        arr = @[@"2021-08-10 01:09:18 +0000",@"2021-08-09 02:09:18 +0000",@"2021-08-07 03:09:18 +0000",@"2020-08-09 04:09:18 +0000"];
    }
    //提示语
    NSString *tipString = @"";
    for (int i = 0; i<4; i++) {
        //1、判断是不是今年
        //是今年 判断是今天还是昨天
        //是今年 不是今天、昨天 就显示今年以前
        //不是今年 显示今年以前
            //服务器给到的时间
        NSString *serverTime = arr[i];
        serverTime = [serverTime substringWithRange:NSMakeRange(0,19)];
        //格式化
        NSDateFormatter *formatterServer = [[NSDateFormatter alloc] init];
        [formatterServer setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dateServer = [formatterServer dateFromString:serverTime];
        //获取当前时间
        NSDate *currectDate = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
        int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
            // 1.获得当前时间的年月日
        NSDateComponents *nowCmps = [calendar components:unit fromDate:currectDate];
        // 2.获得self的年月日
        NSDateComponents *selfCmps = [calendar components:unit fromDate:dateServer];
            if (selfCmps.year == nowCmps.year) {
            NSLog(@"今年");
            //做法一
            if ((selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day)) {//今天
                NSLog(@"今天");
                NSDateFormatter *formatterToday = [[NSDateFormatter alloc] init];
                [formatterToday setDateFormat:@"HH:mm"];
                NSString *time = [formatterToday stringFromDate:dateServer];
                tipString = [@"今天"stringByAppendingString:time];
            }
            //            NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:dateServer toDate:currectDate options:0];
            if ((nowCmps.day - selfCmps.day) == 1){
                NSLog(@"昨天");
                NSDateFormatter *formatterYestoday = [[NSDateFormatter alloc] init];
                [formatterYestoday setDateFormat:@"HH:mm"];
                NSString *time = [formatterYestoday stringFromDate:dateServer];
                tipString = [@"昨天"stringByAppendingString:time];
            }
            if (((nowCmps.day - selfCmps.day) != 1) && (selfCmps.day != nowCmps.day)) {//今年
                NSLog(@"今年");
                NSDateFormatter *formatterTodayyear = [[NSDateFormatter alloc] init];
                [formatterTodayyear setDateFormat:@"MM-dd HH:mm"];
                NSString *time = [formatterTodayyear stringFromDate:dateServer];
                tipString = [@"今年"stringByAppendingString:time];
            }
        }else{
            NSLog(@"今年以前");
                    NSDateFormatter *formatterTodayyearago = [[NSDateFormatter alloc] init];
            [formatterTodayyearago setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *time = [formatterTodayyearago stringFromDate:dateServer];
            tipString = [@"今年以前"stringByAppendingString:time];
        }
        NSLog(@"打印的时间：%@",tipString);
    }
}

- (NSInteger)changeStringWithSubstring:(NSString *)param WithSourceStr:(NSString *)param {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:param?@"YYYY-MM-dd":@"YYYY"];
    NSDate *date = [NSDate date];
    NSString *content = [formatter stringFromDate:date];
    switch ([param compare:content]) {
        case NSOrderedSame:
            return NSOrderedSame;
            break;
        case NSOrderedDescending:
            return NSOrderedDescending;
            break;
        case NSOrderedAscending:
            return NSOrderedAscending;
            break;
        default:
            return NO;
            break;
    }
    return 0;
}

//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [self worldTimeToChinaTime:date];
}

//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (NSString *)checkTheDate:(NSString *)string{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:string];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    NSString *strDiff = nil;
    if(isToday) {
        strDiff= [NSString stringWithFormat:@"今天"];
    }
    return strDiff;
}

- (BOOL)isToday:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}
- (BOOL)isYesterday {
    // 2018-05-01
    NSDate *nowDate = [NSDate date] ;//dateWithYMD];
    // 2017-04-30
    NSDate *selfDate = [self dateWithYMD];
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year;
}

- (NSDate *)dateWithYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

//计算  距离现在的时间
- (NSString *)getUTCFormateDate:(NSDate *)newsDate {
    NSString *dateContent;
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today=[[NSDate alloc] init];
    NSDate *yearsterDay =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate *qianToday =  [[NSDate alloc] initWithTimeIntervalSinceNow:-2*secondsPerDay];
    //假设这是你要比较的date：NSDate *yourDate = ……
    //日历
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:newsDate];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:yearsterDay];
    NSDateComponents* comp3 = [calendar components:unitFlags fromDate:qianToday];
    NSDateComponents* comp4 = [calendar components:unitFlags fromDate:today];
    if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day) {
        dateContent = @"昨天";
    }
    else if (comp1.year == comp3.year && comp1.month == comp3.month && comp1.day == comp3.day)
    {
        dateContent = @"前天";
    }
    else if (comp1.year == comp4.year && comp1.month == comp4.month && comp1.day == comp4.day)
    {
        dateContent = @"今天";
    }
    else
    {
        //返回0说明该日期不是今天、昨天、前天
        dateContent = @"0";
    }
    return dateContent;
}
/////利用图像遮盖

//+ (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage
//
//{
//
//    CGImageRef maskRef = maskImage.CGImage;
//
//    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
//
//                                                                                CGImageGetHeight(maskRef),
//
//                                                                                CGImageGetBitsPerComponent(maskRef),
//
//                                                                                CGImageGetBitsPerPixel(maskRef),
//
//                                                                                CGImageGetBytesPerRow(maskRef),
//
//                                                                                CGImageGetDataProvider(maskRef), NULL, true);
//
//
//
//    CGImageRef sourceImage = [image CGImage];
//
//    CGImageRef imageWithAlpha = sourceImage;
//
//
//
//    //add alpha channel for images that don't have one (ie GIF, JPEG, etc...)
//
//    //this however has a computational cost
//
//    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
//
//        imageWithAlpha = [ImageUtil CopyImageAndAddAlphaChannel:sourceImage];
//
//    }
//
//
//
//    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
//
//    CGImageRelease(mask);
//
//
//
//    //release imageWithAlpha if it was created by CopyImageAndAddAlphaChannel
//
//        if (sourceImage != imageWithAlpha) {
//
//                CGImageRelease(imageWithAlpha);
//
//            }
//
//
//
//    UIImage* retImage = [UIImage imageWithCGImage:masked];
//
//    CGImageRelease(masked);
//
//
//
//    return retImage;
//
//
//
//}

@end
