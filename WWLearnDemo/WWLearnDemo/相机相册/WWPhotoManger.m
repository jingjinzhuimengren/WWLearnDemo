//
//  WWPhotoManger.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWPhotoManger.h"
#import "WWPhotoModel.h"

@implementation WWPhotoManger

+(WWPhotoManger*)standardPhotoManger {
    static WWPhotoManger *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WWPhotoManger alloc] init];
    });
    
    return manager;
}

#pragma mark - Set方法
-(void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    
    self.photoModelList = [NSMutableArray array];
    self.choiceCount = 0;
}

-(void)setChoiceCount:(NSInteger)choiceCount {
    _choiceCount = choiceCount;
    
    if (self.choiceCountChange) {
        self.choiceCountChange(choiceCount);
    }
}

@end
