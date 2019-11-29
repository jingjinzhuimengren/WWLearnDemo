//
//  AppDelegate.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/19.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "YTKNetwork.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = @"https://news-at.zhihu.com";
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window makeKeyAndVisible];
    
    return YES;
}

//在应用进入前台或者后台的时候可以重新进行连接或者断开连接
//进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}
//进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}



@end
