//
//  YANAlbumModel.h
//  YANImagePickerController
//
//  Created by yan on 2017/8/8.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YANAlbumModel : NSObject

/** 相册名称 **/
@property (nonatomic, strong) NSString  *name;
/** 相册照片数量 **/
@property (nonatomic, assign) NSInteger count;
/** 相册 **/
@property (nonatomic, strong) id result;


@end
