//
//  LXScoreDetHeadView.h
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBasektDetModel.h"
#import "MCScoreFootballModel.h"
#import "MCStandComplexModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXScoreDetHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *dateLB;
@property (weak, nonatomic) IBOutlet UILabel *scoreLB;
@property (weak, nonatomic) IBOutlet UIImageView *homeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *awayIcon;
@property (weak, nonatomic) IBOutlet UILabel *homeNameLB;
@property (weak, nonatomic) IBOutlet UILabel *awayNameLB;

@property (nonatomic, strong) DetMatch *model;
@property (nonatomic, strong) FootBallMatch *footModel;
@property (nonatomic, strong) ComplexMatch *complexModel;

@property (weak, nonatomic) IBOutlet UIView *homeBgV;
@property (weak, nonatomic) IBOutlet UIView *awayBgV;

@end

NS_ASSUME_NONNULL_END
