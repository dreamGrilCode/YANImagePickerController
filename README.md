# YANImagePickerController
图片选择器；相册预览；

- 获取相册的权限：
```objc
[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
 }];
 ```
- 初始化
```objc
  YANNavigationViewController *rootVC = [YANNavigationViewController navigationViewControllerRowHeight:65 columnNumber:3 previewSpacing:10];
  rootVC.delegate_ = self;
  rootVC.maxSelectImageCount = 6;
  [self presentViewController:rootVC animated:YES completion:^{ }];
```
 - 基础设置
 ```objc
/**
 预览页面最大选择数,默认值为3
 */
@property(nonatomic, assign) NSInteger maxSelectImageCount;
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
 ```
 - YANNavigationViewControllerDelegate
 ```objc
 // 获取选择的原图，点击发送时调用,
 - (void)navigationViewControllerDisposeImage:(UIImage *)sendImage;
 ```
- 说明

 YANAlbumListTableController 相册列表控制器
 
 YANNavigationViewController 导航控制器
 
 YANPreviewCollectionController 照片列表控制器
 
 YANPreviewCollectionCell 照片item
 
 YANAlbumListTableCell 相册列表cell


![image](https://github.com/dreamGrilCode/YANImagePickerController/blob/master/image/2.png)
![image](https://github.com/dreamGrilCode/YANImagePickerController/blob/master/image/1.jpg)

