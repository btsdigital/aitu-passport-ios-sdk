//
//  AituPassportNavigationController.m
//  AituPassportSDK
//
//  Created by BTSD on 28.12.2020.
//

#import "AituPassportNavigationController.h"
#import "AituPassportViewController.h"

@interface AituPassportNavigationController ()

@end

@implementation AituPassportNavigationController

- (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated:(BOOL)flag
                   completion:(void (^)(void))completion {
    
    AituPassportViewController *passportViewController;
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:[AituPassportViewController class]]) {
            passportViewController = (AituPassportViewController *)vc;
            break;
        }
    }
    
    if (passportViewController != nil) {
        [passportViewController setUIDocumentMenuViewControllerSoureViewsIfNeeded:viewControllerToPresent];
    }
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
