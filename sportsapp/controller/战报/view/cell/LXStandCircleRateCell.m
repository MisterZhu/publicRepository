//
//  LXStandCircleRateCell.m
//  testDemo
//
//  Created by MCM on 2019/4/22.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXStandCircleRateCell.h"

@implementation LXStandCircleRateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID = @"LXStandCircleRateCell";
    LXStandCircleRateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LXStandCircleRateCell" owner:self options:0] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)setName:(NSString *)name{
    _name = name;
    _nameLB.text = _name;
}
- (void)setHisModel:(ComplexHis_Handicap *)hisModel{
    _hisModel = hisModel;
    CGFloat total = _hisModel.win + _hisModel.draw + _hisModel.lost;
    NSArray *totalAry = @[@(_hisModel.win/total),@(_hisModel.draw/total),@(_hisModel.lost/total)];
    
    CGFloat pan = _hisModel.winpan + _hisModel.drawpan + _hisModel.lostpan;
    NSArray *panAry = @[@(_hisModel.winpan/pan),@(_hisModel.drawpan/pan),@(_hisModel.lostpan/pan)];

    CGFloat jinshi = _hisModel.jinqiu + _hisModel.shiqiu;
    NSArray *jinshiAry = @[@(_hisModel.jinqiu/jinshi),@(_hisModel.shiqiu/jinshi)];
    
    WS(weakSelf);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.0* NSEC_PER_SEC)),dispatch_get_main_queue(),^{
        //0秒后执行这里的代码...
        [weakSelf setCircleWithTotal:totalAry withPan:panAry withJinShi:jinshiAry];
    });
    _oneRedLB.text = [NSString stringWithFormat:@"%0.0lf胜",_hisModel.win];
    _oneGreenLB.text = [NSString stringWithFormat:@"%0.0lf平",_hisModel.draw];
    _oneBlueLB.text = [NSString stringWithFormat:@"%0.0lf负",_hisModel.lost];

    _twoRedLB.text = [NSString stringWithFormat:@"%0.0lf赢",_hisModel.winpan];
    _twoGreenLB.text = [NSString stringWithFormat:@"%0.0lf走",_hisModel.drawpan];
    _twoBlueLB.text = [NSString stringWithFormat:@"%0.0lf输",_hisModel.lostpan];

    _threeRedLB.text = [NSString stringWithFormat:@"%0.0lf进",_hisModel.jinqiu];
    _threeGreenLB.text = [NSString stringWithFormat:@"%0.0lf失",_hisModel.shiqiu];

}
- (void)setHisSameModel:(ComHis_Same_Handicap *)hisSameModel{
    _hisSameModel = hisSameModel;
    CGFloat total = _hisSameModel.win + _hisSameModel.draw + _hisSameModel.lost;
    NSArray *totalAry = @[@(_hisSameModel.win/total),@(_hisSameModel.draw/total),@(_hisSameModel.lost/total)];
    
    CGFloat pan = _hisSameModel.winpan + _hisSameModel.drawpan + _hisSameModel.lostpan;
    NSArray *panAry = @[@(_hisSameModel.winpan/pan),@(_hisSameModel.drawpan/pan),@(_hisSameModel.lostpan/pan)];
    
    CGFloat jinshi = _hisSameModel.jinqiu + _hisSameModel.shiqiu;
    NSArray *jinshiAry = @[@(_hisSameModel.jinqiu/jinshi),@(_hisSameModel.shiqiu/jinshi)];
    
    WS(weakSelf);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.0* NSEC_PER_SEC)),dispatch_get_main_queue(),^{
        //0秒后执行这里的代码...
        [weakSelf setCircleWithTotal:totalAry withPan:panAry withJinShi:jinshiAry];
    });
    _oneRedLB.text = [NSString stringWithFormat:@"%0.0lf胜",_hisSameModel.win];
    _oneGreenLB.text = [NSString stringWithFormat:@"%0.0lf平",_hisSameModel.draw];
    _oneBlueLB.text = [NSString stringWithFormat:@"%0.0lf负",_hisSameModel.lost];
    
    _twoRedLB.text = [NSString stringWithFormat:@"%0.0lf赢",_hisSameModel.winpan];
    _twoGreenLB.text = [NSString stringWithFormat:@"%0.0lf走",_hisSameModel.drawpan];
    _twoBlueLB.text = [NSString stringWithFormat:@"%0.0lf输",_hisSameModel.lostpan];
    
    _threeRedLB.text = [NSString stringWithFormat:@"%0.0lf进",_hisSameModel.jinqiu];
    _threeGreenLB.text = [NSString stringWithFormat:@"%0.0lf失",_hisSameModel.shiqiu];
}
- (void)setCircleWithTotal:(NSArray *)total withPan:(NSArray *)pan withJinShi:(NSArray *)jinshi{
    JLRingChart *oneRing = [[JLRingChart alloc]initWithFrame:_circleOneV.frame];
    //传入的显示数值，注意总和应等于100%
    oneRing.valueDataArr = total;//必须有
    //设置圆环的宽度
    oneRing.ringWidth = 5;
    //设置圆环的中间点显示角度
    oneRing.angle = 0;
    //传入所需值后开始画图层
    [oneRing startToDrawLayer];//必须有
    [self addSubview:oneRing];
    
    JLRingChart *twoRing = [[JLRingChart alloc]initWithFrame:_circleTwoV.frame];
    //传入的显示数值，注意总和应等于100%
    twoRing.valueDataArr = pan;//必须有
    //设置圆环的宽度
    twoRing.ringWidth = 5;
    //设置圆环的中间点显示角度
    twoRing.angle = 0;
    //传入所需值后开始画图层
    [twoRing startToDrawLayer];//必须有
    [self addSubview:twoRing];

    JLRingChart *threeRing = [[JLRingChart alloc]initWithFrame:_circleThreeV.frame];
    //传入的显示数值，注意总和应等于100%
    threeRing.valueDataArr = jinshi;//必须有
    //设置圆环的宽度
    threeRing.ringWidth = 5;
    //设置圆环的中间点显示角度
    threeRing.angle = 0;
    //传入所需值后开始画图层
    [threeRing startToDrawLayer];//必须有
    [self addSubview:threeRing];
    
}
@end
