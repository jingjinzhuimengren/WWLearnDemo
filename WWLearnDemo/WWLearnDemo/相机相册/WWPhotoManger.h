//
//  WWPhotoManger.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WWPhotoModel;

typedef void(^WWPhotoMangerChoiceCountChange)(NSInteger choiceCount);

@interface WWPhotoManger : NSObject

@property (nonatomic, assign) NSInteger maxCount;//可选的的最大数量
@property (nonatomic, assign) NSInteger choiceCount;//已选数量
@property (nonatomic, strong) NSMutableArray<WWPhotoModel *> *photoModelList;//已选图片
@property (nonatomic, copy) WWPhotoMangerChoiceCountChange choiceCountChange;//选择图片变化

/**
 单例
 
 @return 返回对象
 */
+(WWPhotoManger*)standardPhotoManger;

@end

