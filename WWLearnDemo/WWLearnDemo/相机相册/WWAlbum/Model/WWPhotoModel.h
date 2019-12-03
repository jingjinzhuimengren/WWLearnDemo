//
//  WWPhotoModel.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef void(^WWPhotoModelAction)(void);

@interface WWPhotoModel : NSObject

@property (nonatomic, strong) PHAsset *asset;//相片
@property (nonatomic, strong) UIImage *highDefinitionImage;//高清图
@property (nonatomic, copy) WWPhotoModelAction getPictureAction;//获取图片成功事件

@end

