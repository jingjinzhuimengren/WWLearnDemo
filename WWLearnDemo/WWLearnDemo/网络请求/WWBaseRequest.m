//
//  WWBaseRequest.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/21.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWBaseRequest.h"

@implementation WWBaseRequest

- (NSString *)requestUrl{
    return @"/api/4/news/latest";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{};
}

@end
