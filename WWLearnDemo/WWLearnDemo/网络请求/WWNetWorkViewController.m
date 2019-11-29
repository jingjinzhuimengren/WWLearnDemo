//
//  WWNetWorkViewController.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/22.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWNetWorkViewController.h"
#import "WWBaseRequest.h"

@interface WWNetWorkViewController ()<YTKRequestDelegate>

@end

@implementation WWNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 使用block来取得网络请求结果
- (void)useBlockCallBack{
    WWBaseRequest *request = [[WWBaseRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"succeed");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failure");
    }];
}


#pragma mark - 使用delegate来取得网络请求结果
- (void)useDelegateCallBack{
    WWBaseRequest *request = [[WWBaseRequest alloc] init];
    request.delegate = self;
    [request start];
}

- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    NSLog(@"succeed");
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request{
    
}

@end
