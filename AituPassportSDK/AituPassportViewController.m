//
//  AituPassportViewController.m
//  PassportRTCCordovaPlugin
//
//  Created by BTSD on 10/20/20.
//

#import "AituPassportViewController.h"
#import "AituNavigationDelegateProxy.h"

@interface AituPassportViewController ()

@property (nonatomic) AituNavigationDelegateProxy *delegateProxy;

@end

@implementation AituPassportViewController {
    WKWebView *_wkWebView;
    NSTimer *timer;
}

- (WKWebView *)wkWebView {
    return _wkWebView;
}

- (id)initWithUrl:(NSString * _Nonnull)url redirectUrl:(NSString *_Nonnull)redirectUrl {
    self.startPage = url;
    self.redirectURL = redirectUrl;
    return [super initWithNibName:nil bundle:nil];
}

- (void)setDelegate:(id<AituPassportViewControllerDelegate>)delegate {
    _delegate = delegate;
    self.delegateProxy.supplementary = delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _wkWebView = (WKWebView *)self.webView;
    
    __auto_type originalDelegate = _wkWebView.navigationDelegate;
    self.delegateProxy = [[AituNavigationDelegateProxy alloc] initWithOriginal:originalDelegate];
    self.delegateProxy.supplementary = self.delegate;
    _wkWebView.navigationDelegate = self.delegateProxy;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(tiktak)
                                           userInfo:nil
                                            repeats:YES];
    
    [self evaluateSetIsSDK];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [timer fire];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timer invalidate];
}

- (void)tiktak {
    NSString *urlString = _wkWebView.URL.absoluteString;
    if ([urlString containsString:self.redirectURL] && ![urlString containsString:@"redirect_uri"]) {
        [timer invalidate];
        [self.delegate passportViewController:self didTriggerRedirectUrl:urlString];
    }
}

- (void)evaluateSetIsSDK {
    NSString *script = @"window.isAituPassportSDK = true;";
    [_wkWebView evaluateJavaScript:script
                completionHandler:^(id _Nullable identifier, NSError * _Nullable error) {
    }];
}

- (void)dealloc {
    [timer invalidate];
}

@end
