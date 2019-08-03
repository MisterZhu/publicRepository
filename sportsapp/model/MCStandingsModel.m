//
//  MCStandingsModel.m
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "MCStandingsModel.h"

@implementation MCStandingsModel


@end

@implementation StandResult


@end


@implementation StandRows

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"silder_date" : [Silder_Date class], @"matchs" : [StandMatchs class], @"more_date" : [More_Date class]};
}


@end


@implementation Silder_Date


@end


@implementation StandMatchs


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation More_Date


@end



