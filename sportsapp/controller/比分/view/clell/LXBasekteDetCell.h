//
//  LXBasekteDetCell.h
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXBasekteDetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *oneLB;
@property (weak, nonatomic) IBOutlet UILabel *twoLB;
@property (weak, nonatomic) IBOutlet UILabel *threeLB;
@property (weak, nonatomic) IBOutlet UILabel *fourLB;
@property (weak, nonatomic) IBOutlet UILabel *fiveLB;

@property (nonatomic, strong) NSArray *homeModel;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
