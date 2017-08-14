//
//  YANNavigationViewController.h
//  YANImagePickerController
//
//  Created by yan on 2017/8/8.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YANNavigationViewControllerDelegate <NSObject>

@optional
- (void)navigationViewControllerDisposeImage:(UIImage *)sendImage;// 获取原图进行处理

@end

@interface YANNavigationViewController : UINavigationController

/**
 初始化

 @param rowHeight 相册列表页面cell高度 默认值为65
 @param columnNumber 预览页面列数 默认为4
 @param previewSpacing 预览页面cell间距 默认为2
 */
+ (YANNavigationViewController *)navigationViewControllerRowHeight:(CGFloat)rowHeight columnNumber:(NSInteger)columnNumber previewSpacing:(CGFloat)previewSpacing;

/**
 添加右侧‘取消’按钮

 @param viewController 需要添加的控制器
 */
- (void)addLeftCancleToViewController:(UIViewController *)viewController;

/**
 获取原图
 */
- (void(^)(NSArray *))artworkMaster;

/**
 预览页面最大选择数,默认值为3
 */
@property(nonatomic, assign) NSInteger maxSelectImageCount;


@property (weak, nonatomic) id <YANNavigationViewControllerDelegate> delegate_;

@end
