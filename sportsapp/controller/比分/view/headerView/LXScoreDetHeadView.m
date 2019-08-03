//
//  LXScoreDetHeadView.m
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXScoreDetHeadView.h"

@implementation LXScoreDetHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"LXScoreDetHeadView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    return self;
}
- (void)setModel:(DetMatch *)model{
    _model = model;
    
    self.homeBgV.layer.masksToBounds = YES;
    self.homeBgV.layer.cornerRadius = 33;
    self.homeBgV.layer.borderWidth = 3;
    self.homeBgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.awayBgV.layer.masksToBounds = YES;
    self.awayBgV.layer.cornerRadius = 33;
    self.awayBgV.layer.borderWidth = 3;
    self.awayBgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _dateLB.text = [NSString stringWithFormat:@"%@ %@",_model.issue,_model.state];
    [_homeIcon sd_setImageWithURL:[NSURL URLWithString:_model.home_logo]];
    [_awayIcon sd_setImageWithURL:[NSURL URLWithString:_model.away_logo]];
    _homeNameLB.text = _model.home;
    _awayNameLB.text = _model.away;
    _scoreLB.text = [NSString stringWithFormat:@"%@:%@",_model.home_score,_model.away_score];
}

- (void)setFootModel:(FootBallMatch *)footModel{
    _footModel = footModel;
    
    self.homeBgV.layer.masksToBounds = YES;
    self.homeBgV.layer.cornerRadius = 33;
    self.homeBgV.layer.borderWidth = 3;
    self.homeBgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.awayBgV.layer.masksToBounds = YES;
    self.awayBgV.layer.cornerRadius = 33;
    self.awayBgV.layer.borderWidth = 3;
    self.awayBgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _dateLB.text = [NSString stringWithFormat:@"%@ %@",_footModel.date,_footModel.state];
    [_homeIcon sd_setImageWithURL:[NSURL URLWithString:_footModel.home_logo]];
    [_awayIcon sd_setImageWithURL:[NSURL URLWithString:_footModel.away_logo]];
    _homeNameLB.text = _footModel.home;
    _awayNameLB.text = _footModel.away;
    _scoreLB.text = [NSString stringWithFormat:@"%@:%@",_footModel.home_score,_footModel.away_score];
}
- (void)setComplexModel:(ComplexMatch *)complexModel{
    _complexModel = complexModel;
    self.homeBgV.layer.masksToBounds = YES;
    self.homeBgV.layer.cornerRadius = 33;
    self.homeBgV.layer.borderWidth = 3;
    self.homeBgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.awayBgV.layer.masksToBounds = YES;
    self.awayBgV.layer.cornerRadius = 33;
    self.awayBgV.layer.borderWidth = 3;
    self.awayBgV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _dateLB.text = [NSString stringWithFormat:@"%@ %@",_complexModel.date,_complexModel.state];
    [_homeIcon sd_setImageWithURL:[NSURL URLWithString:_complexModel.home_logo]];
    [_awayIcon sd_setImageWithURL:[NSURL URLWithString:_complexModel.away_logo]];
    _homeNameLB.text = _complexModel.home;
    _awayNameLB.text = _complexModel.away;
    _scoreLB.text = [NSString stringWithFormat:@"%@:%@",_complexModel.home_score,_complexModel.away_score];
}
@end
