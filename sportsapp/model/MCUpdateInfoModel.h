//
//  MCUpdateInfoModel.h
//  testDemo
//
//  Created by MCM on 2019/3/30.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UpdateResult;
@interface MCUpdateInfoModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) UpdateResult *Result;

@end
@interface UpdateResult : NSObject

@property (nonatomic, assign) NSInteger appHardVersion;

@property (nonatomic, copy) NSString *AppDataCenter;

@end



NS_ASSUME_NONNULL_END
