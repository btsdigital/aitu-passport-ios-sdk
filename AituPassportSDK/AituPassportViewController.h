//
//  AituPassportViewController.h
//  PassportRTCCordovaPlugin
//
//  Created by BTSD on 10/20/20.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVViewController.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AituPassportViewController;
@protocol AituPassportNavigationDelegate;


@protocol AituPassportViewControllerDelegate<NSObject, AituPassportNavigationDelegate>
@optional
- (void)passportViewController:(AituPassportViewController *)viewController didTriggerRedirectUrl:(NSString *)redirectUrl;
@end


@interface AituPassportViewController : CDVViewController

@property (nonatomic, weak) id <AituPassportViewControllerDelegate> delegate;
@property (nonatomic, readonly) WKWebView *wkWebView;

@property(nonatomic, copy) NSString *redirectURL;

- (instancetype)init;
- (instancetype)initWithUrl:(NSString * _Nonnull)url redirectUrl:(NSString *_Nonnull)redirectUrl;

@end


@protocol AituPassportNavigationDelegate <NSObject>

@optional
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;

@end

NS_ASSUME_NONNULL_END
