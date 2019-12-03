//
//  WWAlbumViewController.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WWAlbumViewControllerConfirmAction)(void);

@interface WWAlbumViewController : UIViewController

/// 确定事件
@property (nonatomic, copy) WWAlbumViewControllerConfirmAction confirmAction;

@end
