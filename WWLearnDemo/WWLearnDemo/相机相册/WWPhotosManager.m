//
//  WWPhotosManager.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWPhotosManager.h"
#import "WWAlbumViewController.h"
#import "WWPhotoManger.h"

@implementation WWPhotosManager

+(void)showPhotosManager:(UIViewController *)viewController withMaxImageCount:(NSInteger)maxCount withAlbumArray:(void(^)(NSMutableArray<WWPhotoModel *> *albumArray))albumArray {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                WWAlbumViewController *controller = [[WWAlbumViewController alloc] init];
                controller.confirmAction = ^{
                    albumArray([WWPhotoManger standardPhotoManger].photoModelList);
                };
                
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
                
                [WWPhotoManger standardPhotoManger].maxCount = maxCount;
                navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
                [viewController presentViewController:navigationController animated:YES completion:nil];
            }else{
                UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"访问相册" message:@"您还没有打开相册权限" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击了取消");
                }];
                
                [alertViewController addAction:action1];
                [alertViewController addAction:action2];
                
                //相当于之前的[actionSheet show];
                
                [viewController presentViewController:alertViewController animated:YES completion:nil];
            }
        });
    }];
}

@end
