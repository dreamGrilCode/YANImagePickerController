//
//  ViewController.m
//  YANImagePickerController
//
//  Created by yan on 2017/8/8.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "YANAlbumListTableController.h"
#import "YANNavigationViewController.h"

@interface ViewController ()<UIActionSheetDelegate,YANNavigationViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(albumClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)albumClick{

    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"从相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 0: // 拍照
        {
            
        }
            break;
        case 1:// 相册
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                // 子线程
                NSLog(@"%@",[NSThread currentThread]);
                if (status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        YANNavigationViewController *rootVC = [YANNavigationViewController navigationViewControllerRowHeight:65 columnNumber:3 previewSpacing:10];
                        rootVC.delegate_ = self;
                        rootVC.maxSelectImageCount = 6;
                        [self presentViewController:rootVC animated:YES completion:^{
                        }];

                    });
                }
            }];
        }
            break;
        default:
            break;
    }
}
#pragma mark - YANNavigationViewControllerDelegate
- (void)navigationViewControllerDisposeImage:(UIImage *)sendImage{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    imageView.image = sendImage;
    [self.view addSubview:imageView];
}
@end
