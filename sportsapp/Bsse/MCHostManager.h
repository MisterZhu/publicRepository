//
//  MCHostManager.h
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCHostManager : NSObject

@property (nonatomic,strong) NSString *APIServerHost;//服务器地址
@property (nonatomic,retain,readonly) NSString *WEBServerHost;//网页服务器地址
@property (nonatomic,retain) NSString *WEBEnv;//web环境


@property (nonatomic,assign) NSInteger routeType;
@property (nonatomic,assign) NSInteger state;
@property (nonatomic,strong) NSString *Opcode;
@property (nonatomic,strong) NSString *league;


@property (nonatomic,retain) NSString *appleId;
@property (nonatomic,retain) NSString *channel;
@property (nonatomic,retain) NSString *jgAppKey;
@property (nonatomic,retain) NSString *umengAppKey;
@property (nonatomic,retain) NSString *iTunesAddress;

+ (instancetype)sharedConfig;

@end

NS_ASSUME_NONNULL_END
