//
//  LXFootBallDataCell.h
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXFootBallDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *homeNumLB;
@property (weak, nonatomic) IBOutlet UILabel *awayNumLB;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLB;

@property (nonatomic, strong) FoDaTechnics *model;

+ (instancetype)cellForTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
