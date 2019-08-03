//
//  LXTypeCompetCell.h
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTypeCompetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *titleBgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (nonatomic,strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
