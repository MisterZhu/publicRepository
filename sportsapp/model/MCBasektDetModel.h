//
//  MCBasektDetModel.h
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//
#import <Foundation/Foundation.h>

@class DetResult,DetRows,DetMatch;
@interface MCBasektDetModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) DetResult *Result;

@end
@interface DetResult : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) DetRows *rows;

@end

@interface DetRows : NSObject

@property (nonatomic, strong) DetMatch *match;

@property (nonatomic, strong) NSDictionary *home_analyze;

@property (nonatomic, strong) NSDictionary *away_analyze;

@end

@interface DetMatch : NSObject

@property (nonatomic, copy) NSString *away_concede_score;

@property (nonatomic, copy) NSString *away_concede_odds;

@property (nonatomic, copy) NSString *away_logo;

@property (nonatomic, assign) NSInteger home_id;

@property (nonatomic, copy) NSString *away_score;

//@property (nonatomic, strong) DetAnalyze *analyze;

@property (nonatomic, copy) NSString *home_score;

@property (nonatomic, copy) NSString *away;

@property (nonatomic, assign) NSInteger match_id;

@property (nonatomic, assign) NSInteger away_id;

@property (nonatomic, copy) NSString *home_concede_score;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *home_odds;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *home;

@property (nonatomic, copy) NSString *home_concede_odds;

@property (nonatomic, copy) NSString *league;

@property (nonatomic, copy) NSString *away_odds;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *home_logo;

@property (nonatomic, copy) NSString *issue;

@end

//@interface Home_Analyze : NSObject
//
//@property (nonatomic, strong) NSArray *three;
//
//@property (nonatomic, strong) NSArray *one;
//
//@property (nonatomic, strong) NSArray *four;
//
//@property (nonatomic, strong) NSArray *two;
//
//@end
//
//@interface Away_Analyze : NSObject
//
//@property (nonatomic, strong) NSArray *three;
//
//@property (nonatomic, strong) NSArray *one;
//
//@property (nonatomic, strong) NSArray *four;
//
//@property (nonatomic, strong) NSArray *two;

//@end


