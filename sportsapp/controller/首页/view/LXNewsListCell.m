//
//  LXNewsListCell.m
//  testDemo
//
//  Created by WEI ZOU on 2019/4/23.
//  Copyright © 2019 xiguadianjing. All rights reserved.
//

#import "LXNewsListCell.h"

@implementation LXNewsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID = @"LXNewsListCell";
    LXNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LXNewsListCell" owner:self options:0] firstObject];
    }
    return cell;
}
- (void)setModel:(NewsRows *)model{
    _model = model;
    _titleLB.text = _model.title;
    _dateLB.text = [NSString stringWithFormat:@"%@ | %@",_model.author,_model.date];
    NSArray *imgAry = [MethodFactory getImageurlFromHtml:_model.content];
    if (imgAry.count>0) {
        [_imageV sd_setImageWithURL:[NSURL URLWithString:imgAry[0]]];
    }
}


@end
