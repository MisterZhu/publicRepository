//
//  MCLabel.h
//  QuFuTong
//
//  Created by 颜廷洋 on 2018/11/21.
//  Copyright © 2018 quFuTong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCLabel : UILabel

- (id)initWithFrame:(CGRect)frame
               text:(NSString *)text
          textColor:(NSUInteger)textColor
           fontSize:(CGFloat)fontSize;

//如果想要改变文字的字体,请在设置setHTMLText之后设置
- (void)setHTMLText:(NSString *)html;

@end

NS_ASSUME_NONNULL_END
