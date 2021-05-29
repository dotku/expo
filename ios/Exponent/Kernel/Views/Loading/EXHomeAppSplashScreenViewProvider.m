#import <UIKit/UIKit.h>
#import "EXHomeAppSplashScreenViewProvider.h"
#import <EXSplashScreen/EXSplashScreenViewContainer.h>

@implementation EXHomeAppSplashScreenViewProvider

- (EXSplashScreenViewContainer *)createSplashScreenView
{
  EXSplashScreenViewContainer *viewContainer = [super createSplashScreenView];
  viewContainer.context = EXSplashScreenHome;
  
  UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)[viewContainer.view viewWithTag:1];
  [activityIndicatorView startAnimating];
  
  return viewContainer;
}

@end
