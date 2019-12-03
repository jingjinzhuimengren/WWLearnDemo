//
//  WWCheckAuthorization.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/12/3.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWCheckAuthorization.h"
#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>
#import<AddressBookUI/AddressBookUI.h>

@implementation WWCheckAuthorization

+ (void)checkAddressBookAuthorizationSuccess:(AuthorizationSuccess)success failure:(AuthorizationFailure)failure{
    
    #ifdef __IPHONE_9_0
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusNotDetermined:
            NSLog(@"尚未授权");
            break;
        case CNAuthorizationStatusRestricted:
            NSLog(@"受限制，无权限");
            break;

        case CNAuthorizationStatusDenied:
            NSLog(@"用户拒绝授权");
            break;
        case CNAuthorizationStatusAuthorized:
            NSLog(@"用户已授权");
            break;
    }
    #else
    
    ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
    switch (ABstatus) {
        case kABAuthorizationStatusNotDetermined:
            NSLog(@"尚未授权");
            break;
        case kABAuthorizationStatusRestricted:
            NSLog(@"受限制，无权限");
            break;
        case kABAuthorizationStatusDenied:
            NSLog(@"用户拒绝授权");
            break;
        case kABAuthorizationStatusAuthorized:
            NSLog(@"用户已授权");
            break;
    }
    #endif
    
    #ifdef __IPHONE_9_0

    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"已授权");
        } else {
            NSLog(@"未授权");
        }
    }];

    #else

    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            NSLog(@"已授权");
        } else {
            NSLog(@"未授权");
        }
    });

    #endif
}

+ (void)checkMicrophoneAuthorizationSuccess:(AuthorizationSuccess)success failure:(AuthorizationFailure)failure {
    
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(granted){
                        if (success) {
                            success(@"已获取麦克风权限");
                        }
                    }else{
                        if (failure) {
                            failure([self promptMsgWithTypeStr:@"麦克风"], [self appSettingUrl]);
                        }
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusDenied||AVAuthorizationStatusRestricted:{
            if (failure) {
                failure([self promptMsgWithTypeStr:@"麦克风"],[self appSettingUrl]);
            }
        }
            break;
        case AVAuthorizationStatusAuthorized:
            if (success) {
                success(@"已获取麦克风权限");
            }
        default:
            break;
    }
}

+ (void)checkCameraAuthorizationSuccess:(AuthorizationSuccess)success failure:(AuthorizationFailure)failure{
    
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(granted){
                        if (success) {
                            success(@"已获取相机权限");
                        }
                    }else{
                        if (failure) {
                            failure([self promptMsgWithTypeStr:@"相机"], [self appSettingUrl]);
                        }
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusDenied||AVAuthorizationStatusRestricted:{
            if (failure) {
                failure([self promptMsgWithTypeStr:@"相机"],[self appSettingUrl]);
            }
        }
            break;
        case AVAuthorizationStatusAuthorized:
            if (success) {
                success(@"已获取相机权限");
            }
        default:
            break;
    }
}

+ (void)checkPhotoAlbumAuthorizationSuccess:(AuthorizationSuccess)success failure:(AuthorizationFailure)failure{
    
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusAuthorized) {
                       if (success) {
                            success(@"已获取相册权限");
                        }
                    }else{
                        if (failure) {
                            failure([self promptMsgWithTypeStr:@"相册"], [self appSettingUrl]);
                        }
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusDenied||AVAuthorizationStatusRestricted:{
            if (failure) {
                failure([self promptMsgWithTypeStr:@"相册"],[self appSettingUrl]);
            }
        }
            break;
        case AVAuthorizationStatusAuthorized:
            if (success) {
                success(@"已获取相册权限");
            }
        default:
            break;
    }
}


+ (NSURL *)appSettingUrl {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    return url;
}

+ (NSString *)promptMsgWithTypeStr:(NSString *)typeStr {
    NSString *msg = [NSString stringWithFormat:@"Please find iPhone\"General-%@-%@\"item，allow %@ access to your %@",[[NSBundle mainBundle]infoDictionary][@"CFBundleDisplayName"],typeStr,[[NSBundle mainBundle]infoDictionary][@"CFBundleDisplayName"],typeStr];
    return msg;
}

@end
