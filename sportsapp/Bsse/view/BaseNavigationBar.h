//
//  BaseNavigationBar.h
//  YLSJF
//
//  Created by 陈小东 on 2017/10/23.
//  Copyright © 2017年 杭州中佰金融信息服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationBar : UIView
@property (nonatomic,retain) MCLabel *titleL;
@property (nonatomic) ZMCUIButton *titleBtn;
@property (nonatomic,strong) UIView *titleView;

@property (nonatomic,retain) UIButton *lBtn;
@property (nonatomic,retain) UIButton *rBtn;
@property (nonatomic,retain) MCSeparator *sepatator;

@end
