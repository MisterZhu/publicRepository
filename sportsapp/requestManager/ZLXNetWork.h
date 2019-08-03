//
//  ZLXNetWork.h
//  FTImage
//
//  Created by LiXiaoZhu on 2017/11/27.
//  Copyright © 2017年 LiXiaoZhu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetWorkRequestSuccessBlock) (id result);
typedef void (^NetWorkRequestFailedBlock) (id error);

@interface ZLXNetWork : NSObject

@property (nonatomic,copy)NSString *a1;

//创建一个单例
+(instancetype)shareNetWork;

#pragma mark ---------  get请求方式  ---------
- (void)GetRequest:(NSString *)urlString
        postParams:(NSDictionary *)params
requestSuccessBlock:(NetWorkRequestSuccessBlock)successBlock
requestFailedBlock:(NetWorkRequestFailedBlock)failedBlock;

#pragma mark ---------  post请求方式  ---------
- (void)PosttRequest:(NSString *)urlString
        postParams:(NSDictionary *)params
requestSuccessBlock:(NetWorkRequestSuccessBlock)successBlock
requestFailedBlock:(NetWorkRequestFailedBlock)failedBlock;

@end
