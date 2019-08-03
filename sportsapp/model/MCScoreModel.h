//
//Created by ESJsonFormatForMac on 19/04/19.
//

#import <Foundation/Foundation.h>

@class Result,Rows,Items;
@interface MCScoreModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) Result *Result;

@end
@interface Result : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray *rows;

@end

@interface Rows : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *week;

@end

@interface Items : NSObject

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
@property (nonatomic, copy) NSString *home_concede_score;
@property (nonatomic, copy) NSString *away_concede_score;
@property (nonatomic, copy) NSString *home_odds;
@property (nonatomic, copy) NSString *away_odds;

@end

