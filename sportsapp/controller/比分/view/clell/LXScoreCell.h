//
//  LXScoreCell.h
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXScoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLB;

@property (nonatomic, strong) Items *itme;
@property (nonatomic, strong) StandMatchs *model;

@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *stateLB;
@property (weak, nonatomic) IBOutlet UILabel *homeNameLB;
@property (weak, nonatomic) IBOutlet UILabel *awayNameLB;
@property (weak, nonatomic) IBOutlet UIImageView *homeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *awayIcon;
@property (weak, nonatomic) IBOutlet UILabel *oddsLB;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
