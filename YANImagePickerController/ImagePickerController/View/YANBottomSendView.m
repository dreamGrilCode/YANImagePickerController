//
//  YANBottomSendView.m
//  YANImagePickerController
//
//  Created by yan on 2017/8/11.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import "YANBottomSendView.h"

#define defaultButtonBackgroundColor [UIColor colorWithRed:71/255.0 green:188/255.0 blue:255/255.0 alpha:1]

@implementation YANBottomSendView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat btnY = 5;
        CGFloat btnH = frame.size.height - btnY * 2;
        CGFloat btnW = 60;
        UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - btnW - btnY , btnY, btnW, btnH)];
        [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        sendBtn.layer.masksToBounds = YES;
        sendBtn.layer.cornerRadius = 5;
        sendBtn.backgroundColor = defaultButtonBackgroundColor;
        [sendBtn addTarget:self action:@selector(sendPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendBtn];
    }
    return self;
}
- (void)sendPhoto{

    if ([self.delegate_ respondsToSelector:@selector(bottomSendViewClickSendPhoto)]) {
        [self.delegate_ bottomSendViewClickSendPhoto];
    }
}
@end
