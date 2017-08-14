//
//  YANAlbumMange.h
//  YANImagePickerController
//
//  Created by yan on 2017/8/8.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class YANAlbumModel;
@interface YANAlbumManage : NSObject
+ (instancetype)defaultManager ;
/**
 获取时刻相册信息
 */
- (void)getCameraRollAlbumAllowPickingImageCompletion:(void (^)(YANAlbumModel *))completion;

/**
 获取所有相册信息
 */
- (void)getAllAlbumsCompletion:(void (^)(NSArray<YANAlbumModel *> *))completion;
/**
 获取相册中所有图片信息
 */
- (void)getAssetsFromFetchResult:(id)result  completion:(void (^)(NSArray *))completion;

/**
 获取封面
 */
- (void)getPostImageWithAlbumModel:(YANAlbumModel *)model width:(CGFloat )width completion:(void (^)(UIImage *))completion;

/**
 获取原图
 */
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;

/**
 获取指定大小图片
 */
- (int32_t)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler;

@end
