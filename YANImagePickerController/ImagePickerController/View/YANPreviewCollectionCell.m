//
//  YANPreviewCollectionCell.m
//  YANImagePickerController
//
//  Created by yan on 2017/8/10.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import "YANPreviewCollectionCell.h"
#import "YANAlbumManage.h"

#define defaultTextColor [UIColor whiteColor]
#define defaultBackgroundTextColor [UIColor colorWithRed:71/255.0 green:188/255.0 blue:255/255.0 alpha:1]

@interface YANPreviewCollectionCell()

@property(nonatomic, weak)UIImageView *imageView;

@property(nonatomic, weak) id asset;

@end


@implementation YANPreviewCollectionCell


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        CGFloat labW  = 20;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.bounds.size.width - labW, 0, labW, labW)];
        lab.backgroundColor =  defaultBackgroundTextColor;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = defaultTextColor;
        [imageView addSubview:lab];
        lab.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImageOrCancel:)];
        [imageView addGestureRecognizer:tap];
        
    }
    return self;
}
- (UILabel *)setImage:(id)asset selectImageArray:(NSArray *)selectImageArray{
    
    self.asset = asset;
    __weak typeof(self)weakSelf = self;
    [[YANAlbumManage defaultManager] getPhotoWithAsset:asset photoWidth:self.bounds.size.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        weakSelf.imageView.image = photo;
    } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        
    }];
    UILabel *label = self.imageView.subviews.lastObject;
    BOOL isShow = NO;
    for (int i = 0;i < selectImageArray.count ; i ++) {
        id image = selectImageArray[i];
        if (image == asset) {
            isShow = YES;
            label.text = [NSString stringWithFormat:@"%d",i + 1];
            break;
        }
    }
    label.hidden = !isShow;
    if (!label.isHidden) {
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = label.bounds.size.width / 2;
    }
    return label;
}

- (void)selectImageOrCancel:(UITapGestureRecognizer *)tap{

    UIImageView *imageview = (UIImageView *)tap.view;
    UILabel *label = (UILabel *)imageview.subviews.lastObject;
    if ([self.delegate_ respondsToSelector:@selector(previewCollectionCellSelectImage:label:)]) {
        [self.delegate_ previewCollectionCellSelectImage:self.asset label:label];
    }
}
@end
