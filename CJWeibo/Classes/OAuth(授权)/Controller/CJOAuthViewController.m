//
//  CJOAuthViewController.m
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJOAuthViewController.h"
#import "CJAccount.h"
#import "CJAccountTool.h"



@interface CJOAuthViewController () <UIWebViewDelegate>

@end


@implementation CJOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 1.添加 webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面(新浪提供的登录页面)
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3024216879&redirect_uri=https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}






#pragma mark - webView 代理方法


/**
 *  webView 开始发送请求的时候调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"CJ正在帮你加载中..."];
}

/**
 *  webView 请求加载完毕的时候调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  webView 请求失败的时候调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}






/**
 *  当 webView 发送任何一个请求之前都会调用,询问代理能否加载该请求
 *  @return  YES:可以加载    NO:不可以加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    // 1.请求的 URL 路径
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    
    
    
    // 3.如果urlStr中包含了code=
//    if (range.location != NSNotFound)
    if (range.length)
    {
        // 4.截取code=后面的请求标记(经过用户授权成功的)
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        CJLog(@"url---%@\ncode---%@",urlStr,code);
        

        // 5.用 AFN框架 发送POST请求给新浪,通过code换取一个AccessToken
        [self accessTokenWithCode:code];

    }
    
    return YES;
    
}










/**
 client_id	    true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	    true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
                必选	   类型及范围	说明
 code	        true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 
 
 
 
 *  利用 code 通过网络请求换取 accessToken
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 说明从服务器返回的 JSON 数据
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3024216879";
    params[@"client_secret"] = @"3227b9117b769892bca3b7b32dc1eb36";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"https://www.baidu.com";
    
    
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          // accessToken : 2.00HmNsFEbxSfSD4d5e784473CJBi2C
          

          // 4.将收到的字典数据转为模型
          CJAccount *account = [CJAccount accountWithDict:responseObject];
          
          // 5.存储模型数据
          [CJAccountTool saveAccount:account];
          
          // 6.新特性 / 首页
          [CJWeiboTool chooseRootController];
          
          
          // 7.隐藏提醒框
          [MBProgressHUD hideHUD];
          
          
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        CJLog(@"请求失败！！%@",error);
        // 隐藏提醒框
        [MBProgressHUD hideHUD];
    }];
}












@end
