#import <WebKit/WKNavigationDelegate.h>
#import "AituNavigationDelegateProxy.h"
#import "AituPassportNavigationDelegate.h"

@interface AituNavigationDelegateProxy ()

@property (nonatomic) id<WKNavigationDelegate> original;

@end

@implementation AituNavigationDelegateProxy

- (instancetype)initWithOriginal:(id<WKNavigationDelegate>)original {
    self = [super init];
    if (self) {
        self.original = original;
    }
    return self;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    __block __auto_type decision = WKNavigationActionPolicyCancel;
    __auto_type handler = ^(WKNavigationActionPolicy policy) {
        decision = decision || policy;
    };
    if ([self.original respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [self.original webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:handler];
    }
    [self.supplementary webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:handler];
    decisionHandler(decision);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    __block __auto_type decision = WKNavigationResponsePolicyCancel;
    __auto_type handler = ^(WKNavigationResponsePolicy policy) {
        decision = decision || policy;
    };
    if ([self.original respondsToSelector:@selector(webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
        [self.original webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:handler];
    }
    [self.supplementary webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:handler];
    decisionHandler(decision);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if ([self.original respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [self.original webView:webView didStartProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    if ([self.original respondsToSelector:@selector(webView:didReceiveServerRedirectForProvisionalNavigation:)]) {
        [self.original webView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if ([self.original respondsToSelector:@selector(webView:didFailProvisionalNavigation:withError:)]) {
        [self.original webView:webView didFailProvisionalNavigation:navigation withError:error];
    }
    [self.supplementary webView:webView didFailProvisionalNavigation:navigation withError:error];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if ([self.original respondsToSelector:@selector(webView:didCommitNavigation:)]) {
        [self.original webView:webView didCommitNavigation:navigation];
    }
    [self.supplementary webView:webView didCommitNavigation:navigation];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if ([self.original respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [self.original webView:webView didFinishNavigation:navigation];
    }
    [self.supplementary webView:webView didFinishNavigation:navigation];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if ([self.original respondsToSelector:@selector(webView:didFailNavigation:withError:)]) {
        [self.original webView:webView didFailNavigation:navigation withError:error];
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    if ([self.original respondsToSelector:@selector(webViewWebContentProcessDidTerminate:)]) {
        [self.original webViewWebContentProcessDidTerminate:webView];
    }
}

- (void)webView:(WKWebView *)webView authenticationChallenge:(NSURLAuthenticationChallenge *)challenge shouldAllowDeprecatedTLS:(void (^)(BOOL))decisionHandler API_AVAILABLE(ios(14.0)) {
    if ([self.original respondsToSelector:@selector(webView:authenticationChallenge:shouldAllowDeprecatedTLS:)]) {
        [self.original webView:webView authenticationChallenge:challenge shouldAllowDeprecatedTLS:decisionHandler];
    }
}

@end
