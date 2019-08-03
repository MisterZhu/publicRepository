//
//  LXFootBallDataCell.m
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXFootBallDataCell.h"

@implementation LXFootBallDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID = @"LXFootBallDataCell";
    LXFootBallDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LXFootBallDataCell" owner:self options:0] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)setModel:(FoDaTechnics *)model{
    _model = model;
    if (_model.home_stats.length>0) {
        _homeNumLB.text = _model.home_stats;
    }
    if (_model.away_stats.length>0) {
        _awayNumLB.text = _model.away_stats;
    }
    _titleNameLB.text = _model.technic_type.value;
}
@end
