//
//  ZLXNetWork.m
//  FTImage
//
//  Created by LiXiaoZhu on 2017/11/27.
//  Copyright © 2017年 LiXiaoZhu. All rights reserved.
//


#import "ZLXNetWork.h"
#import<objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"

@implementation ZLXNetWork

//创建一个单例
+(instancetype)shareNetWork{
    id instance = objc_getAssociatedObject(self, @"instance");
    if (!instance) {
        instance = [[super allocWithZone:NULL]init];
        NSLog(@"单利创建===%@===",instance);
        objc_setAssociatedObject(self, @"instance", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return instance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [ZLXNetWork shareNetWork] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [ZLXNetWork shareNetWork] ;
}

#pragma mark - get请求

- (void)GetRequest:(NSString *)urlString
        postParams:(NSDictionary *)params
requestSuccessBlock:(NetWorkRequestSuccessBlock)successBlock
requestFailedBlock:(NetWorkRequestFailedBlock)failedBlock{
    
    NSString *UrlStr = [self URLRequestStringWithURL:params withUrl:urlString];
    NSURL *url = [NSURL URLWithString:UrlStr];

    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //请求方式
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    [request setHTTPMethod:@"GET"];

    [request setAllHTTPHeaderFields:[self headerParametersConfigWithUrl:urlString]];
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];

   //4.根据会话对象创建一个Task(发送请求）
    /*
            21      第一个参数：请求对象
            22      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
            23                data：响应体信息（期望的数据）
            24                response：响应头信息，主要是对服务器端的描述
            25                error：错误信息，如果请求失败，则error有值
            26      */
    
     NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

         if (error == nil) {
             
             //NSLog(@"---%@",request.allHTTPHeaderFields);

             //6.解析服务器返回的数据
             //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             
             dict = [NSDictionary changeType:dict];
             NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

             NSLog(@"-----result =%@\n%@",UrlStr,dict);

             successBlock(dict);


         }else{
             failedBlock(error);
             NSLog(@"-----result =%@\n%@",UrlStr,@"error");

         }
     }];
     [dataTask resume];
}
#pragma mark ---------  post请求方式  ---------
- (void)PosttRequest:(NSString *)urlString
          postParams:(NSDictionary *)params
 requestSuccessBlock:(NetWorkRequestSuccessBlock)successBlock
  requestFailedBlock:(NetWorkRequestFailedBlock)failedBlock{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json",@"text/json", @"text/javascript", @"text/html", @"text/plain",nil];

    NSLog(@"---url = %@%@",urlString,params);
    [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *result = (NSDictionary *)responseObject;
            NSLog(@"result = %@",result);
            successBlock(result);

        }else{
            NSError *error;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"resultdic = %@",result);
            NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"resultjsonStr = %@",jsonStr);
            successBlock(result);

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error.code == -1009) {
            failedBlock(error);
        } else if(error.code == -1001) {
            //网络超时
            failedBlock(error);
        } else {
            NSLog(@"Error: %@", error);
            failedBlock(error);
        }

    }];
}
-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark ---------  dict拼接成URL形的字符串  ---------
- (NSString *)URLRequestStringWithURL:(NSDictionary *)Dict withUrl:(NSString *)urlStr{
    
    NSMutableString *URL = [NSMutableString stringWithFormat:@"%@",urlStr];
    //获取字典的所有keys
    NSArray * keys = [Dict allKeys];
    //拼接字符串
    for (int j = 0; j < keys.count; j ++){
        NSString *string;
                
        if ([keys[j] isEqualToString:@"telephone"]) {
            NSString *urlStr = [self URLEncodedStringWith:Dict[keys[j]]];
            if (j == 0){
                //拼接时加？
                string = [NSString stringWithFormat:@"?%@=%@", keys[j], urlStr];
            }else{
                //拼接时加&
                string = [NSString stringWithFormat:@"&%@=%@", keys[j], urlStr];
            }
        }else{
            if (j == 0){
                //拼接时加？
                string = [NSString stringWithFormat:@"?%@=%@", keys[j], Dict[keys[j]]];
            }else{
                //拼接时加&
                string = [NSString stringWithFormat:@"&%@=%@", keys[j], Dict[keys[j]]];
            }
        }
        //拼接字符串
        [URL appendString:string];
    }
    return URL;
}
- (NSString *)jsonUrlRequestStringWithURL:(NSDictionary *)params withUrl:(NSString *)urlStr{
    
    NSMutableString *URL = [NSMutableString stringWithFormat:@"%@%@?searchflight=",kBaseUrl,urlStr];
    NSString *paramNoEncoding = @"";
    NSString *backStr = @"";
    NSMutableString *paramString = [NSMutableString string];
    NSArray *allKeys = [params allKeys];

    for (int i = 0; i < params.count; i++)
    {
        NSString *key = [allKeys objectAtIndex:i];
        id value = [params objectForKey:key];
        if([value isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *valueDic = (NSDictionary *)value;
            if (valueDic.count == 0)
            {
                [paramString appendFormat:@"\"%@\":\{}", key];
            }
            else
            {
                NSMutableString *valueParamString = [NSMutableString string];
                NSArray *valueAllKeys = [valueDic allKeys];
                for (int i = 0; i < valueDic.count; i++)
                {
                    NSString *valuekey = [valueAllKeys objectAtIndex:i];
                    id valueSub = [valueDic objectForKey:valuekey];
                    if ([valueSub isKindOfClass:[NSString class]])
                    {
                        [valueParamString appendFormat:@"\"%@\":\"%@\"", valuekey, valueSub];
                    }
                    else if ([valueSub isKindOfClass:[NSArray class]])
                    {
                        NSArray *valueDic = (NSArray *)valueSub;
                        [valueParamString appendFormat:@"\"%@\":[",valuekey];
                        for (int j = 0; j < valueDic.count; j++)
                        {
                            NSString *valueStr = [valueDic objectAtIndex:j];
                            [valueParamString appendFormat:@"\"%@\"", valueStr];
                            if (j < valueDic.count - 1)
                            {
                                [valueParamString appendString:@","];
                            }
                        }
                        [valueParamString appendString:@"]"];
                    }
                    if (i < valueDic.count - 1)
                    {
                        [valueParamString appendString:@","];
                    }
                }
                if (valueParamString.length > 0)
                {
                    [paramString appendFormat:@"\"%@\":\{%@}", key, valueParamString];
                }
            }
        }
        else
        {
            [paramString appendFormat:@"\"%@\":\"%@\"", key, value];
            if (i < params.count - 1)
            {
                [paramString appendString:@","];
            }
        }
    }
    //拼接URL
    if (paramString.length > 0)
    {
        //不加密
        paramNoEncoding = [NSString stringWithFormat:@"{%@}",paramString];
        paramNoEncoding = [self URLEncodedStringWith:paramNoEncoding];
        
    }
    NSLog(@" paramNoEncoding = %@",paramNoEncoding);
    backStr = [NSString stringWithFormat:@"%@%@",URL,paramNoEncoding];
    return backStr;
}
- (NSString *)URLEncodedStringWith:(NSString *)str
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)str,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}
/** 请求头*/
#pragma mark ---------  /** 请求头*/  ---------
- (NSDictionary *)headerParametersConfigWithUrl:(NSString *)Url{
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];

    [parametersDic setObject:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];

    NSLog(@" parametersDic = %@",parametersDic);
    return parametersDic;
}

@end
