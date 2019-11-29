//
//  WWNetworkRequest.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/21.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WWNetworkRequest : NSObject

+(WWNetworkRequest *)shareInstance;


/*
 监听网络状态
 */
-(void)monitorNetworkingStatus;

/*
 GET 请求
 @param NSString *urlString 地址链接
 @param NSDictionary *headerDictionary 请求头参数
 @param NSDictionary *paramDictionary 请求体参数
 */
-(void)requestGETWithURLString:(NSString *)urlString WithHTTPHeaderFieldDictionary:(NSDictionary *)headerDictionary withParamDictionary:(NSDictionary *)paramDictionary successful:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

/*
 POST 请求 (需要自己设置请求头)
 @param NSString *urlString 地址链接
 @param NSDictionary *headerDictionary 请求头参数
 @param NSDictionary *paramDictionary 请求体参数
 */
-(void)requestPostWithURLString:(NSString *)urlString WithHTTPHeaderFieldDictionary:(NSDictionary *)headerDictionary withParamDictionary:(NSDictionary *)paramDictionary successful:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;


/*
 PUT 请求
 @param NSString *urlString 地址链接
 @param NSDictionary *headerDictionary 请求头参数
 @param NSDictionary *paramDictionary 请求体参数
 */
-(void)requestPUTWithURLString:(NSString *)urlString WithHTTPHeaderFieldDictionary:(NSDictionary *)headerDictionary withParamDictionary:(NSDictionary *)paramDictionary successful:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;


@end
