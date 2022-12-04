//
//  ApplicationList.m
//  testSingature
//
//  Created by jabraknight on 2022/4/22.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import "ApplicationList.h"
#import <UIKit/UIKit.h>
#include <objc/runtime.h>
#include <dlfcn.h>
#include <objc/objc.h>
#include <objc/runtime.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>



#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])
#define USER_APP_PATH                 @"/User/Applications/"
#define CYDIA_APP_PATH                "/Applications/Cydia.app"


@implementation ApplicationList

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
+ (BOOL) verifyAppWithBundle:(NSString *)bundleID {
    //    NSArray *bundles2Check = [NSArray arrayWithObjects: @"com.apple.mobilesafari", @"com.yourcompany.yourselfmadeapp", @"com.blahblah.nonexistent", nil];
    //    for (NSString *identifier in bundles2Check)
    //        if (APCheckIfAppInstalled1(identifier))
    //            NSLog(@"App installed: %@", identifier);
    //        else
    //            NSLog(@"App not installed: %@", identifier);
    __block BOOL isInstall = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) {
        //iOS12间接获取办法
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 12.0){
            Class lsawsc = objc_getClass("LSApplicationWorkspace");

            NSObject* workspace = [lsawsc performSelector:NSSelectorFromString(@"defaultWorkspace")];
            NSArray *plugins = [workspace performSelector:NSSelectorFromString(@"installedPlugins")];
            NSArray *plugins1 = [workspace performSelector:NSSelectorFromString(@"allApplications")];
            NSLog(@"apps: %@--%@",plugins1,plugins);
            [plugins enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *pluginID = [obj performSelector:(@selector(pluginIdentifier))];
                NSLog(@"pluginID：%@",pluginID);
                if([pluginID containsString:bundleID]){
                    isInstall = YES;
                    return;
                }
            }];
            return isInstall;
        }else{
            //iOS11获取办法
            NSBundle *container = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/MobileContainerManager.framework"];
            if ([container load]) {
                Class appContainer = NSClassFromString(@"MCMAppContainer");
                id test = [appContainer performSelector:@selector(containerWithIdentifier:error:) withObject:bundleID withObject:nil];
                NSLog(@"信息 %@",test);
                if (test) {
                    return YES;
                } else {
                    return NO;
                }
            }else{
                return NO;
            }
        }
    }else{
        //iOS10及以下获取办法
        Class lsawsc = objc_getClass("LSApplicationWorkspace");
        NSObject* workspace = [lsawsc performSelector:NSSelectorFromString(@"defaultWorkspace")];
        NSArray *appList = [workspace performSelector:@selector(allApplications)];
        NSLog(@"信息 %@",appList);
        Class LSApplicationProxy_class = object_getClass(@"LSApplicationProxy");
        for (LSApplicationProxy_class in appList) {
            //这里可以查看一些信息
            NSString *bundleID = [LSApplicationProxy_class performSelector:@selector(applicationIdentifier)];
            NSString *version =  [LSApplicationProxy_class performSelector:@selector(bundleVersion)];
            NSLog(@"信息 %@",version);
            NSString *shortVersionString =  [LSApplicationProxy_class performSelector:@selector(shortVersionString)];
            NSLog(@"信息 %@",shortVersionString);
            if ([bundleID isEqualToString:bundleID]) {
                return  YES;
            }
        }
        return NO;
    }
    return NO;
}
#pragma clang diagnostic pop

/*
 @interface LSApplicationWorkspace : NSObject {
 }

 + (id)defaultWorkspace;

 - (id)URLOverrideForURL:(id)arg1;

 - (void)_LSClearSchemaCaches;
 
 - (void)_LSFailedToOpenURL:(NSURL *)url withBundle:(NSBundle *)bundle;
-(void)_openUserActivity:orUserActivityUUID:activityTypeForUUID:withApplicationProxy:options:completionHandler:
-(void)optionsFromOpenConfiguration:
-(void)operationToOpenResource:usingApplication:uniqueDocumentIdentifier:isContentManaged:sourceAuditToken:userInfo:options:delegate:
-(void)operationToOpenResource:usingApplication:uniqueDocumentIdentifier:userInfo:delegate:
-(void)operationToOpenResource:usingApplication:uniqueDocumentIdentifier:userInfo:
-(void)enumerateBundlesOfType:legacySPI:block:
-(void)enumerateApplicationsOfType:legacySPI:block:
-(void)installApplication:withOptions:error:usingBlock:
-(void)installProgressForApplication:withPhase:
-(void)installPhaseFinishedForProgress:
-(void)installContainerizedApplicationArtifactAtURL:withOptions:returningRecordPromise:error:progressBlock:
-(void)uninstallApplication:withOptions:error:usingBlock:
-(void)clearCreatedProgressForBundleID:
-(void)registerApplicationDictionary:withObserverNotification:
-(void)updateRecordForApp:withSINF:iTunesMetadata:placeholderMetadata:sendNotification:error:
-(void)placeholderInstalledForIdentifier:filterDowngrades:
-(void)revertContainerizedApplicationWithIdentifier:options:returningRecordPromise:error:progressBlock:
-(void)allowsAlternateIcons
-(void)syncObserverProxy
-(void)getKnowledgeUUID:andSequenceNumber:
-(void)directionsApplications
-(void)applicationsWithUIBackgroundModes
-(void)applicationsWithAudioComponents
-(void)applicationsWithVPNPlugins
-(void)applicationsForUserActivityType:
-(void)applicationForUserActivityDomainName:
-(void)openApplicationWithBundleID:
-(void)openURL:
-(void)openSensitiveURL:withOptions:
-(void)openUserActivity:withApplicationProxy:options:completionHandler:
-(void)openUserActivity:withApplicationProxy:completionHandler:
-(void)openUserActivity:usingApplicationRecord:configuration:completionHandler:
-(void)openUserActivityWithUUID:activityType:usingApplicationRecord:configuration:completionHandler:
-(void)operationToOpenResource:usingApplication:uniqueDocumentIdentifier:sourceIsManaged:userInfo:options:delegate:
-(void)operationToOpenResource:usingApplication:uniqueDocumentIdentifier:sourceIsManaged:userInfo:delegate:
-(void)operationToOpenResource:usingApplication:userInfo:
-(void)openURL:configuration:completionHandler:
-(void)penApplicationWithBundleIdentifier:configuration:completionHandler:
-(void)penApplicationWithBundleIdentifier:usingConfiguration:completionHandler:
-(void)nstalledPlugins
-(void)luginsWithIdentifiers:protocols:version:applyFilter:
-(void)numeratePluginsMatchingQuery:withBlock:
-(void)luginsMatchingQuery:applyFilter:
-(void)numerateBundlesOfType:block:
-(void)numerateApplicationsOfType:block:
-(void)pplicationIsInstalled:
-(void)emovedSystemApplications
-(void)undleIdentifiersForMachOUUIDs:error:
-(void)achOUUIDsForBundleIdentifiers:error:
-(void)etClaimedActivityTypes:domains:
-(void)nstallApplication:withOptions:
-(void)nstallApplication:withOptions:error:
-(void)nstallContainerizedApplicationArtifactAtURL:withOptions:error:progressBlock:
-(void)ninstallContainerizedApplicationWithIdentifier:options:error:progressBlock:
-(void)owngradeApplicationToPlaceholder:withOptions:error:
-(void)ninstallApplication:withOptions:
-(void)ninstallApplication:withOptions:usingBlock:
-(void)estoreSystemApplication:
-(void)egisterApplicationDictionary:
-(void)egisterApplication:
-(void)nregisterApplication:
-(void)pdateSINFWithData:forApplication:options:error:
-(void)getBundleIdentifierForBundleAtURL:invokeUpdateBlockAndReregister:error:
-(void)pdateSINFWithData:forApplicationAtURL:error:
-(void)pdateiTunesMetadataWithData:forApplication:options:error:
-(void)pdateiTunesMetadataWithData:forApplicationAtURL:error:
-(void)pdatePlaceholderMetadataForApp:installType:failure:underlyingError:source:outError:
-(void)nitiateProgressForApp:withType:
-(void)pdatePlaceholderWithBundleIdentifier:withInstallType:error:
-(void)evertContainerizedApplicationWithIdentifier:options:error:progressBlock:
-(void)egisterPlugin:
-(void)nregisterPlugin:
-(void)arbageCollectDatabaseWithError:
-(void)sVersion:greaterThanOrEqualToVersion:
-(void)nvalidateIconCache:
-(void)learAdvertisingIdentifier
-(void)eviceIdentifierForAdvertising
-(void)eviceIdentifierForVendor
-(void)reateDeviceIdentifierWithVendorName:bundleIdentifier:
-(void)emoveDeviceIdentifierForVendorName:bundleIdentifier:
-(void)eviceIdentifierForVendorSeedData
-(void)nstallProgressForBundleID:makeSynchronous:
-(void)LSPrivateRebuildApplicationDatabasesForSystemApps:internal:user:
-(void)LSPrivateSyncWithMobileInstallation
-(void)ebuildDatabaseContentForFrameworkAtURL:completionHandler:
-(void)LSPrivateUpdateAppRemovalRestrictions
-(void)LSPrivateSetRemovedSystemAppIdentifiers:
-(void)_LSPrivateRemovedSystemAppIdentifiers
-(void)_LSPrivateDatabaseNeedsRebuild
-(void)_LSClearSchemaCaches
-(void)acquireDatabase
-(void)ls_testWithCleanDatabaseWithError:
-(void)ls_injectUTTypeWithDeclaration:inDatabase:error:
-(void)ls_resetTestingDatabase
-(void)createdInstallProgresses
-(void)observedInstallProgresses
-(void)legacyApplicationProxiesListWithType:
-(void)pluginsWithIdentifiers:protocols:version:withFilter:
-(void)pluginsWithIdentifiers:protocols:version:
-(void)enumerateBundlesOfType:usingBlock:
-(void)applicationsOfType:
-(void)allInstalledApplications
-(void)placeholderApplications
-(void)unrestrictedApplications
-(void)allApplications
-(void)applicationsAvailableForOpeningDocument:
-(void)setDefaultWebBrowserToApplicationRecord:completionHandler:
-(void)setDefaultMailClientToApplicationRecord:completionHandler:
-(void)relaxApplicationTypeRequirements:forApplicationRecord:completionHandler:
-(void)removeAllDefaultApplicationPreferencesWithCompletionHandler:
-(void)applicationsAvailableForOpeningURL:legacySPI:
-(void)isApplicationAvailableToOpenURLCommon:includePrivateURLSchemes:error:
-(void)applicationsAvailableForOpeningURL:
-(void)isApplicationAvailableToOpenURL:error:
-(void)isApplicationAvailableToOpenURL:includePrivateURLSchemes:error:
-(void)applicationForOpeningResource:
-(void)applicationsAvailableForHandlingURLScheme:
-(void)publicURLSchemes
-(void)privateURLSchemes
-(void)URLOverrideForURL:
-(void)URLOverrideForNewsURL:

 - (bool)_LSPrivateRebuildApplicationDatabasesForSystemApps:(bool)arg1
                                                   internal:(bool)arg2
                                                       user:(bool)arg3;
 - (void)_clearCachedAdvertisingIdentifier;

 - (void)addObserver:(id)arg1;

 - (id)allApplications;

 - (id)allInstalledApplications;

 - (id)applicationForOpeningResource:(id)arg1;

 - (id)applicationForUserActivityDomainName:(id)arg1;

 - (id)applicationForUserActivityType:(id)arg1;

 - (bool)applicationIsInstalled:(id)arg1;

 - (id)applicationsAvailableForHandlingURLScheme:(id)arg1;

 - (id)applicationsAvailableForOpeningDocument:(id)arg1;

 - (id)applicationsOfType:(unsigned long long)arg1;

 - (id)applicationsWithAudioComponents;

 - (id)applicationsWithExternalAccessoryProtocols;

 - (id)applicationsWithSettingsBundle;

 - (id)applicationsWithUIBackgroundModes;

 - (id)applicationsWithVPNPlugins;

 - (void)clearAdvertisingIdentifier;

 - (void)clearCreatedProgressForBundleID:(id)arg1;

 - (id)delegateProxy;

 - (id)deviceIdentifierForAdvertising;

 - (id)deviceIdentifierForVendor;

 - (id)directionsApplications;

 - (bool)establishConnection;

 - (bool)getClaimedActivityTypes:(id*)arg1 domains:(id*)arg2;

 - (void)getKnowledgeUUID:(id*)arg1 andSequenceNumber:(id*)arg2;

 - (bool)installApplication:(id)arg1
                withOptions:(id)arg2
                      error:(id*)arg3
                 usingBlock:(id)arg4;

 - (bool)installApplication:(id)arg1 withOptions:(id)arg2 error:(id*)arg3;

 - (bool)installApplication:(id)arg1 withOptions:(id)arg2;

 - (bool)installPhaseFinishedForProgress:(id)arg1;

 - (id)installProgressForApplication:(id)arg1 withPhase:(unsigned long long)arg2;

 - (id)installProgressForBundleID:(id)arg1 makeSynchronous:(unsigned char)arg2;

 - (id)installedPlugins;

 - (id)installedVPNPlugins;

 - (bool)invalidateIconCache:(id)arg1;

 - (bool)openApplicationWithBundleID:(id)arg1;

 - (bool)openSensitiveURL:(id)arg1 withOptions:(id)arg2;

 - (bool)openURL:(id)arg1 withOptions:(id)arg2;

 - (bool)openURL:(id)arg1;

 - (id)operationToOpenResource:(id)arg1
              usingApplication:(id)arg2
      uniqueDocumentIdentifier:(id)arg3
               sourceIsManaged:(bool)arg4
                      userInfo:(id)arg5
                      delegate:(id)arg6;

 - (id)operationToOpenResource:(id)arg1
              usingApplication:(id)arg2
      uniqueDocumentIdentifier:(id)arg3
                      userInfo:(id)arg4
                      delegate:(id)arg5;

 - (id)operationToOpenResource:(id)arg1
              usingApplication:(id)arg2
      uniqueDocumentIdentifier:(id)arg3
                      userInfo:(id)arg4;

 - (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 userInfo:(id)arg3;

 - (id)placeholderApplications;

 - (id)pluginsWithIdentifiers:(id)arg1 protocols:(id)arg2 version:(id)arg3;

 - (id)privateURLSchemes;

 - (id)publicURLSchemes;

 - (bool)registerApplication:(id)arg1;

 - (bool)registerApplicationDictionary:(id)arg1
              withObserverNotification:(unsigned long long)arg2;

 - (bool)registerApplicationDictionary:(id)arg1;

 - (bool)registerPlugin:(id)arg1;

 - (id)remoteObserver;

 - (void)removeInstallProgressForBundleID:(id)arg1;

 - (void)removeObserver:(id)arg1;

 - (bool)uninstallApplication:(id)arg1 withOptions:(id)arg2 usingBlock:(id)arg3;

 - (bool)uninstallApplication:(id)arg1 withOptions:(id)arg2;

 - (bool)unregisterApplication:(id)arg1;

 - (bool)unregisterPlugin:(id)arg1;

 - (id)unrestrictedApplications;

 - (bool)updateSINFWithData:(id)arg1
             forApplication:(id)arg2
                    options:(id)arg3
                      error:(id*)arg4;
 */
//    NSInteger zlConnt = 0 ;
//    for  (NSString  *appStr  in  allApplications) {
//        NSString  *app = [ NSString  stringWithFormat:@"%@",appStr];//转换成字符串
//        NSRange range = [app rangeOfString:@"org.ios.appprojuct.jqb"];//是否包含这个 bundle ID
//        if  (range. length  >  1 ) {
//            zlConnt ++;
//        }
//    }
//    if (zlConnt >= 1) {
//        NSLog ( @" 已安装金钱豹 org.ios.appprojuct.jqb" );
//    }
static BOOL APCheckIfAppInstalled1(NSString *bundleIdentifier) {

    static NSString *const cacheFileName = @"com.apple.mobile.installation.plist";
    NSString *relativeCachePath = [[@"Library" stringByAppendingPathComponent: @"Caches"] stringByAppendingPathComponent: cacheFileName];
    NSDictionary *cacheDict = nil;
    NSString *path = nil;
    // Loop through all possible paths the cache could be in
    for (short i = 0; 1; i++) {
        switch (i) {
    case 0: // Jailbroken apps will find the cache here; their home directory is /var/mobile
        path = [NSHomeDirectory() stringByAppendingPathComponent: relativeCachePath];
        break;
    case 1: // App Store apps and Simulator will find the cache here; home (/var/mobile/) is 2 directories above sandbox folder
        path = [[NSHomeDirectory() stringByAppendingPathComponent: @"../.."] stringByAppendingPathComponent: relativeCachePath];
        break;
    case 2: // If the app is anywhere else, default to hardcoded /var/mobile/
        path = [@"/var/mobile" stringByAppendingPathComponent: relativeCachePath];
        break;
    default: // Cache not found (loop not broken)
        return NO;
        break; }

        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath: path isDirectory: &isDir] && !isDir) // Ensure that file exists
            cacheDict = [NSDictionary dictionaryWithContentsOfFile: path];

        if (cacheDict) // If cache is loaded, then break the loop. If the loop is not "broken," it will return NO later (default: case)
            break;
    }

    NSDictionary *system = [cacheDict objectForKey: @"System"]; // First check all system (jailbroken) apps
    if ([system objectForKey: bundleIdentifier]) return YES;
    NSDictionary *user = [cacheDict objectForKey: @"User"]; // Then all the user (App Store /var/mobile/Applications) apps
    if ([user objectForKey: bundleIdentifier]) return YES;

    // If nothing returned YES already, we'll return NO now
    return NO;
}

- (void)scan {
    NSString *pathOfApplications = @"/var/mobile/Applications";
    NSLog(@"scan begin");
    // all applications
    NSArray *arrayOfApplications = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplications error:nil];
    for (NSString *applicationDir in arrayOfApplications) {
        // path of an application
        NSString *pathOfApplication = [pathOfApplications stringByAppendingPathComponent:applicationDir];
        NSArray *arrayOfSubApplication = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplication error:nil];
        // seek for *.app
        for (NSString *applicationSubDir in arrayOfSubApplication) {
            if ([applicationSubDir hasSuffix:@".app"]) {// *.app
                NSString *path = [pathOfApplication stringByAppendingPathComponent:applicationSubDir];
                path = [path stringByAppendingPathComponent:@"Info.plist"];
                // so you get the Info.plist in the dict
                NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
                // code to analyzing the dict.
                NSLog(@"信息 %@",dict);
            }
        }
    }
    NSLog(@"scan end");
}
- (void)applist {
    
    Class LSApplicationWorkspace_class =  objc_getClass ("LSApplicationWorkspace" );
    [self printClassMethodWithName:LSApplicationWorkspace_class];
     NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
     NSArray *allApplications = [workspace performSelector:@selector(allApplications)];//这样就能获取到手机中安装的所有App
    __block NSUInteger countNumber = 0;//allApplications.count;
    Class LSApplicationProxy_class = object_getClass(@"LSApplicationProxy");
    [self printClassMethodWithName:LSApplicationProxy_class];
    for  (LSApplicationProxy_class in allApplications) {
        NSString *bundleID = [LSApplicationProxy_class performSelector:@selector(applicationIdentifier)];
        NSString *version =  [LSApplicationProxy_class performSelector:@selector(bundleVersion)];
        NSString *shortVersionString =  [LSApplicationProxy_class performSelector:@selector(shortVersionString)];
        NSString *bundleExecutableString =  [LSApplicationProxy_class performSelector:@selector(bundleExecutable)];
//        NSString *directionsApplicationsString =  [LSApplicationProxy_class performSelector:@selector(directionsApplications)];

        NSLog(@"\t\n bundleID：%@\n version： %@,\n shortVersionString:%@,\n bundleExecutable:%@,\n", bundleID,version,shortVersionString,bundleExecutableString);

        [allApplications objectAtIndex:countNumber];
        countNumber ++;
        if (countNumber >= allApplications.count){
            break;
        }else{
            if ([bundleExecutableString containsString:@"U17"]) {
                NSLog(@"项目 %@",[allApplications objectAtIndex:countNumber]);
                NSString *localizedNameString =  [LSApplicationProxy_class performSelector:@selector(localizedName)];
                NSLog(@"名字 %@",localizedNameString);
                NSString *signerIdentityString =  [LSApplicationProxy_class performSelector:@selector(signerIdentity)];
                NSLog(@"标识符 %@",signerIdentityString);
                NSLog(@"%@",[self properties_aps:LSApplicationProxy_class]);
                //模拟器可以正常卸载app，真机不行。
//                [workspace performSelector:@selector(uninstallApplication:withOptions:) withObject:@"com.charles.U17" withObject:nil];
                //打开
//                [workspace performSelector:@selector(openApplicationWithBundleID:) withObject:@"com.charles.U17"];
                NSUserDefaults *share = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.charles.U17"];
                NSLog(@"%@",share.dictionaryRepresentation);
            }
        }
    }
}
//类的fangfa列表：
- (void)printClassMethodWithName:(Class)name {
    //获取方法列表
    unsigned int methodCount;
    Method *methods = class_copyMethodList(name, &methodCount);
    for (int i = 0; i < methodCount; i ++) {
        Method m = methods[i];
        NSLog(@"%@ is SEL：%d-----%s",NSStringFromClass([name class]),i, sel_getName(method_getName(m)));
    }
    free(methods);
}
//获取app的属性。
- (NSDictionary *)properties_aps:(id)objc {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([objc class], &outCount);
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [objc valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};
 
- (BOOL)isJailBreak {
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

- (BOOL)isJailBreakAppList {
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
        NSLog(@"The device is jail broken!");
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APP_PATH error:nil];
        NSLog(@"applist = %@", applist);
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

+(BOOL)isJailbroken{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
        return YES;
    }
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        NSLog(@"Device is jailbroken");
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
        NSLog(@"Device is jailbroken");
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/"  error:nil];
        NSLog(@"applist = %@",applist);
    }
    return NO;
}




int checkInject(void) {
    int ret = 0;
    Dl_info dylib_info;
    int (*func_stat)(const char*, struct stat*) = stat;
    
//    if ((ret = dladdr(func_stat, &dylib_info)) && strncmp(dylib_info.dli_fname, dylib_name, strlen(dylib_name))) {
//        return 0;
//    }
    if (ret == dladdr(func_stat, &dylib_info)) {
        return 0;
    }
    return 1;
}
void checkCydia1(void)
{
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        NSLog(@"Device is jailbroken");
    }
}
int checkCydia(void) {
    // first ,check whether library is inject
    struct stat stat_info;
    
    if (!checkInject()) {
        if (0 == stat(CYDIA_APP_PATH, &stat_info)) {
            return 1;
        }
    } else {
        return 1;
    }
    return 0;
}
 
- (BOOL)isJailBreakStatus {
    if (checkCydia()) {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

char* printEnv(void) {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s", env);
    return env;
}
 
- (BOOL)isJailBreakEnv {
    if (printEnv()) {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

+ (void)test {
    Dl_info info;
    IMP imp;
    Method orginalMethod = class_getClassMethod([NSObject class], @selector(load));
    imp = method_getImplementation(orginalMethod);
    if (dladdr(imp, &info)) {
        printf("dli_fname: %s\n", info.dli_fname);
        printf("dli_sname: %s\n", info.dli_sname);
        printf("dli_fbase: %p\n", info.dli_fbase);
        printf("dli_saddr: %p\n", info.dli_saddr);
    } else {
        printf("error: can't find that symbol.\n");
    }
}



@end
