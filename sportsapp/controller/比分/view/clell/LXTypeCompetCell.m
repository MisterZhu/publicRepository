//
//  LXTypeCompetCell.m
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXTypeCompetCell.h"

@implementation LXTypeCompetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLB.text = _title;
    self.titleBgV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.titleLB.textColor = UIColorFromRGB(kColorGSecondary, 1.0);
}
@end
