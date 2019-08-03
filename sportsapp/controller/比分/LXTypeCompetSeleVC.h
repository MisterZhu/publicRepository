//
//  LXTypeCompetSeleVC.h
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXTypeCompetSeleVC : BaseViewController

typedef void(^LXTypeCompetBlock)(NSMutableArray *selectAry);

@property (nonatomic, copy) LXTypeCompetBlock clickSureBlack;

@property (nonatomic, strong) NSString *Opcode;
@end

NS_ASSUME_NONNULL_END
