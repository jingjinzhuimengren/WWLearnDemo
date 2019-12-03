//
//  WWCheckAuthorization.h
//  WWLearnDemo
//
//  Created by wwchao on 2019/12/3.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AuthorizationSuccess)(NSString *successMsg);
typedef void(^AuthorizationFailure)(NSString *failureMsg, NSURL *url);

@interface WWCheckAuthorization : NSObject

/**
 *  AddressBook
 */
+ (void)checkAddressBookAuthorizationSuccess:(AuthorizationSuccess)success failure:(AuthorizationFailure)failure;

/**
 *  Microphone
 */
+ (void)checkMicrophoneAuthorizationSuccess:(AuthorizationSuccess)success failure:(AuthorizationFailure)failure;

/**
 *  Camera
 */
+ (void)checkCameraAuthorizationSuccess:(AuthorizationSuccess)success failure:(AuthorizationFailure)failure;

/**
 *  Photo album
 */
+ (void)checkPhotoAlbumAuthorizationSuccess:(AuthorizationSuccess)success failure:(AuthorizationFailure)failure;


@end

