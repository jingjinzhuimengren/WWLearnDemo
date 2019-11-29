//
//  WWNetworkRequest.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/21.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWNetworkRequest.h"
//#import "AFNetworking.h"

@interface WWNetworkRequest()

//@property(nonatomic,strong)AFHTTPSessionManager *sessionManager;

@end

@implementation WWNetworkRequest

+(WWNetworkRequest *)shareInstance
{
    static WWNetworkRequest *networking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[self alloc] init];
    });
    return networking;
}

//-(instancetype)init
//{
//    if (self = [super init]) {
//        _sessionManager = [AFHTTPSessionManager manager];
//        _sessionManager.requestSerializer = [AFJSONRequestSerializer new];
//        _sessionManager.responseSerializer = [AFJSONResponseSerializer new];
//        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer]; // 请求
//        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer]; // 响应
//        _sessionManager.requestSerializer.timeoutInterval = 30.0f;
//        // 设置请求头
//        [_sessionManager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    }
//    return self;
//}
//
///*
// 监听网络状态
// */
//-(void)monitorNetworkingStatus
//{
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        
//        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未知网络" message:NULL preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:NULL];
//            [alert addAction:action];
//            [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:alert animated:YES completion:NULL];
//        }
//    }];
//}
//
///*
// GET 请求
// @param NSString *urlString 地址链接
// @param NSDictionary *headerDictionary 请求头参数
// @param NSDictionary *paramDictionary 请求体参数
// */
//-(void)requestGETWithURLString:(NSString *)urlString WithHTTPHeaderFieldDictionary:(NSDictionary *)headerDictionary withParamDictionary:(NSDictionary *)paramDictionary successful:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
//{
//    if (headerDictionary) {
//        for (NSString *key in headerDictionary) {
//            [_sessionManager.requestSerializer setValue:headerDictionary[key] forHTTPHeaderField:key];
//        }
//    }
//    
//    [_sessionManager GET:urlString parameters:paramDictionary progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if (success) {
//            NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
//            if (dictionary) {
//                success(dictionary);
//            }
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
///*
// POST 请求 (需要自己设置请求头)
// @param NSString *urlString 地址链接
// @param NSDictionary *headerDictionary 请求头参数
// @param NSDictionary *paramDictionary 请求体参数
// */
//-(void)requestPostWithURLString:(NSString *)urlString WithHTTPHeaderFieldDictionary:(NSDictionary *)headerDictionary withParamDictionary:(NSDictionary *)paramDictionary successful:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
//{
//    if (headerDictionary) {
//        for (NSString *key in headerDictionary) {
//            [_sessionManager.requestSerializer setValue:headerDictionary[key] forHTTPHeaderField:key];
//        }
//    }
//    
//    [_sessionManager POST:urlString parameters:paramDictionary progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            
//            NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
//            if (dictionary) {
//                success(dictionary);
//            }
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//    
//}
//
///*
// PUT 请求
// @param NSString *urlString 地址链接
// @param NSDictionary *headerDictionary 请求头参数
// @param NSDictionary *paramDictionary 请求体参数
// */
//-(void)requestPUTWithURLString:(NSString *)urlString WithHTTPHeaderFieldDictionary:(NSDictionary *)headerDictionary withParamDictionary:(NSDictionary *)paramDictionary successful:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
//{
//    if (headerDictionary) {
//        for (NSString *key in headerDictionary) {
//            [_sessionManager.requestSerializer setValue:headerDictionary[key] forHTTPHeaderField:key];
//        }
//    }
//    [_sessionManager PUT:urlString parameters:paramDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if (success) {
//            NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:responseObject];
//            if (dictionary) {
//                success(dictionary);
//            }
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

@end
