//
//Created by ESJsonFormatForMac on 19/04/22.
//

#import <Foundation/Foundation.h>

@class ComplexResult,ComplexRows,ComplexMatch,ComplexHis_Handicap,ComplexOdd,ComplexHome,ComplexAway,ComHis_Same_Handicap;
@interface MCStandComplexModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) ComplexResult *Result;

@end
@interface ComplexResult : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) ComplexRows *rows;

@end

@interface ComplexRows : NSObject

@property (nonatomic, strong) ComplexHis_Handicap *his_handicap;

@property (nonatomic, strong) ComplexMatch *match;

@property (nonatomic, strong) ComplexOdd *odd;

@property (nonatomic, strong) ComHis_Same_Handicap *his_same_handicap;

@property (nonatomic, strong) NSArray *away_future;

@property (nonatomic, strong) NSArray *home_future;

@end

@interface ComplexMatch : NSObject

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

@interface ComplexHis_Handicap : NSObject

@property (nonatomic, assign) CGFloat winpan;

@property (nonatomic, assign) CGFloat lostpan;

@property (nonatomic, assign) CGFloat jinqiu;

@property (nonatomic, copy) NSString *winpercent;

@property (nonatomic, assign) CGFloat lost;

@property (nonatomic, assign) CGFloat drawpan;

@property (nonatomic, assign) CGFloat win;

@property (nonatomic, assign) CGFloat shiqiu;

@property (nonatomic, assign) CGFloat draw;

@property (nonatomic, copy) NSString *winpanpercent;

@end

@interface ComplexOdd : NSObject

@property (nonatomic, strong) ComplexHome *home;

@property (nonatomic, strong) ComplexAway *away;

@end

@interface ComplexHome : NSObject

@property (nonatomic, assign) NSInteger winpan;

@property (nonatomic, assign) NSInteger lostpan;

@property (nonatomic, assign) NSInteger jinqiu;

@property (nonatomic, copy) NSString *winpercent;

@property (nonatomic, assign) NSInteger lost;

@property (nonatomic, assign) NSInteger drawpan;

@property (nonatomic, assign) NSInteger win;

@property (nonatomic, assign) NSInteger shiqiu;

@property (nonatomic, assign) NSInteger draw;

@property (nonatomic, copy) NSString *winpanpercent;

@end

@interface ComplexAway : NSObject

@property (nonatomic, assign) NSInteger winpan;

@property (nonatomic, assign) NSInteger lostpan;

@property (nonatomic, assign) NSInteger jinqiu;

@property (nonatomic, copy) NSString *winpercent;

@property (nonatomic, assign) NSInteger lost;

@property (nonatomic, assign) NSInteger drawpan;

@property (nonatomic, assign) NSInteger win;

@property (nonatomic, assign) NSInteger shiqiu;

@property (nonatomic, assign) NSInteger draw;

@property (nonatomic, copy) NSString *winpanpercent;

@end

@interface ComHis_Same_Handicap : NSObject

@property (nonatomic, assign) CGFloat winpan;

@property (nonatomic, assign) CGFloat lostpan;

@property (nonatomic, assign) CGFloat jinqiu;

@property (nonatomic, copy) NSString *winpercent;

@property (nonatomic, assign) CGFloat lost;

@property (nonatomic, assign) CGFloat drawpan;

@property (nonatomic, assign) CGFloat win;

@property (nonatomic, assign) CGFloat shiqiu;

@property (nonatomic, assign) CGFloat draw;

@property (nonatomic, copy) NSString *winpanpercent;

@end

