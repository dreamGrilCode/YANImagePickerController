//
//  YANNavigationViewController.m
//  YANImagePickerController
//
//  Created by yan on 2017/8/8.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import "YANNavigationViewController.h"
#import "YANAlbumListTableController.h"
#import "YANPreviewCollectionController.h"
#import "YANAlbumManage.h"

#define colorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface YANNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation YANNavigationViewController
+ (YANNavigationViewController *)navigationViewControllerRowHeight:(CGFloat)rowHeight columnNumber:(NSInteger)columnNumber previewSpacing:(CGFloat)previewSpacing{

    return (YANNavigationViewController *)[YANAlbumListTableController albumListTableControllerRowHeight:rowHeight columnNumber:columnNumber previewSpacing:previewSpacing];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundColor:[UIColor whiteColor]];
    NSMutableDictionary *sttr = [[NSMutableDictionary alloc] init];
    sttr[NSForegroundColorAttributeName]= [UIColor blackColor];
    sttr[NSFontAttributeName]= [UIFont boldSystemFontOfSize:17];
    [bar setTitleTextAttributes:sttr];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    
    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)addLeftCancleToViewController:(UIViewController *)viewController{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:colorRGB(17, 188, 255) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    viewController.navigationItem.rightBarButtonItem = item;
}
- (void)dissMiss{
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"backNav"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"backNav"] forState:UIControlStateHighlighted];
        [backBtn setTitle:@"相册" forState:UIControlStateNormal];
        [backBtn setTitleColor:colorRGB(71, 188, 255) forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(OnClickBack) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)OnClickBack{
    [self popViewControllerAnimated:YES];
}
- (void (^)(NSArray *))artworkMaster{
    
    __weak typeof(self)weakSelf = self;
    return ^(NSArray * imageArray){
        for (id asset in imageArray) {
            [[YANAlbumManage defaultManager] getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
                if ([weakSelf.delegate_ respondsToSelector:@selector(navigationViewControllerDisposeImage:)]) {
                    [weakSelf.delegate_ navigationViewControllerDisposeImage:photo];
                }
            }];
        }
    };
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return self.childViewControllers.count > 1;
}

@end
