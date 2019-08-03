//
//  MCScoreFootballModel.m
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "MCScoreFootballModel.h"

@implementation MCScoreFootballModel


@end

@implementation FootBallResult


@end


@implementation FootBallRows

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"events" : [FootBallEvents class]};
}


@end


@implementation FootBallMatch


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation FootBallEvents


@end


@implementation FootBallData


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation DataType


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation FootBallAway


@end

@implementation FootBallHome


@end

@implementation FootBallUp


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation UpType


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation FootBallDown


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation DownType


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



