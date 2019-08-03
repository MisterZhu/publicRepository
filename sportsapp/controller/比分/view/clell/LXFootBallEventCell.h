//
//  LXFootBallEventCell.h
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXFootBallEventCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *homeUpIcon;
@property (weak, nonatomic) IBOutlet UIImageView *homeDownIcon;

@property (weak, nonatomic) IBOutlet UILabel *homeUpName;
@property (weak, nonatomic) IBOutlet UILabel *homeDownName;

@property (weak, nonatomic) IBOutlet UIImageView *homeStateIcon;
@property (weak, nonatomic) IBOutlet UILabel *homeStateName;

@property (weak, nonatomic) IBOutlet UIImageView *awayUpIcon;
@property (weak, nonatomic) IBOutlet UILabel *awayUpName;

@property (weak, nonatomic) IBOutlet UIImageView *awayDownIcon;
@property (weak, nonatomic) IBOutlet UILabel *awayDownName;


@property (weak, nonatomic) IBOutlet UIImageView *awayStateIcon;
@property (weak, nonatomic) IBOutlet UILabel *awayStateName;

@property (weak, nonatomic) IBOutlet UILabel *timeLB;

@property (nonatomic, strong) FootBallEvents *model;

+ (instancetype)cellForTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
