//
//  WWPhotosManager.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WWPhotoModel.h"

@interface WWPhotosManager : NSObject

/**
 显示相册
 
 @param viewController 跳转的控制器
 @param maxCount 最大选择图片数量
 @param albumArray 返回的图片数组
 */
+(void)showPhotosManager:(UIViewController *)viewController withMaxImageCount:(NSInteger)maxCount withAlbumArray:(void(^)(NSMutableArray<WWPhotoModel *> *albumArray))albumArray;

@end

