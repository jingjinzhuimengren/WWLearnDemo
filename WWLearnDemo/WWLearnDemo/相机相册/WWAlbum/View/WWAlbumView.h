//
//  WWAlbumView.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWAlbumModel;

@interface WWAlbumView : UIView

/**
 显示相册列表
 
 @param assetCollectionList 相册对象列表
 @param navigationBarMaxY navigationBarMaxY的最大值
 @param complete 返回结果
 */
+(void)showAlbumView:(NSMutableArray<WWAlbumModel *> *)assetCollectionList navigationBarMaxY:(CGFloat)navigationBarMaxY complete:(void(^)(WWAlbumModel *albumModel))complete;

@end


