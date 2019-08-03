//
//  ZMCUIButton.h
//  ChatDemo-UI3.0
//
//  Created by Mac on 2016/12/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZMCLayoutButtonStyle) {
    JXLayoutButtonStyleLeftImageRightTitle,
    JXLayoutButtonStyleLeftTitleRightImage,
    JXLayoutButtonStyleUpImageDownTitle,
    JXLayoutButtonStyleUpTitleDownImage
};

@interface ZMCUIButton : UIButton

/// 布局方式
@property (nonatomic, assign) ZMCLayoutButtonStyle layoutStyle;
/// 图片和文字的间距，默认值8
@property (nonatomic, assign) CGFloat midSpacing;
/// 指定图片size
@property (nonatomic, assign) CGSize imageSize;

@end
