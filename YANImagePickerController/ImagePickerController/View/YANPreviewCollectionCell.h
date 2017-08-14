//
//  YANPreviewCollectionCell.h
//  YANImagePickerController
//
//  Created by yan on 2017/8/10.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YANPreviewCollectionCellDelegate <NSObject>

@optional
- (void)previewCollectionCellSelectImage:(id)asset  label:(UILabel *)label;

@end

@interface YANPreviewCollectionCell : UICollectionViewCell
// 设置数据
- (UILabel *)setImage:(id)asset selectImageArray:(NSArray *)selectImageArray;

@property (weak, nonatomic) id <YANPreviewCollectionCellDelegate> delegate_;

@end
