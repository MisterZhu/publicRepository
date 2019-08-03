//
//  LXStandCircleRateCell.h
//  testDemo
//
//  Created by MCM on 2019/4/22.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXStandCircleRateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet JLRingChart *circleOneV;
@property (weak, nonatomic) IBOutlet JLRingChart *circleTwoV;
@property (weak, nonatomic) IBOutlet JLRingChart *circleThreeV;

@property (weak, nonatomic) IBOutlet UILabel *oneRedLB;
@property (weak, nonatomic) IBOutlet UILabel *oneGreenLB;
@property (weak, nonatomic) IBOutlet UILabel *oneBlueLB;

@property (weak, nonatomic) IBOutlet UILabel *twoRedLB;
@property (weak, nonatomic) IBOutlet UILabel *twoGreenLB;
@property (weak, nonatomic) IBOutlet UILabel *twoBlueLB;

@property (weak, nonatomic) IBOutlet UILabel *threeRedLB;
@property (weak, nonatomic) IBOutlet UILabel *threeGreenLB;

@property (nonatomic, strong)ComplexHis_Handicap *hisModel;
@property (nonatomic, strong)ComHis_Same_Handicap *hisSameModel;

@property (nonatomic, strong) NSString *name;

+ (instancetype)cellForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
