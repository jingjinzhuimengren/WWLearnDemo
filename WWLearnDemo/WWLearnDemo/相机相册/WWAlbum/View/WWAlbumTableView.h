//
//  WWAlbumTableView.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWAlbumModel;

typedef void(^WWAlbumTableViewSelectAction)(WWAlbumModel *albumModel);

@interface WWAlbumTableView : UITableView

/// 相册数组
@property (nonatomic, strong) NSMutableArray<WWAlbumModel *> *assetCollectionList;
/// 选择的相册
@property (nonatomic, copy) WWAlbumTableViewSelectAction selectAction;

@end
