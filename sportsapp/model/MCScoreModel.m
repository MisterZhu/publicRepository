//
//Created by ESJsonFormatForMac on 19/04/19.
//

#import "MCScoreModel.h"
@implementation MCScoreModel


@end

@implementation Result

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rows" : [Rows class]};
}


@end


@implementation Rows

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"items" : [Items class]};
}


@end


@implementation Items


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


