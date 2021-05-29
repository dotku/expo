//
//  EXSplashScreenViewContainer.h
//  EXSplashScreen
//
//  Created by andrew on 2021-05-29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EXSplashScreenViewContext) {
  EXSplashScreenManaged = 0,
  EXSplashScreenBare = 1,
  EXSplashScreenHome = 2,
};

@interface EXSplashScreenViewContainer : NSObject

@property (nonatomic, strong)UIView *view;
@property (nonatomic, assign)EXSplashScreenViewContext context;

-(instancetype)initWithView:(UIView *)view andContext:(EXSplashScreenViewContext) context;

@end

NS_ASSUME_NONNULL_END
