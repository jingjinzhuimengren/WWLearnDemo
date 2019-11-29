//
//  WWAlbumModel.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWAlbumModel.h"

@implementation WWAlbumModel

- (void)setCollection:(PHAssetCollection *)collection{
    
    _collection = collection;
//    if ([collection.localizedTitle isEqualToString:@"All Photos"]) {
//        self.collectionTitle = @"全部相册";
//    } else {
//        self.collectionTitle = collection.localizedTitle;
//    }
//
    self.collectionTitle = collection.localizedTitle;
    self.assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    if (self.assets.count > 0) {
        self.firstAsset = self.assets[0];
    }
    self.collectionNumber = [NSString stringWithFormat:@"%ld", self.assets.count];
}

#pragma mark - Get方法
-(NSMutableArray<NSNumber *> *)selectRows {
    if (!_selectRows) {
        _selectRows = [NSMutableArray array];
    }
    
    return _selectRows;
}

@end
