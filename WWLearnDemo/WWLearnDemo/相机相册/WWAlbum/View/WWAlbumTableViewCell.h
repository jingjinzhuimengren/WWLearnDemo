//
//  WWAlbumTableViewCell.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWAlbumModel;

@interface WWAlbumTableViewCell : UITableViewCell

/// 相册
@property (nonatomic, strong) WWAlbumModel *albumModel;
/// 行数
@property (nonatomic, assign) NSInteger row;

/// 加载图片
-(void)loadImage:(NSIndexPath *)index;

@end

