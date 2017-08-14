//
//  YANPreviewCollectionController.h
//  YANImagePickerController
//
//  Created by yan on 2017/8/8.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YANAlbumModel;
@interface YANPreviewCollectionController : UICollectionViewController

- (instancetype)initWithColumnNumber:(NSInteger)columnNumber previewSpacing:(CGFloat)previewSpacing;
@property (nonatomic, strong) YANAlbumModel *model;

@end
