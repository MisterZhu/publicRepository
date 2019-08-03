//
//  MCTabBarInfoModel.h
//  testDemo
//
//  Created by MCM on 2019/3/30.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TabBarResult,Tabinfo;
@interface MCTabBarInfoModel : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, strong) TabBarResult *Result;

@end
@interface TabBarResult : NSObject

@property (nonatomic, copy) NSString *PlatFormName;

@property (nonatomic, strong) NSArray *TabInfo;

@property (nonatomic, assign) NSInteger itemNumber;

@property (nonatomic, copy) NSString *PlatFormIP;

@end

@interface Tabinfo : NSObject

@property (nonatomic, copy) NSString *TabIcon;

@property (nonatomic, copy) NSString *TabName;

@property (nonatomic, copy) NSString *TabIconConfirm;

@property (nonatomic, copy) NSString *TabUrl;

@end



NS_ASSUME_NONNULL_END
