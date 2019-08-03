//
//  MCScoreFoDaModel.h
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FoDaResult,FoDaRows,FoDaMatch,FoDaTechnics,Technic_Type;
@interface MCScoreFoDaModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) FoDaResult *Result;

@end
@interface FoDaResult : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) FoDaRows *rows;

@end

@interface FoDaRows : NSObject

@property (nonatomic, strong) FoDaMatch *match;

@property (nonatomic, strong) NSArray *technics;

@end

@interface FoDaMatch : NSObject

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

@end

@interface FoDaTechnics : NSObject

@property (nonatomic, strong) Technic_Type *technic_type;

@property (nonatomic, assign) NSInteger match_id;

@property (nonatomic, copy) NSString *home_stats;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *away_stats;

@property (nonatomic, copy) NSString *timestamp;

@end

@interface Technic_Type : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *value;

@end



NS_ASSUME_NONNULL_END
