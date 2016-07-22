//
//  ViewController.m
//  TEST
//
//  Created by hc_cyril on 16/4/22.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "StarRatingViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self testWebview];
    
//    [self testTimer];
    
//    [self tapGesture];
    
//    [self performSelector:@selector(testTimer) withObject:nil];

    
//    [self testIndicationView];
    
//    UIRefreshControl *view = [[UIRefreshControl alloc] init];
    
//    [self testUmengCrash];
//    
//    [self testJS];
//    
//    [self testNull];
    
    [self setUpSubviews];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods 

- (void)setUpSubviews {
    
//    [self.view addSubview:self.starRatingView];
//    [self.starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(0));
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.width.equalTo(self.view);
//        make.height.equalTo(@(100));
//    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.view.bounds;
    [btn addTarget:self action:@selector(nextViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    NSDictionary *dict = @{@"hello":@"0"};
    NSString *string = nil;
    NSLog(@"%@",dict[string]);
    
    // UIProgressView的使用 常用于歌曲的和下载的进度条
    UIProgressView *oneProgressView = [[UIProgressView alloc] init];
    oneProgressView.frame = CGRectMake(0, 300, 320, 30); // 设置UIProgressView的位置和大小
    oneProgressView.backgroundColor = [UIColor clearColor]; // 设置背景色
    oneProgressView.alpha = 1.0; // 设置透明度 范围在0.0-1.0之间 0.0为全透明
    
    oneProgressView.progressTintColor = [UIColor yellowColor]; // 设置已过进度部分的颜色
    oneProgressView.trackTintColor = [UIColor blackColor]; // 设置未过进度部分的颜色
    oneProgressView.progress = 0.2; // 设置初始值，范围在0.0-1.0之间，默认是0.0
    // [oneProgressView setProgress:0.8 animated:YES]; // 设置初始值，可以看到动画效果
    
    [oneProgressView setProgressViewStyle:UIProgressViewStyleDefault]; // 设置显示的样式
    
    
    // 添加到View上，并释放内存
    [self.view addSubview:oneProgressView];
}

- (void)nextViewController {

    [self.navigationController pushViewController:[StarRatingViewController new] animated:YES];
}

- (void)testNull {
    BOOL a = [NSNull isKindOfClass:[NSString class]];
}

- (void)testJS {

    self.jsContext = [[JSContext alloc] init];
    [self.jsContext evaluateScript:@"var num = 10"];
    NSLog(@"%@",[self.jsContext description]);
    [self.jsContext evaluateScript:@"var squareFunc = fuction(value) { return value * 2}"];
    
    JSValue *square = [self.jsContext evaluateScript:@"squareFunc(num)"];
    JSValue *squareFunc = self.jsContext[@"squareFunc"];
    JSValue *value = [squareFunc callWithArguments:@[@"20"]];
    NSLog(@"%@",square.toNumber);
    NSLog(@"%@",value.toNumber);

    self.jsContext[@"log"] = ^() {
        
        NSLog(@"++++++begin log +++++++");
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsval in args) {
            NSLog(@"%@",jsval);
        }
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"++++++end log +++++++");
        
        
    };
    [self.jsContext evaluateScript:@"log('ider',[7,21], { hello:'world', js:100});"];
    
    JSContext *callBackContext = [[JSContext alloc] init];
    [callBackContext evaluateScript:@"function add(a,b) { return a + b}"];
    JSValue *add = callBackContext[@"add"];
    NSLog(@"%@",add);
    JSValue *sum = [add callWithArguments:@[@(7), @(21)]];
    NSLog(@"sum: %d",[sum toInt32]);
    
    JSContext *exceptionContext = [[JSContext alloc] init];
    exceptionContext.exceptionHandler = ^(JSContext *con, JSValue *exception) {
    
        NSLog(@"%@",exception);
        con.exception = exception;
    };
    
    exceptionContext[@"log"] = ^() {
    
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"%@",obj);
        }
    };
    [exceptionContext evaluateScript:@"log('ider',[7,21], { hello:'world', js:100});"];
    [exceptionContext evaluateScript:@"ider.hello = 21"];
    
    
}

- (void)testUmengCrash {

    BOOL success = NO;
//    success = CGImageDestinationFinalize(nil);
}

- (void)testWebview {
    
    [self.view addSubview:self.webView];
}

- (void)testTimer {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRepeatMethod) userInfo:nil repeats:YES];
//    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRepeatMethod) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
}
- (void)tapGesture {

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invalidateTimer)];
    [self.view addGestureRecognizer:tap];
}

- (void)timerRepeatMethod {

    NSLog(@"timer repeat continue");
}

- (void)invalidateTimer {
    
    [UIView animateWithDuration:1 animations:^{
        self.navigationItem.prompt = nil;
        self.navigationItem.titleView = nil;
    }];

    NSLog(@"stop timer....");
    [self.timer invalidate];
    self.timer = nil;
    
}
- (void)testIndicationView {

    self.navigationItem.prompt = @"数据加载中...";
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.titleView = aiView;
    [aiView startAnimating];
}

- (void)testBundleName {

    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"\n%@",[dict description]);
    
    NSLog(@"\n%@",[NSString stringWithFormat:@"Builds %@",[dict objectForKey:@"CFBundleVersion"]]);
    
    NSLog(@"\n%@",[dict objectForKey:@"CFBundleDisplayName"]);
    
    NSLog(@"\n%@",[dict objectForKey:@"CFBundleIdentifier"]);
}

#pragma mark - webViewDelegate 

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSURL *url = [request URL];
    NSLog(@"scheme = %@, host = %@, query = %@",[url scheme],[url host], [url query]);
    if([[url scheme] isEqualToString:@"httpss"]) {
        //处理JavaScript和Objective-C交互
        if([[url host] isEqualToString:@"m.baidu.com"]) {
            //获取URL上面的参数
//            NSDictionary *params = [self getParams:[url query]];
            BOOL status = YES;
            if(status) {
                //调用JS回调
                [webView stringByEvaluatingJavaScriptFromString:@"alert('iOS中JS和OC交互!')"];
            } else {
                [webView stringByEvaluatingJavaScriptFromString:@"alert('hellooooooo!')"];
            }
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    


}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

#pragma mark - setters and getters

- (UIWebView *)webView {

    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
        _webView.delegate = self;
    }
    return _webView;
}


@end
