//
//  YANAlbumListTableCell.m
//  YANImagePickerController
//
//  Created by yan on 2017/8/10.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import "YANAlbumListTableCell.h"
#import "YANAlbumModel.h"
#import "YANAlbumManage.h"

@implementation YANAlbumListTableCell

- (void)setAlbumInfo:(YANAlbumModel *)albumInfo{

    _albumInfo = albumInfo;
    self.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",albumInfo.name,(long)albumInfo.count];
    __weak typeof(self)weakSelf = self;
    [[YANAlbumManage defaultManager] getPostImageWithAlbumModel:albumInfo width:self.bounds.size.height completion:^(UIImage *image) {
        weakSelf.imageView.image = image;
    }];
}
- (void)layoutSubviews{

    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.frame = CGRectMake(5, 0, self.bounds.size.height, self.bounds.size.height);
    CGRect frame =  self.textLabel.frame;
    frame.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    self.textLabel.frame = frame;
}
@end
