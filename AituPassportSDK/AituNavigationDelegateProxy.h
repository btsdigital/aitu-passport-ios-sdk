#import <Foundation/Foundation.h>

@protocol AituPassportNavigationDelegate;
@protocol WKNavigationDelegate;

@interface AituNavigationDelegateProxy : NSObject <WKNavigationDelegate>

@property (nonatomic, weak) id<AituPassportNavigationDelegate> supplementary;

- (instancetype)initWithOriginal:(id<WKNavigationDelegate>)original;

@end

