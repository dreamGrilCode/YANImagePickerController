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
 */
+ (YANNavigationViewController *)navigationViewController;

/**
 添加右侧‘取消’按钮

 @param viewController 需要添加的控制器
 */
- (void)addLeftCancleToViewController:(UIViewController *)viewController;

/**
 获取原图
 */
- (void(^)(NSArray *))artworkMaster;

/** 相册列表页面cell高度 默认值为65**/
@property(nonatomic, assign)CGFloat rowHeight;
/**
 预览页面最大选择数,默认值为3
 */
@property(nonatomic, assign) NSInteger maxSelectImageCount;
/** 预览页面选择标签文字颜色，默认值为白色**/
@property(nonatomic, weak) UIColor *textColor;
/** 预览页面选择标签背景色**/
@property(nonatomic, weak) UIColor *backgroundTextColor;
/** 预览页面cell间距 默认为2**/
@property(nonatomic, assign)CGFloat previewSpacing;
/** 预览页面列数 默认为4**/
@property(nonatomic, assign)NSInteger columnNumber;

@property (weak, nonatomic) id <YANNavigationViewControllerDelegate> delegate_;

@end
