//
//  MCScoreFoDaModel.m
//  testDemo
//
//  Created by MCM on 2019/4/21.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "MCScoreFoDaModel.h"

@implementation MCScoreFoDaModel


@end

@implementation FoDaResult


@end


@implementation FoDaRows

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"technics" : [FoDaTechnics class]};
}


@end


@implementation FoDaMatch


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation FoDaTechnics


@end


@implementation Technic_Type


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end



