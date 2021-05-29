// Copyright © 2018 650 Industries. All rights reserved.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EXSplashScreenViewContainer.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EXSplashScreenViewProvider

- (EXSplashScreenViewContainer *)createSplashScreenView;

@end

NS_ASSUME_NONNULL_END
