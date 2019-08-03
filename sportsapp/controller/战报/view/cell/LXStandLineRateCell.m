//
//  LXStandLineRateCell.m
//  testDemo
//
//  Created by MCM on 2019/4/22.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXStandLineRateCell.h"

@implementation LXStandLineRateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID = @"LXStandLineRateCell";
    LXStandLineRateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LXStandLineRateCell" owner:self options:0] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)setHomeModel:(ComplexHome *)homeModel{
    _homeModel = homeModel;

    if (_isLeft) {
        NSInteger total = _homeModel.winpan + _homeModel.lostpan + _homeModel.lost + _homeModel.jinqiu + _homeModel.shiqiu;
        
        _redLB.text = [NSString stringWithFormat:@"赢%ld",_homeModel.winpan];
        if (_homeModel.winpan) {
            _redWidth.constant = 200*_homeModel.winpan/total;
        }else{
            _redWidth.constant = 0;
        }
        
        _greenLB.text = [NSString stringWithFormat:@"走%ld",_homeModel.lostpan];
        if (_homeModel.lostpan) {
            _greenWidth.constant = 200*_homeModel.lostpan/total;
        }else{
            _greenWidth.constant = 0;
        }
        
        _blueLB.text = [NSString stringWithFormat:@"输%ld",_homeModel.lost];
        if (_homeModel.lost) {
            _blueWidth.constant = 200*_homeModel.lost/total;
        }else{
            _blueWidth.constant = 0;
        }
        
        _orangeLB.text = [NSString stringWithFormat:@"进%ld",_homeModel.jinqiu];
        if (_homeModel.jinqiu) {
            _orangeWidth.constant = 200*_homeModel.jinqiu/total;
        }else{
            _orangeWidth.constant = 0;
        }
        
        _violetLB.text = [NSString stringWithFormat:@"失%ld",_homeModel.shiqiu];
        if (_homeModel.shiqiu) {
            _violetWidth.constant = 200*_homeModel.shiqiu/total;
        }else{
            _violetWidth.constant = 0;
        }
    }else{
        NSInteger total = _homeModel.win + _homeModel.lost + _homeModel.draw;
        
        _redLB.text = [NSString stringWithFormat:@"胜%ld",_homeModel.win];
        if (_homeModel.win) {
            _redWidth.constant = 200*_homeModel.win/total;
        }else{
            _redWidth.constant = 0;
        }
        
        _greenLB.text = [NSString stringWithFormat:@"负%ld",_homeModel.lost];
        if (_homeModel.lost) {
            _greenWidth.constant = 200*_homeModel.lost/total;
        }else{
            _greenWidth.constant = 0;
        }
        
        _blueLB.text = [NSString stringWithFormat:@"平%ld",_homeModel.draw];
        if (_homeModel.draw) {
            _blueWidth.constant = 200*_homeModel.draw/total;
        }else{
            _blueWidth.constant = 0;
        }
        _orangeWidth.constant = 0;
        _violetWidth.constant = 0;
    }
    
}
- (void)setAwayModel:(ComplexAway *)awayModel{
    _awayModel = awayModel;
    if (_isLeft) {
        NSInteger total = _awayModel.winpan + _awayModel.lostpan + _awayModel.lost + _awayModel.jinqiu + _awayModel.shiqiu;
        
        _redLB.text = [NSString stringWithFormat:@"赢%ld",_awayModel.winpan];
        
        if (_awayModel.winpan) {
            _redWidth.constant = 200*_awayModel.winpan/total;
        }else{
            _redWidth.constant = 0;
        }
        
        _greenLB.text = [NSString stringWithFormat:@"走%ld",_awayModel.lostpan];
        if (_awayModel.lostpan) {
            _greenWidth.constant = 200*_awayModel.lostpan/total;
        }else{
            _greenWidth.constant = 0;
        }
        
        _blueLB.text = [NSString stringWithFormat:@"输%ld",_awayModel.lost];
        if (_awayModel.lost) {
            _blueWidth.constant = 200*_awayModel.lost/total;
        }else{
            _blueWidth.constant = 0;
        }
        
        _orangeLB.text = [NSString stringWithFormat:@"进%ld",_awayModel.jinqiu];
        if (_awayModel.jinqiu) {
            _orangeWidth.constant = 200*_awayModel.jinqiu/total;
        }else{
            _orangeWidth.constant = 0;
        }
        
        _violetLB.text = [NSString stringWithFormat:@"失%ld",_awayModel.shiqiu];
        if (_awayModel.shiqiu) {
            _violetWidth.constant = 200*_awayModel.shiqiu/total;
        }else{
            _violetWidth.constant = 0;
        }
    }else{
        NSInteger total = _awayModel.win + _awayModel.lost + _awayModel.draw;
        
        _redLB.text = [NSString stringWithFormat:@"胜%ld",_awayModel.win];
        
        if (_awayModel.win) {
            _redWidth.constant = 200*_awayModel.win/total;
        }else{
            _redWidth.constant = 0;
        }
        
        _greenLB.text = [NSString stringWithFormat:@"负%ld",_awayModel.lost];
        if (_awayModel.lost) {
            _greenWidth.constant = 200*_awayModel.lost/total;
        }else{
            _greenWidth.constant = 0;
        }
        
        _blueLB.text = [NSString stringWithFormat:@"平%ld",_awayModel.draw];
        if (_awayModel.draw) {
            _blueWidth.constant = 200*_awayModel.draw/total;
        }else{
            _blueWidth.constant = 0;
        }
        _orangeWidth.constant = 0;
        _violetWidth.constant = 0;

    }
    
}
-(void)setName:(NSString *)name{
    _name = name;
    _nameLB.text = _name;
}
-(void)setIsLeft:(BOOL)isLeft{
    _isLeft = isLeft;
}
@end
