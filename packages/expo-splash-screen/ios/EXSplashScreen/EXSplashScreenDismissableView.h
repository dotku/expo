// Copyright © 2018 650 Industries. All rights reserved.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface EXSplashScreenDismissableView : UIView

-(void)showVisibilityWarningWithCallback:(void (^)(void))callback;

@end
