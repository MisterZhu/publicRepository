//
//  MCLabel.m
//  QuFuTong
//
//  Created by 颜廷洋 on 2018/11/21.
//  Copyright © 2018 quFuTong. All rights reserved.
//

#import "MCLabel.h"

@implementation MCLabel

- (id)initWithFrame:(CGRect)frame
               text:(NSString *)text
          textColor:(NSUInteger)textColor
           fontSize:(CGFloat)fontSize{
    self = [super initWithFrame:frame];
    if(self){
        self.text = text;
        self.textColor = UIColorFromRGB(textColor,1.0);
        self.numberOfLines = 0;
        //self.adjustsFontSizeToFitWidth = YES;
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    return self;
}

- (void)setHTMLText:(NSString *)html{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding]
                                                                   options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil
                                                                     error:nil];
    self.attributedText = attrStr;
}
@end
