//
//  WWPhotosManager.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/12/3.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWPhotoModel.h"

@class UIViewController;

NS_ASSUME_NONNULL_BEGIN

@interface WWPhotosManager : NSObject

/**
 显示相册
 
 @param viewController 跳转的控制器
 @param maxCount 最大选择图片数量
 @param albumArray 返回的图片数组
 */
+(void)showPhotosManager:(UIViewController *)viewController withMaxImageCount:(NSInteger)maxCount withAlbumArray:(void(^)(NSMutableArray<WWPhotoModel *> *albumArray))albumArray;

@end

NS_ASSUME_NONNULL_END
