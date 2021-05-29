// Copyright © 2018 650 Industries. All rights reserved.

#import <EXSplashScreen/EXSplashScreenController.h>
#import <UMCore/UMDefines.h>
#import <UMCore/UMUtilities.h>
#import "MBProgressHUD.h"
#import "EXSplashScreenHUDButton.h"

@interface EXSplashScreenController ()

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) UIView *splashScreenView;

@property (nonatomic, weak) NSTimer *warningTimer;
@property (nonatomic, weak) MBProgressHUD *warningHud;

@property (nonatomic, assign) BOOL autoHideEnabled;
@property (nonatomic, assign) BOOL splashScreenShown;
@property (nonatomic, assign) BOOL appContentAppeared;

@end

@implementation EXSplashScreenController

- (instancetype)initWithViewController:(UIViewController *)viewController
              splashScreenViewProvider:(id<EXSplashScreenViewProvider>)splashScreenViewProvider
{
  if (self = [super init]) {
    _viewController = viewController;
    _autoHideEnabled = YES;
    _splashScreenShown = NO;
    _appContentAppeared = NO;
    _splashScreenView = [splashScreenViewProvider createSplashScreenView];
  }
  return self;
}

# pragma mark public methods

- (void)showWithCallback:(void (^)(void))successCallback failureCallback:(void (^)(NSString * _Nonnull))failureCallback
{
  [self showWithCallback:successCallback];
}

- (void)showWithCallback:(nullable void(^)(void))successCallback
{
  [UMUtilities performSynchronouslyOnMainThread:^{
    UIView *rootView = self.viewController.view;
    self.splashScreenView.frame = rootView.bounds;
    [rootView addSubview:self.splashScreenView];
    self.splashScreenShown = YES;
    self.warningTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                         target:self
                                                       selector:@selector(showSplashScreenVisibleWarning)
                                                       userInfo:nil
                                                        repeats:NO];
    if (successCallback) {
      successCallback();
    }
  }];
}

-(void)showSplashScreenVisibleWarning
{
#if DEBUG
  _warningHud = [MBProgressHUD showHUDAddedTo: self.splashScreenView animated:YES];
  _warningHud.mode = MBProgressHUDModeCustomView;
  
  EXSplashScreenHUDButton *button = [EXSplashScreenHUDButton buttonWithType: UIButtonTypeSystem];
  
  [button addTarget:self action:@selector(hideWarningView) forControlEvents:UIControlEventTouchUpInside];

  _warningHud.customView = button;
  _warningHud.offset = CGPointMake(0.f, MBProgressMaxOffset);
  
  [_warningHud hideAnimated:YES afterDelay:8.f];
#endif
}

-(void)hideWarningView {
  NSURL *fyiURL = [[NSURL alloc] initWithString:@"https://github.com/expo/fyi/blob/master/splash-screen-hanging"];

  [[UIApplication sharedApplication] openURL:fyiURL];
  [_warningHud hideAnimated: YES];
}

- (void)preventAutoHideWithCallback:(void (^)(BOOL))successCallback failureCallback:(void (^)(NSString * _Nonnull))failureCallback
{
  if (!_autoHideEnabled) {
    return successCallback(NO);
  }

  _autoHideEnabled = NO;
  successCallback(YES);
}

- (void)hideWithCallback:(void (^)(BOOL))successCallback failureCallback:(void (^)(NSString * _Nonnull))failureCallback
{
  if (!_splashScreenShown) {
    return successCallback(NO);
  }
  
  [self hideWithCallback:successCallback];
}

- (void)hideWithCallback:(nullable void(^)(BOOL))successCallback
{
  UM_WEAKIFY(self);
  dispatch_async(dispatch_get_main_queue(), ^{
    UM_ENSURE_STRONGIFY(self);
    [self.splashScreenView removeFromSuperview];
    self.splashScreenShown = NO;
    self.autoHideEnabled = YES;
    [self.warningTimer invalidate];
    if (successCallback) {
      successCallback(YES);
    }
  });
}

- (void)onAppContentDidAppear
{
  if (!_appContentAppeared && _autoHideEnabled) {
    _appContentAppeared = YES;
    [self hideWithCallback:nil];
  }
}

- (void)onAppContentWillReload
{
  if (!_appContentAppeared) {
    _autoHideEnabled = YES;
    _appContentAppeared = NO;
    [self showWithCallback:nil];
  }
}

@end
