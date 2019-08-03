//
//  BaseViewController.h
//  testDemo
//
//  Created by MCM on 2019/3/30.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : ViewController

@property (nonatomic,strong) NSString *url;
@property (nonatomic) BOOL switchState;
@property (nonatomic) WKWebView *webView;
@property (nonatomic,retain) NSString *titleStr;//标题

@property (nonatomic,strong) UIView *naTitleView;

/** tableView初始化 */
@property (nonatomic, weak)UITableView *tableView;

/** 返回 */
- (void)popViewController;

/** 数据请求 */
- (void)requestData;

//初始化tableview视图
- (void)setupUI;
- (void)createTableViewStyleGrouped;
//设置title可点击
- (void)makeTitle:(NSString *)title withImg:(NSString *)img;
// 隐藏导航栏
- (void)setNavigationBarHidden:(BOOL)hidden;
- (void)setNavigationBarAlpha:(CGFloat)alpha;//设置透明度
- (void)setNavigationBarLight;//设置高亮
// 设置导航栏左侧按钮
- (void)hideLeftNavigationBar;//隐藏左侧按钮
- (void)setLeftNavigationBarWithTitle:(NSString *)title image:(NSString *)image action:(SEL)action;
- (void)showLeftNavigationBar;
// 设置导航栏右侧按钮
- (void)setRightNavigationBarHidden:(BOOL)hidden;
- (void)setRightNavigationBarWithTitle:(NSString *)title image:(NSString *)image;
- (void)setRightNavigationBarWithTitle:(NSString *)title image:(NSString *)image action:(SEL)action;

- (void)setNavigationBarTitleView:(UIView *)titleView;

@end

NS_ASSUME_NONNULL_END
