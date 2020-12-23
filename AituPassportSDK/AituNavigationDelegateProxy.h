#import <Foundation/Foundation.h>
#import <WebKit/WKNavigationDelegate.h>

@protocol AituPassportNavigationDelegate;

@interface AituNavigationDelegateProxy : NSObject <WKNavigationDelegate>

@property (nonatomic, weak) id<AituPassportNavigationDelegate> supplementary;

- (instancetype)initWithOriginal:(id<WKNavigationDelegate>)original;

@end

