//
//  BaseNavigationBar.m
//  YLSJF
//
//  Created by 陈小东 on 2017/10/23.
//  Copyright © 2017年 杭州中佰金融信息服务有限公司. All rights reserved.
//

#import "BaseNavigationBar.h"

@implementation BaseNavigationBar

- (id)init{
    if(self = [super initWithFrame:CGRectMake(0, 0, KScreenWidth, Height_NavBar)]){
        self.backgroundColor = FrameColor;
        
        _titleL = [[MCLabel alloc] initWithFrame:CGRectMake(KScreenWidth/2-110, Height_StatusBar+7, 220, 30)
                                            text:nil
                                       textColor:0xFFFFFF
                                        fontSize:16];
        self.titleL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleL];
        
        _titleBtn = [ZMCUIButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.frame = aFrame(KScreenWidth/2-110, Height_StatusBar+7, 220, 30);
        _titleBtn.midSpacing = ZMC_HeightScale(5);
        
        [_titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_titleBtn.titleLabel setFont:FrameMainFont];
        [self addSubview:_titleBtn];
        
        _lBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Height_StatusBar, 80, 44)];
        self.lBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        [self.lBtn setImage:kIMAGE(@"acc-l-w") forState:UIControlStateNormal];
        self.lBtn.titleLabel.font = FrameThreeFont;
        [self.lBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.lBtn];
        
        _rBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth-80, Height_StatusBar, 80, 44)];
        self.rBtn.titleLabel.font = FrameThreeFont;
        self.rBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25);
        [self.rBtn setTitleColor:UIColorFromRGB(kColorG, 1.0) forState:UIControlStateNormal];
        //[self.rBtn setAdjustsImageWhenHighlighted:NO];
        [self addSubview:self.rBtn];
        
        _sepatator = [[MCSeparator alloc] initWithFrame:CGRectMake(0, Height_NavBar-0.5, KScreenWidth, 0.5)];
        [self addSubview:self.sepatator];
        
//        _titleView = [[UIView alloc] initWithFrame:aFrame(80, Height_StatusBar, KScreenWidth-160, 44)];
//        //_titleView.centerY = self.centerY;
//        [self addSubview:self.titleView];

    }
    return self;
}
-(void)setTitleView:(UIView *)titleView{
    _titleView = titleView;
    [self addSubview:self.titleView];

}

@end

