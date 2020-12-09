//
//  AituPassportViewController.h
//  PassportRTCCordovaPlugin
//
//  Created by BTSD on 10/20/20.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVViewController.h>
#import <WebKit/WebKit.h>
#import "AituPassportNavigationDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class AituPassportViewController;

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

NS_ASSUME_NONNULL_END
