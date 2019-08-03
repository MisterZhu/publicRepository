//
//Created by ESJsonFormatForMac on 19/04/23.
//

#import "MCNewsListModel.h"
@implementation MCNewsListModel


@end

@implementation NewsResult

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rows" : [NewsRows class]};
}


@end


@implementation NewsRows


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


