//
//  AppDelegate.m
//  xclSinaWeibo
//
//  Created by xiechanglei on 15/4/2.
//  Copyright (c) 2015年 谢长磊. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureController.h"
#import "MainController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    NSString -- CFStringRef
//    NSArray -- CFArrayRef
//    kCFBundleVersionKey -- BundleVersion 版本号
    
    NSString *key = (NSString *)kCFBundleVersionKey;
//    1. info.pist文件中存放的版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    
#if 0
//    2.从沙河中取出上次存储的版本号
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    

    if ([version isEqualToString:savedVersion]) {//不是第一次使用
//        主控制器
        self.window.rootViewController = [[MainController alloc] init];
        
    } else {//说明版本号不一样  第一次使用新版本
//        将新版本号写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
//        快速同步
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        现实版本新特性界面
        self.window.rootViewController = [[NewFeatureController alloc] init];
    }
#endif
    
    
//    下面是为了调试新特性而加的一段，调试完成后应删除
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
    //        快速同步
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //        现实版本新特性界面
    self.window.rootViewController = [[NewFeatureController alloc] init];
    
//   上面是为了调试新特性而加的一段，调试完成后应删除
    
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
