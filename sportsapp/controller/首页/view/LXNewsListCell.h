//
//  LXNewsListCell.h
//  testDemo
//
//  Created by WEI ZOU on 2019/4/23.
//  Copyright © 2019 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXNewsListCell : UITableViewCell
@property (nonatomic, strong) NewsRows *model;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *dateLB;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
