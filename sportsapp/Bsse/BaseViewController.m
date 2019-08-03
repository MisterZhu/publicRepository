//
//  BaseViewController.m
//  testDemo
//
//  Created by MCM on 2019/3/30.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationBar.h"
#import "BaseStyleNoneTableView.h"

@interface BaseViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,retain) BaseNavigationBar *navigationBar;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self makeNavigationBar];
    self.navigationController.navigationBar.translucent = YES;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)setupUI{

    //子类继承一定要记得super！不然tableView没了！！
    [self createTableViewWithStyle:UITableViewStylePlain];
    
}
//UITableViewStyleGrouped 类型tableView
- (void)createTableViewStyleGrouped{
    
    [self createTableViewWithStyle:UITableViewStyleGrouped];
}
- (void)createTableViewWithStyle:(UITableViewStyle)style{
    BaseStyleNoneTableView *tableview = [[BaseStyleNoneTableView alloc]initWithFrame:aFrame(0, Height_NavBar, KScreenWidth, KScreenHeight - Height_NavBar) style:style];
    
    tableview.rowHeight = UITableViewAutomaticDimension;
    tableview.estimatedRowHeight = 0;
    tableview.estimatedSectionFooterHeight = 0;
    tableview.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:tableview];
    _tableView = tableview;
}
- (void)setTitleStr:(NSString *)titleStr{
    self.navigationBar.titleL.text = titleStr;
    self.navigationBar.titleBtn.hidden = YES;
    self.navigationBar.titleView.hidden = YES;
    self.navigationBar.titleL.hidden = NO;
}
- (void)setNaTitleView:(UIView *)naTitleView{
    self.navigationBar.titleBtn.hidden = YES;
    self.navigationBar.titleView.hidden = NO;
    self.navigationBar.titleView = naTitleView;
}

- (void)makeTitle:(NSString *)title withImg:(NSString *)img{
    self.navigationBar.titleL.hidden = YES;
    self.navigationBar.titleBtn.hidden = NO;
    
    [self.navigationBar.titleBtn setTitle:title forState:UIControlStateNormal];
    [self.navigationBar.titleBtn setImage:kIMAGE(img) forState:UIControlStateSelected];
    [self.navigationBar.titleBtn setImage:kIMAGE(img) forState:UIControlStateNormal];
    self.navigationBar.titleBtn.layoutStyle = JXLayoutButtonStyleLeftTitleRightImage;
    [self.navigationBar.titleBtn addTarget:self action:@selector(clickTitleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)clickTitleBtnAction:(UIButton *)sender{
    NSLog(@"super nslog");
}
#pragma mark -makeNavigationBar
- (void)makeNavigationBar{
    _navigationBar = [[BaseNavigationBar alloc] init];
    [self.view addSubview:self.navigationBar];
    
    [self.navigationBar.lBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNavigationBarHidden:(BOOL)hidden{
    self.navigationBar.hidden = hidden;
    if(!hidden){
        [self.view bringSubviewToFront:self.navigationBar];
    }
}

- (void)setNavigationBarAlpha:(CGFloat)alpha{
    self.navigationBar.alpha = alpha;
}

- (void)setNavigationBarLight{
    self.navigationBar.hidden = YES;
}

- (void)hideLeftNavigationBar{
    self.navigationBar.lBtn.hidden = YES;
}
- (void)showLeftNavigationBar{
    self.navigationBar.lBtn.hidden = NO;
}
- (void)setLeftNavigationBarWithTitle:(NSString *)title image:(NSString *)image action:(SEL)action{
    if(title.length>0){
        [self.navigationBar.lBtn setTitle:title forState:UIControlStateNormal];
        if(action){
            [self.navigationBar.lBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }else if(image.length>0){
        if ([image hasPrefix:@"http"]){
//            [self.navigationBar.lBtn sd_setImageWithURL:[NSURL URLWithString:image] forState:UIControlStateNormal];
        }else{
            [self.navigationBar.lBtn setImage:kIMAGE(image) forState:UIControlStateNormal];
        }
        if(action){
            [self.navigationBar.lBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        [self.navigationBar.lBtn setHidden:YES];
    }
}

- (void)setRightNavigationBarHidden:(BOOL)hidden{
    self.navigationBar.rBtn.hidden = hidden;
}

- (void)setRightNavigationBarWithTitle:(NSString *)title image:(NSString *)image{
    [self setRightNavigationBarWithTitle:title image:image action:nil];
}

- (void)setRightNavigationBarWithTitle:(NSString *)title image:(NSString *)image action:(SEL)action{
    if(title.length>0){
        self.navigationBar.rBtn.width = [title sizeForFont:[UIFont systemFontOfSize:14]
                                                      size:CGSizeMake(200, 20)
                                                      mode:NSLineBreakByWordWrapping].width+20;
        self.navigationBar.rBtn.right = KScreenWidth;
        self.navigationBar.rBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [self.navigationBar.rBtn setTitle:title forState:UIControlStateNormal];
        if(action){
            [self.navigationBar.rBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }else if(image.length>0){
        if ([image hasPrefix:@"http"]){
//            [self.navigationBar.rBtn sd_setImageWithURL:[NSURL URLWithString:image] forState:UIControlStateNormal];
        }else{
            [self.navigationBar.rBtn setImage:kIMAGE(image) forState:UIControlStateNormal];
        }
        if(action){
            [self.navigationBar.rBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)setNavigationBarTitleView:(UIView *)titleView{
    [self.navigationBar addSubview:titleView];
    titleView.centerX = KScreenWidth/2;
    titleView.bottom = self.navigationBar.height-10;
}
- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setSwitchState:(BOOL)switchState{
    _switchState = switchState;
    if (_switchState) {
        //马甲包状态
        self.webView = [[WKWebView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, KScreenHeight)];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
        //开了支持滑动返回
        self.webView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:self.webView];
        
        CGFloat top = 0;
        if (@available(iOS 11.0, *)) {
            top = UIApplication.sharedApplication.keyWindow.safeAreaInsets.top;
        } else {
            // Fallback on earlier versions
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height >= 812.0f) {
                top = 44.0f;
            }
        }
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setImage:[UIImage imageNamed:@"backGray"] forState:UIControlStateNormal];
        back.frame = CGRectMake(0, top+1, 33.0, 44.0);
        back.tintColor = [UIColor grayColor];
        [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [_webView addSubview:back];
        
    }else{
//        //原生状态
//        self.webView = [[WKWebView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, KScreenHeight-Height_TabBar)];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
//        self.webView.navigationDelegate = self;
//        self.webView.UIDelegate = self;
//        //开了支持滑动返回
//        self.webView.allowsBackForwardNavigationGestures = YES;
//        [self.view addSubview:self.webView];
    }
    
}
-(void)back:(id)sender{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}
//WkUIDelegate:
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog(@"createWebViewWithConfiguration");
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation");

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    //self.title = webView.title;
    NSLog(@"didFinishNavigation");

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didFailProvisionalNavigation");

}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");

}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    DLog(@"%@",webView);
    DLog(@"%@",navigationResponse);
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    NSLog(@"decidePolicyForNavigationResponse");

}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    //self.title = webView.title;
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    
    
    if (navigationAction.navigationType==WKNavigationTypeBackForward) {//判断是返回类型
        
    }
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    NSLog(@"decidePolicyForNavigationAction");

    // 获取完整url并进行UTF-8转码
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];

    NSLog(@"--- strRequest = %@",strRequest);
////http://gw.jkefy.com/Gateway/Pay/
//    
//    if ([strRequest hasPrefix:@"app://"]) {
//        // 拦截点击链接
////        [self handleCustomAction:strRequest];
//        // 不允许跳转
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }else {
//        // 允许跳转
//        decisionHandler(WKNavigationActionPolicyAllow);
//
//    }
    
}
//- (void)handleCustomAction:(NSString *)URL
//{
//    // 判断跳转
//    NSString *link_id = @"";
//    NSLog(@"--- URL = %@",URL);
//
//    if ([URL hasPrefix:@"app://video"]) {
//        // 视频
//        NSLog(@"点击了视频%@",link_id);
//    }else if ([URL hasPrefix:@"app://item"]) {
//        // 单品
//        NSLog(@"点击了单品%@",link_id);
//    }else if ([URL hasPrefix:@"app://brand"]) {
//        // 品牌
//        link_id = [URL substringFromIndex:[NSString stringWithFormat:@"app://brand"].length];
//        NSLog(@"点击了品牌%@",link_id);
//    }
//}
@end
