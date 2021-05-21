// Copyright © 2018 650 Industries. All rights reserved.

#import "EXSplashScreenDismissableView.h"

typedef void(^HideSplashScreenBlock)(void);

@interface EXSplashScreenDismissableView()

@property (nonatomic, copy) HideSplashScreenBlock hideSplashScreen;

@end

@implementation EXSplashScreenDismissableView

-(void)showVisibilityWarningWithCallback:(void (^)(void))callback
{
  self.hideSplashScreen = callback;
  
  UIView *warningView = [UIView new];
  CGRect warningViewFrame = CGRectMake(0, self.bounds.size.height - 400, self.bounds.size.width, 200);
  warningView.frame = warningViewFrame;

  UILabel *warningLabel = [[UILabel alloc] init];
  warningLabel.frame =  CGRectMake(warningViewFrame.origin.x, warningViewFrame.origin.y, warningViewFrame.size.width - 32.0f, 100);
  warningLabel.center = CGPointMake(warningViewFrame.size.width / 2, warningViewFrame.size.height / 2 - 50);

  warningLabel.text = @"Looks like the splash screen has been visible for over 20 seconds - did you forget to call hideAsync?";
  warningLabel.numberOfLines = 0;
  warningLabel.font = [UIFont systemFontOfSize:16.0f];
  warningLabel.textColor = [UIColor darkGrayColor];
  warningLabel.textAlignment = NSTextAlignmentCenter;
  [warningView addSubview: warningLabel];

  UIButton *buttonHide = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  buttonHide.frame = CGRectMake(0, 0, 150.0f, 36.0f);
  buttonHide.center = CGPointMake(CGRectGetMidX(warningViewFrame), CGRectGetMaxY(warningLabel.frame) + 48.0f);
  [buttonHide setTitle:@"Hide SplashScreen" forState:UIControlStateNormal];
  buttonHide.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
  [buttonHide setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  buttonHide.layer.borderWidth = 1.0f;
  buttonHide.layer.borderColor = [UIColor darkGrayColor].CGColor;
  buttonHide.layer.cornerRadius = 3.0f;
  [buttonHide addTarget:self action:@selector(handleDismissButtonPress)  forControlEvents:UIControlEventTouchUpInside];
  [warningView addSubview:buttonHide];
  [self addSubview: warningView];
}

-(void)handleDismissButtonPress
{
  self.hideSplashScreen();
}

@end
