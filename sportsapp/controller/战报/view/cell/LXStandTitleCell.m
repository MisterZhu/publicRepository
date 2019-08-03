//
//  LXStandTitleCell.m
//  testDemo
//
//  Created by MCM on 2019/4/22.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXStandTitleCell.h"

@implementation LXStandTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID = @"LXStandTitleCell";
    LXStandTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LXStandTitleCell" owner:self options:0] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)setTitleAry:(NSArray *)titleAry{
    _titleAry = titleAry;
    if (_titleAry.count == 6) {
        _oneLB.text = [NSString stringWithFormat:@"%@",_titleAry[0]];
        _twoLB.text = [NSString stringWithFormat:@"%@",_titleAry[1]];
        _threeLB.text = [NSString stringWithFormat:@"%@%@%@",_titleAry[2],_titleAry[3],_titleAry[4]];
        _fourLB.text = [NSString stringWithFormat:@"%@",_titleAry[5]];
    }
    if (_titleAry.count == 5) {
        _oneLB.text = [NSString stringWithFormat:@"%@",_titleAry[0]];
        _twoLB.text = [NSString stringWithFormat:@"%@",_titleAry[1]];
        _threeLB.text = [NSString stringWithFormat:@"%@%@%@",_titleAry[2],@"VS",_titleAry[3]];
        _fourLB.text = [NSString stringWithFormat:@"%@",_titleAry[4]];
    }
}
- (void)setRecordAry:(NSArray *)recordAry{
    _recordAry = recordAry;
    if (_recordAry.count == 7) {
        _oneLB.text = [NSString stringWithFormat:@"%@",_recordAry[0]];
        _twoLB.text = [NSString stringWithFormat:@"%@",_recordAry[1]];
        _threeLB.text = [NSString stringWithFormat:@"%@%@%@",_recordAry[2],_recordAry[3],_recordAry[4]];
        _fourLB.text = [NSString stringWithFormat:@"%@",_recordAry[6]];
        _fourLB.textColor = UIColorFromRGB(kColorRead, 1.0);
    }
    if (_recordAry.count == 6) {
        _oneLB.text = [NSString stringWithFormat:@"%@",_recordAry[0]];
        _twoLB.text = [NSString stringWithFormat:@"%@",_recordAry[1]];
        _threeLB.text = [NSString stringWithFormat:@"%@%@%@",_recordAry[2],_recordAry[3],_recordAry[4]];
        _fourLB.text = [NSString stringWithFormat:@"%@",_recordAry[5]];
        _fourLB.textColor = UIColorFromRGB(kColorRead, 1.0);
    }
}
@end
