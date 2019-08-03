//
//  LXNewDetailVC.m
//  testDemo
//
//  Created by WEI ZOU on 2019/4/23.
//  Copyright © 2019 xiguadianjing. All rights reserved.
//

#import "LXNewDetailVC.h"
#import <WebKit/WebKit.h>

@interface LXNewDetailVC ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic) WKWebView *webView;

@end

@implementation LXNewDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleStr = self.title;
    self.webView = [[WKWebView alloc] initWithFrame:aFrame(0, Height_NavBar, KScreenWidth, KScreenHeight-Height_NavBar)];
    
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.url]]];
    
    NSString *css = @".dc-home-information-box {\n\
    height: 100%;\n\
    position: relative;\n\
    }\n\
    .dc-home-information-box .dc-home-information-content {\n\
    height: 100%;\n\
    overflow: auto;\n\
    padding: 10px;\n\
    }\n\
    .dc-home-information-box .dc-home-information-content .dc-home-information-title {\n\
    font-family:PingFangSC-Semibold;\n\
    font-size: 16px;\n\
    color: #333;\n\
    text-align: center;\n\
    letter-spacing: 0.00796296rem;\n\
    font-weight: normal;\n\
    }\n\
    .dc-home-information-box .dc-home-information-content .dc-home-information-source {\n\
    margin: 5px 0 5px 0;\n\
    padding-left: 10px;\n\
    }\n\
    .dc-home-information-box .dc-home-information-content .dc-home-information-source span:nth-child(1) {\n\
    font-family: SourceHanSansCN-Regular;\n\
    font-size: 12px;\n\
    color: #999;\n\
    line-height: 20px;\n\
    font-weight: normal;\n\
    font-stretch: normal;\n\
    }\n\
    .dc-home-information-box .dc-home-information-content .dc-home-information-source span:nth-child(2) {\n\
    margin: 0 5px;\n\
    line-height: 20px;\n\
    font-size: 12px;\n\
    color: #dfdfdf;\n\
    }\n\
    .dc-home-information-box .dc-home-information-content .dc-home-information-source span:nth-child(3) {\n\
    font-family: Roboto-Regular;\n\
    font-size: 12px;\n\
    color: #898c95;\n\
    line-height: 20px;\n\
    }\n\
    .dc-home-information-box .dc-home-information-content .dc-home-information-news {\n\
    width: 100%;\n\
    font-family: SourceHanSansCN-Regular;\n\
    font-size: 14px;\n\
    color: #3b414d;\n\
    letter-spacing: 0;\n\
    line-height: 24px;\n\
    }\n\
    .dc-home-information-box .dc-home-information-content .dc-home-information-news img {\n\
    display: block;\n\
    width: 100% !important;\n\
    margin: 10px 0;\n\
    }";

    NSString *title = [NSString stringWithFormat:@"<div class=\"dc-home-information-title\">%@</div>", _model.title];
    NSString *author = [NSString stringWithFormat:@"<div class=\"dc-home-information-source\"><span>%@</span><span></span><span>%@</span></div>", _model.author, _model.date];
    NSString *content = [NSString stringWithFormat:@"<div class=\"dc-home-information-news\">%@</div>", _model.content];
    NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html><head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style type = \"text/css\">%@</style></head><html><body><div id=\"app\"><div class=\"app-box\"><div class=\"route-box\"><div class=\"dc-home-information-box\"><div class=\"dc-home-information-content\">%@%@%@</div></div></div></div></div></body></html>", css, title, author, content];
    [self.webView loadHTMLString:html baseURL:nil];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    //开了支持滑动返回
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
}

// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    self.title = NSLocalizedString(webView.title, nil);
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    self.title = webView.title;
    
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
    
    
    if (navigationAction.navigationType==WKNavigationTypeBackForward) {//判断是返回类型
        
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮 这里可以监听左滑返回事件，仿微信添加关闭按钮。
        // self.navigationItem.leftBarButtonItems = @[self.backBtn, self.closeBtn];
        //可以在这里找到指定的历史页面做跳转
        //        if (webView.backForwardList.backList.count>0) {                                  //得到栈里面的list
        //            DLog(@"%@",webView.backForwardList.backList);
        //            DLog(@"%@",webView.backForwardList.currentItem);
        //            WKBackForwardListItem * item = webView.backForwardList.currentItem;          //得到现在加载的list
        //            for (WKBackForwardListItem * backItem in webView.backForwardList.backList) { //循环遍历，得到你想退出到
        //                //添加判断条件
        //                [webView goToBackForwardListItem:[webView.backForwardList.backList firstObject]];
        //            }
        //        }
    }
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}
@end
