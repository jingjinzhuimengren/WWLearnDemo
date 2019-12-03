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
#import "UIImageView+WebCache.h"

@interface AppDelegate ()

@property(nonatomic, strong) UIView *launchView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = @"https://news-at.zhihu.com";
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [self initLaunchScreen];
    
    [NSThread sleepForTimeInterval:10];
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    return YES;
}


- (void)initLaunchScreen{
    
    UIViewController *launchVC = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    _launchView = launchVC.view;
    _launchView.backgroundColor = [UIColor redColor];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    _launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:_launchView];
    UIImageView *imageView=[[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic15.nipic.com/20110628/1369025_192645024000_2.jpg"]];
        //根据需求添加约束最好
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.backgroundColor=[UIColor blackColor];
    [_launchView addSubview:imageView];
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(removeLaunchImage) userInfo:nil repeats:NO];
}

//-(void)removeLaunchImage{
//    [_launchView removeFromSuperview];
//    //设置rootViewController的代码
//
//    
//}



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
