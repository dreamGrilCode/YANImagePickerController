//
//  YANBottomSendView.h
//  YANImagePickerController
//
//  Created by yan on 2017/8/11.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YANBottomSendViewDelegate <NSObject>

@optional
- (void)bottomSendViewClickSendPhoto;

@end

@interface YANBottomSendView : UIView

@property (weak, nonatomic) id <YANBottomSendViewDelegate> delegate_;

@end
