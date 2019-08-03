//
//  MCHostManager.m
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "MCHostManager.h"

@implementation MCHostManager

+ (instancetype)sharedConfig{
    static MCHostManager *hostConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hostConfig = [[[self class] alloc] init];
    });
    return hostConfig;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.state = 0;
        self.Opcode = @"";
        self.league = @"";
        self.APIServerHost = @"";
    }
    return self;
}
- (void)setWEBServerHost:(NSString *)webURL{
    if(webURL.length){
        _WEBServerHost = webURL;
    }
}

- (void)setAppleId:(NSString *)appleId{
    _appleId = appleId;
}
-(void)setState:(NSInteger)state{
    _state = state;
}
-(void)setOpcode:(NSString *)Opcode{
    _Opcode = Opcode;
}
-(void)setLeague:(NSString *)league{
    _league = league;
}
- (void)setAPIServerHost:(NSString *)APIServerHost{
    _APIServerHost = APIServerHost;
}
@end
