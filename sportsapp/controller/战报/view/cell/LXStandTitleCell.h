//
//  LXStandTitleCell.h
//  testDemo
//
//  Created by MCM on 2019/4/22.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXStandTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *oneLB;
@property (weak, nonatomic) IBOutlet UILabel *twoLB;
@property (weak, nonatomic) IBOutlet UILabel *threeLB;
@property (weak, nonatomic) IBOutlet UILabel *fourLB;

@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) NSArray *recordAry;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
