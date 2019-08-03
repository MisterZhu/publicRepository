//
//  LXStandLineRateCell.h
//  testDemo
//
//  Created by MCM on 2019/4/22.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXStandLineRateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *redLB;
@property (weak, nonatomic) IBOutlet UILabel *greenLB;
@property (weak, nonatomic) IBOutlet UILabel *blueLB;
@property (weak, nonatomic) IBOutlet UILabel *orangeLB;
@property (weak, nonatomic) IBOutlet UILabel *violetLB;

@property (weak, nonatomic) IBOutlet UIView *redLine;
@property (weak, nonatomic) IBOutlet UIView *greenLine;
@property (weak, nonatomic) IBOutlet UIView *blueLine;
@property (weak, nonatomic) IBOutlet UIView *orangeLine;
@property (weak, nonatomic) IBOutlet UIView *violetLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greenWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orangeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *violetWidth;


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) ComplexHome *homeModel;
@property (nonatomic, strong) ComplexAway *awayModel;
@property (nonatomic) BOOL isLeft;
+ (instancetype)cellForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
