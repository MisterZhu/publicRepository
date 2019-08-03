//
//  AppDelegate.m
//  sportsapp
//
//  Created by MCM on 2019/4/25.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
@property (nonatomic,strong) MCUpdateInfoModel *infoModel;
@property (nonatomic,strong) MCTabBarInfoModel *tabBarModel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [BaseTabBarController sharedInstance];
    
    /** 启动校验 */
    [self appLaunchCheck];
    
    return YES;
}
#pragma mark - 启动条件校验
- (void)appLaunchCheck{
    WS(weakSelf);
    NSDictionary *dict = @{@"SerNo":@"com.365football.ios25419",
                           @"Version":@"4",
                           @"Channel":@"debug",
                           };
    [[ZLXNetWork shareNetWork] GetRequest:@"http://47.75.2.224:7081/V1/GetEntryUrl"
                               postParams:dict
                      requestSuccessBlock:^(id result) {
                          weakSelf.tabBarModel = [MCTabBarInfoModel modelWithJSON:result];
                          
                          dispatch_async(dispatch_get_main_queue(), ^{
                              // 通知主线程刷新 神马的
                              [self setRequestIP];
                              
                          });
                          
                      } requestFailedBlock:^(id error) {
                          
                      }];
    
    
    
    
}
- (void)setRequestIP{
    //SerNo=com.bifen91.zuqiu.sports&Version=4&Channel=debug
    
    NSDictionary *dict = @{@"SerNo":@"com.365football.ios25419",
                           @"Version":@"4",
                           @"Channel":@"debug",
                           };
    NSString *strin = [NSString stringWithFormat:@"%@V2/GetUpdateInfo",self.tabBarModel.Result.PlatFormIP];
    [[ZLXNetWork shareNetWork] GetRequest:strin
                               postParams:dict
                      requestSuccessBlock:^(id result) {
                          self.infoModel = [MCUpdateInfoModel modelWithJSON:result];
                          dispatch_async(dispatch_get_main_queue(), ^{
                              // 通知主线程刷新 神马的
                              [self isUpdataApp];
                          });
                          
                          
                      } requestFailedBlock:^(id error) {
                          
                      }];
}
#pragma mark - 检测版本更新
- (void)isUpdataApp{
    
    if (self.infoModel.Result.appHardVersion == 0) {
        self.window.rootViewController = [BaseTabBarController sharedInstance];
    }else if (self.infoModel.Result.appHardVersion == 1) {
        BaseViewController *vc = [[BaseViewController alloc] init];
        vc.url = self.infoModel.Result.AppDataCenter;
        vc.switchState = self.infoModel.Result.appHardVersion;
        self.window.rootViewController = vc;
    }
    //    BaseViewController *vc = [[BaseViewController alloc] init];
    //    vc.url = self.model.Result.MainURL;
    //    vc.switchState = YES;
    //    self.window.rootViewController = vc;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //该方法中我们经常用来取消在程序进入后台的时候执行的操作。
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //重启之前暂停或者之前根本没有运行的任务。如果程序之前在后台，必要的时候需要做界面的刷新操作。
    [self appLaunchCheck];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
