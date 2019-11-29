//
//  WWCameraAlbumController.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/25.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWCameraAlbumController.h"
//调用系统相机，引入头文件：
#import <AVFoundation/AVFoundation.h>
//调用系统相册，引入头文件：
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface WWCameraAlbumController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation WWCameraAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"相机相册";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
       [self.imageView addGestureRecognizer:tap];
}

#pragma mark - 点击imageView，弹出系统弹框
- (void)tapImageView{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self checkCameraPermission];
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self checkAlbumPermission];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:camera];
    [alert addAction:album];
    [alert addAction:cancel];

    [self presentViewController:alert animated:YES completion:nil];
}
/**
    AVAuthorizationStatusNotDetermined = 0,    请问是否授权访问
    AVAuthorizationStatusRestricted,     权限限制
    AVAuthorizationStatusDenied,    拒绝访问
    AVAuthorizationStatusAuthorized     授权访问
 */
#pragma mark - 相机
- (void)checkCameraPermission{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [self takePhoto];
            }
        }];
    }else if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        [self alertCamera];
    } else {
        [self takePhoto];
    }
}

#pragma mark - 打开相机
- (void)takePhoto{
    //判断相机是否可用，防止模拟器点击【相机】导致崩溃
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //开启以后可以摄像
        self.imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        //视频质量
        self.imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;

        [self presentViewController:self.imagePickerController animated:YES completion:^{

        }];
    }else {
        NSLog(@"不能使用模拟器进行拍照");
    }
}

- (void)alertCamera {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请在设置中打开相机" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 相册
- (void)checkAlbumPermission {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    [self selectAlbum];
                }
            });
        }];
    }else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [self alertAlbum];
    } else {
        [self selectAlbum];
    }
}

- (void)selectAlbum {
    //判断相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:^{

        }];
    }
}

- (void)alertAlbum {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请在设置中打开相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    /**
         info字典里的可用信息
        UIImagePickerControllerMediaType     媒体类型（kUTTypeImage、kUTTypeMovie等）
        UIImagePickerControllerOriginalImage 原始图片
        UIImagePickerControllerEditedImage   编辑后图片
        UIImagePickerControllerCropRect      裁剪尺寸
        UIImagePickerControllerMediaMetadata 拍照的元数据
        UIImagePickerControllerMediaURL      媒体的URL
        UIImagePickerControllerReferenceURL  引用相册的URL
        UIImagePickerControllerLivePhoto     PHLivePhoto
        **/
    
    //获取拍照的原始图片
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    //获取拍照编辑后的图片
    UIImage *img1 = info[UIImagePickerControllerEditedImage];
    //第一种方法：把照片写入相册（方便，只需要保存到相册，诶有后续操作，推荐）
    UIImageWriteToSavedPhotosAlbum(img1, nil, nil, nil);
    //第二种方法：把照片写入相册，需要添加Photos.framework（若后续有复杂操作，推荐）
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImage:img];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
        }];
        
        //显示或可以做其他任何操作
        self.imageView.image = img1;
       
        //一定要回收图像选取控制器
        [picker dismissViewControllerAnimated:YES completion:nil];
}

// 取消操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // 回收图像选取控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UIImagePickerController *)imagePickerController{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}


@end
