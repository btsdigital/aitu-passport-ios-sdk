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
    NSTimer *timer;
    NSString *hostUrl;
}

- (WKWebView *)wkWebView {
    return (WKWebView *)self.webView;
}

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.startPage = @"";
        self.redirectURL = @"";
    }
    return self;
}

- (instancetype)initWithUrl:(NSString * _Nonnull)url redirectUrl:(NSString *_Nonnull)redirectUrl {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.startPage = url;
        self.redirectURL = redirectUrl;
    }
    return self;
}

- (void)setDelegate:(id<AituPassportViewControllerDelegate>)delegate {
    _delegate = delegate;
    self.delegateProxy.supplementary = delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id originalDelegate = self.wkWebView.navigationDelegate;
    self.delegateProxy = [[AituNavigationDelegateProxy alloc] initWithOriginal:originalDelegate];
    self.delegateProxy.supplementary = self.delegate;
    self.wkWebView.navigationDelegate = self.delegateProxy;
    hostUrl = self.wkWebView.URL.host;
    
    [self evaluateSetIsSDK];
    [self setBackButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(tiktak)
                                           userInfo:nil
                                            repeats:YES];
    [timer fire];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [timer invalidate];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [self setUIDocumentMenuViewControllerSoureViewsIfNeeded:viewControllerToPresent];
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)setUIDocumentMenuViewControllerSoureViewsIfNeeded:(UIViewController *)viewControllerToPresent {
    if (@available(iOS 13, *)) {
        if ([viewControllerToPresent isKindOfClass:[UIDocumentMenuViewController class]]
            && UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            viewControllerToPresent.popoverPresentationController.sourceView = self.wkWebView;
            viewControllerToPresent.popoverPresentationController.sourceRect = CGRectMake(self.wkWebView.center.x, self.wkWebView.center.y, 1, 1);
        }
    }
}

- (void)tiktak {
    if (self.webView.backgroundColor == UIColor.clearColor) {
        self.webView.backgroundColor = UIColor.whiteColor;
    }
    [self setBackButtonColor];
    NSString *urlString = self.wkWebView.URL.absoluteString;
    if ([urlString containsString:self.redirectURL] && ![urlString containsString:@"redirect_uri"]) {
        [timer invalidate];
        [self.delegate passportViewController:self didTriggerRedirectUrl:urlString];
    }
}

- (void)setBackButton {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"←" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:backButton animated:YES];
    [self setBackButtonColor];
}

- (void)setBackButtonColor {
    if (self.wkWebView.canGoBack == true && ![self.wkWebView.URL.host isEqualToString:hostUrl]) {
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.systemBlueColor} forState:UIControlStateNormal];
    } else {
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.clearColor} forState:UIControlStateNormal];
    }
}

- (void)goBack {
    if (self.wkWebView.canGoBack == true) {
        [self setBackButtonColor];
        [self.wkWebView goBack];
    }
}

- (void)evaluateSetIsSDK {
    NSString *script = @"window.isAituPassportSDK = true;";
    [self.wkWebView evaluateJavaScript:script completionHandler:nil];
}

- (void)dealloc {
    [timer invalidate];
}

@end
