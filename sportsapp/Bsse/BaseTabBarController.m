//
//  BaseTabBarController.m
//  testDemo
//
//  Created by MCM on 2019/3/30.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()
@property (nonatomic,strong) MCTabBarInfoModel *model;

@end

@implementation BaseTabBarController


+ (instancetype)sharedInstance{
    static BaseTabBarController *tabBarVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarVC = [[[self class] alloc] init];
    });
    return tabBarVC;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [UITabBar appearance].translucent = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self initCustomTabbars];
}
- (void)initCustomTabbars{

    [self addTabBar];

}
// 添加分控制器
- (void)addTabBar{
    
    NSMutableArray *viewControllersArray = [NSMutableArray array];

//    for(NSInteger i = 0;i < self.model.Result.TabInfo.count;i++){
//        Tabinfo *info = self.model.Result.TabInfo[i];
//        BaseViewController *controller = [[BaseViewController alloc] init];
//        controller.tabBarItem = [self makeTabBarItem:info.TabIcon selImg:info.TabIconConfirm title:info.TabName withTag:i];
//        controller.url = info.TabUrl;
//        controller.switchState = NO;
//        [viewControllersArray addObject:controller];
//        if(self.model.Result.TabInfo.count-1 == i){
//            self.viewControllers = viewControllersArray;
//        }
//    }
    
    NSArray *controllerArray = @[[MCHomeViewController class],[MCScoreViewController class],[SecondCtrl class]];
    NSArray *titleArray = @[@"首页",@"比分",@"战报"];
    NSArray *tabImgArray = @[@"index_n",@"score_n",@"top_n"];
    NSArray *selImgArray = @[@"index_y",@"score_y",@"top_y"];
    for(NSInteger i = 0;i < [controllerArray count];i++){
        BaseViewController *controller = [[controllerArray[i] alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
        controller.tabBarItem = [self makeTabBarItem:tabImgArray[i] selImg:selImgArray[i] title:titleArray[i] withTag:i];
        [viewControllersArray addObject:nav];
        if([controllerArray count]-1 == i){
            self.viewControllers = viewControllersArray;
        }
    }
}
- (UITabBarItem *)makeTabBarItem:(NSString *)tabImgName selImg:(NSString *)selImgName title:(NSString *)title withTag:(NSInteger)tag{
    
    UIImage *image1_0 = [kIMAGE(tabImgName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image1_1 = [kIMAGE(selImgName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image1_0 selectedImage:image1_1];
    tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorGMine, 1.0)} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorRead, 1.0)} forState:UIControlStateSelected];
    return tabBarItem;
}
//- (UITabBarItem *)makeTabBarItem:(NSString *)tabImgName selImg:(NSString *)selImgName title:(NSString *)title withTag:(NSInteger)tag{
//
//    NSString *onepath = [self getImageFileWithUrlPath:tabImgName];
//    NSString *twopath = [self getImageFileWithUrlPath:selImgName];
//
//    UIImage *image1_0 = [[UIImage imageWithContentsOfFile:onepath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage *image1_1 = [[UIImage imageWithContentsOfFile:twopath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image1_0 selectedImage:image1_1];
//    tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorGMine, 1.0)} forState:UIControlStateNormal];
//    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorRead, 1.0)} forState:UIControlStateSelected];
//    return tabBarItem;
//}
- (NSString *)getImageFileWithUrlPath:(NSString *)tabImgName{
    
    NSArray*oneArr = [tabImgName componentsSeparatedByString:@"/"];
    NSString*imageName1 = oneArr.lastObject;
    NSArray *onearr = [imageName1 componentsSeparatedByString:@"."];
    NSString *oneimageName;
    oneimageName =[NSString stringWithFormat:@"%@@2x.png",onearr[0]];
    NSString *oneFullPath = [NSPathNSCache stringByAppendingPathComponent:oneimageName];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:oneFullPath]){
        return oneFullPath;
    }else{
        NSData *onedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:tabImgName]];
        UIImage *oneimage = [UIImage imageWithData:onedata];
        NSString *onepath  = [NSPathNSCache stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png",onearr[0]]];
        
        if ([UIImagePNGRepresentation(oneimage) writeToFile:onepath atomically:YES]) {
            return onepath;
        }else{
            return onepath;
        }
    }
}

//设置选中哪一个控制器
- (void)selectedVCIndex:(NSUInteger)index{
    [self setSelectedIndex:index];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

- (UINavigationController *)getCurrentNav{
    return self.viewControllers[self.selectedIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
