//
//  WWAlbumModel.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//  相册数据模型

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface WWAlbumModel : NSObject

@property (nonatomic, strong) PHAssetCollection *collection;//相册
@property (nonatomic, strong) PHAsset *firstAsset;//第一个相片
@property (nonatomic, strong) PHFetchResult<PHAsset *> *assets;//第一个相片
@property (nonatomic, copy) NSString *collectionTitle;
@property (nonatomic, copy) NSString *collectionNumber;// 总数
@property (nonatomic, strong) NSMutableArray<NSNumber *> *selectRows;// 选中的图片

@end

