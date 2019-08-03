//
//  MCStandingsModel.h
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class StandResult,StandRows,Silder_Date,StandMatchs,More_Date;
@interface MCStandingsModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) StandResult *Result;

@end
@interface StandResult : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) StandRows *rows;

@end

@interface StandRows : NSObject

@property (nonatomic, strong) NSArray *silder_date;

@property (nonatomic, strong) NSArray *matchs;

@property (nonatomic, strong) NSArray *more_date;

@end

@interface Silder_Date : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *week;

@end

@interface StandMatchs : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *issue;

@property (nonatomic, assign) NSInteger match_id;

@property (nonatomic, copy) NSString *home_score;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *home_logo;

@property (nonatomic, copy) NSString *away;

@property (nonatomic, copy) NSString *away_score;

@property (nonatomic, assign) NSInteger home_id;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *odds;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *home;

@property (nonatomic, assign) NSInteger away_id;

@property (nonatomic, copy) NSString *away_logo;

@property (nonatomic, copy) NSString *round;

@property (nonatomic, copy) NSString *half;

@property (nonatomic, copy) NSString *league;

@property (nonatomic, copy) NSString *home_concede_odds;

@property (nonatomic, copy) NSString *away_concede_odds;

@end

@interface More_Date : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *week;

@end



NS_ASSUME_NONNULL_END
