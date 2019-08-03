//
//  BaseNavigationController.m
//  WatermelonEsports
//
//  Created by MCM on 2018/12/20.
//  Copyright © 2018年 xiguadianjing. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animate{
    if([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if([navigationController.viewControllers count] == 1) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }else{
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

- (void)dealloc{
    self.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
