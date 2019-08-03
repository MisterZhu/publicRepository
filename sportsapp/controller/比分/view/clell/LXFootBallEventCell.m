//
//  LXFootBallEventCell.m
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXFootBallEventCell.h"

@implementation LXFootBallEventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID = @"LXFootBallEventCell";
    LXFootBallEventCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LXFootBallEventCell" owner:self options:0] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)setModel:(FootBallEvents *)model{
    _model = model;
    _timeLB.text = [NSString stringWithFormat:@"%@",_model.time];

    if (_model.data.player) {
        if (_model.data.home_or_away) {
            _homeStateName.text = _model.data.player;
            _homeStateIcon.image = kIMAGE(_model.data.type.value);
        }else{
            _awayStateName.text = _model.data.player;
            _awayStateIcon.image = kIMAGE(_model.data.type.value);
        }
    }else{
        if (_model.data.home) {
            if (_model.data.home.up) {
                _homeUpIcon.hidden = NO;
                _homeUpIcon.image = kIMAGE(_model.data.home.up.type.value);
                _homeUpName.text = _model.data.home.up.player;
            }
            if (_model.data.home.down) {
                _homeDownIcon.hidden = NO;
                _homeDownIcon.image = kIMAGE(_model.data.home.down.type.value);
                _homeDownName.text = _model.data.home.down.player;
            }
        }else if (_model.data.away){
            if (_model.data.away.up) {
                _awayUpIcon.hidden = NO;
                _awayUpIcon.image = kIMAGE(_model.data.away.up.type.value);
                _awayUpName.text = _model.data.away.up.player;
            }
            if (_model.data.away.down) {
                _awayDownIcon.hidden = NO;
                _awayDownIcon.image = kIMAGE(_model.data.away.down.type.value);
                _awayDownName.text = _model.data.away.down.player;
            }
        }
    }
}
@end
