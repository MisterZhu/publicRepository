//
//Created by ESJsonFormatForMac on 19/04/23.
//

#import <Foundation/Foundation.h>

@class RecordResult,RecordRows,RecordMatch;
@interface MCStandRecordModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) RecordResult *Result;

@end
@interface RecordResult : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) RecordRows *rows;

@end

@interface RecordRows : NSObject

@property (nonatomic, strong) RecordMatch *match;

@property (nonatomic, strong) NSArray *home_recent;

@property (nonatomic, strong) NSArray *away_recent;

@end

@interface RecordMatch : NSObject

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

