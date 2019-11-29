//
//  WWAlbumCollectionViewCell.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>

typedef void(^WWAlbumCollectionViewCellAction)(PHAsset *asset);

@interface WWAlbumCollectionViewCell : UICollectionViewCell

/// 行数
@property (nonatomic, assign) NSInteger row;
/// 相片
@property (nonatomic, strong) PHAsset *asset;
/// 选中事件
@property (nonatomic, copy) WWAlbumCollectionViewCellAction selectPhotoAction;
/// 是否被选中
@property (nonatomic, assign) BOOL isSelect;

#pragma mark - 加载图片
-(void)loadImage:(NSIndexPath *)indexPath;

@end
