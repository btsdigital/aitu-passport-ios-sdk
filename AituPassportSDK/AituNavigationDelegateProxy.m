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
    [self.original webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    [self.supplementary webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction preferences:(WKWebpagePreferences *)preferences decisionHandler:(void (^)(WKNavigationActionPolicy, WKWebpagePreferences * _Nonnull))decisionHandler API_AVAILABLE(ios(13.0)) {
    [self.original webView:webView decidePolicyForNavigationAction:navigationAction preferences:preferences decisionHandler:decisionHandler];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    [self.original webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
    [self.supplementary webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.original webView:webView didStartProvisionalNavigation:navigation];
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    [self.original webView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.original webView:webView didFailProvisionalNavigation:navigation withError:error];
    [self.supplementary webView:webView didFailProvisionalNavigation:navigation withError:error];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self.original webView:webView didCommitNavigation:navigation];
    [self.supplementary webView:webView didCommitNavigation:navigation];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.original webView:webView didFinishNavigation:navigation];
    [self.supplementary webView:webView didFinishNavigation:navigation];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.original webView:webView didFailNavigation:navigation withError:error];
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    [self.original webView:webView didReceiveAuthenticationChallenge:challenge completionHandler:completionHandler];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [self.original webViewWebContentProcessDidTerminate:webView];
}

- (void)webView:(WKWebView *)webView authenticationChallenge:(NSURLAuthenticationChallenge *)challenge shouldAllowDeprecatedTLS:(void (^)(BOOL))decisionHandler API_AVAILABLE(ios(14.0)) {
    [self.original webView:webView authenticationChallenge:challenge shouldAllowDeprecatedTLS:decisionHandler];
}

@end
