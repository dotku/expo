//
//  EXSplashScreenViewContainer.m
//  EXSplashScreen
//
//  Created by andrew on 2021-05-29.
//

#import "EXSplashScreenViewContainer.h"

@implementation EXSplashScreenViewContainer

- (instancetype)initWithView:(UIView *)view andContext:(EXSplashScreenViewContext)context
{
  self = [super init];
  
  if (self) {
    _view = view;
    _context = context;
  }

  return self;
}

@end
