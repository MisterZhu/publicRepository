//
//  LXStandDetailVC.h
//  testDemo
//
//  Created by WEI ZOU on 2019/4/22.
//  Copyright © 2019 xiguadianjing. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXStandDetailVC : BaseViewController


/**
 战绩
 */
@property (nonatomic, strong) NSString *complexOpcode;

/**
 综合
 */
@property (nonatomic, strong) NSString *recordOpcode;

@property (nonatomic, assign) NSInteger matchID;

@end

NS_ASSUME_NONNULL_END
