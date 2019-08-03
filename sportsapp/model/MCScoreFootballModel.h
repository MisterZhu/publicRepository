//
//  MCScoreFootballModel.h
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FootBallResult,FootBallRows,FootBallMatch,FootBallEvents,FootBallData,DataType,FootBallAway,FootBallHome,FootBallUp,UpType,FootBallDown,DownType;
@interface MCScoreFootballModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) FootBallResult *Result;

@end
@interface FootBallResult : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) FootBallRows *rows;

@end

@interface FootBallRows : NSObject

@property (nonatomic, strong) FootBallMatch *match;

@property (nonatomic, strong) NSArray *events;

@end

@interface FootBallMatch : NSObject

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

@interface FootBallEvents : NSObject

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) FootBallData *data;

@end

@interface FootBallData : NSObject

@property (nonatomic, assign) NSInteger home_or_away;

@property (nonatomic, copy) NSString *player;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger event_type;

@property (nonatomic, copy) NSString *player_assist;

@property (nonatomic, assign) NSInteger match_id;

@property (nonatomic, strong) FootBallHome *home;

@property (nonatomic, strong) FootBallAway *away;

@property (nonatomic, strong) DataType *type;

@property (nonatomic, copy) NSString *timestamp;

@end

@interface DataType : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *value;

@end

@interface FootBallAway : NSObject

@property (nonatomic, strong) FootBallUp *up;

@property (nonatomic, strong) FootBallDown *down;

@end

@interface FootBallHome : NSObject

@property (nonatomic, strong) FootBallUp *up;

@property (nonatomic, strong) FootBallDown *down;

@end

@interface FootBallUp : NSObject

@property (nonatomic, assign) NSInteger home_or_away;

@property (nonatomic, copy) NSString *player;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger event_type;

@property (nonatomic, copy) NSString *player_assist;

@property (nonatomic, assign) NSInteger match_id;

@property (nonatomic, strong) UpType *type;

@property (nonatomic, copy) NSString *timestamp;

@end

@interface UpType : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *value;

@end

@interface FootBallDown : NSObject

@property (nonatomic, assign) NSInteger home_or_away;

@property (nonatomic, copy) NSString *player;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger event_type;

@property (nonatomic, copy) NSString *player_assist;

@property (nonatomic, assign) NSInteger match_id;

@property (nonatomic, strong) DownType *type;

@property (nonatomic, copy) NSString *timestamp;

@end

@interface DownType : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *value;

@end



NS_ASSUME_NONNULL_END
