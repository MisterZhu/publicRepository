//
//  LXScoreCell.m
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXScoreCell.h"

@implementation LXScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID = @"LXScoreCell";
    LXScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LXScoreCell" owner:self options:0] firstObject];
    }
    return cell;
}
- (void)setItme:(Items *)itme{
    _itme = itme;
    _dateLB.text = [NSString stringWithFormat:@" %@ ",_itme.date];
    _numberLB.text = [NSString stringWithFormat:@"%@ %@",_itme.number,_itme.league];
    _stateLB.text = _itme.state;
    _homeNameLB.text = _itme.home;
    _awayNameLB.text = _itme.away;
    [_homeIcon sd_setImageWithURL:[NSURL URLWithString:_itme.home_logo]];
    [_awayIcon sd_setImageWithURL:[NSURL URLWithString:_itme.away_logo]];
    if (_itme.odds.length>0) {
        NSArray *array = [_itme.odds componentsSeparatedByString:@" "];
        if (array.count == 3) {
            _oddsLB.text = [NSString stringWithFormat:@"胜 %@ 平 %@ 负 %@",array[0],array[1],array[2]];
        }else{
            _oddsLB.text = _itme.odds;
        }
        _stateLB.textColor = UIColorFromRGB(kColorRead, 1.0);
    }else{
        _oddsLB.text = [NSString stringWithFormat:@"客 %@ 主 %@",_itme.away_concede_odds,_itme.home_concede_odds];
        _stateLB.textColor = UIColorFromRGB(kColorLabelH, 1.0);
    }
    
}
- (void)setModel:(StandMatchs *)model{
    _model = model;
    _dateLB.text = [NSString stringWithFormat:@" %@ ",_model.date];
    _numberLB.text = [NSString stringWithFormat:@"%@ %@",_model.number,_model.league];
    _stateLB.text = _model.state;
    _homeNameLB.text = _model.home;
    _awayNameLB.text = _model.away;
    [_homeIcon sd_setImageWithURL:[NSURL URLWithString:_model.home_logo]];
    [_awayIcon sd_setImageWithURL:[NSURL URLWithString:_model.away_logo]];
    if (_model.odds.length>0) {
        NSArray *array = [_model.odds componentsSeparatedByString:@" "];
        if (array.count == 3) {
            _oddsLB.text = [NSString stringWithFormat:@"胜 %@ 平 %@ 负 %@",array[0],array[1],array[2]];
        }else{
            _oddsLB.text = _model.odds;
        }
        _stateLB.textColor = UIColorFromRGB(kColorRead, 1.0);
    }else{
        _oddsLB.text = [NSString stringWithFormat:@"客 %@ 主 %@",_model.away_concede_odds,_model.home_concede_odds];
        _stateLB.textColor = UIColorFromRGB(kColorLabelH, 1.0);
    }
}
@end
