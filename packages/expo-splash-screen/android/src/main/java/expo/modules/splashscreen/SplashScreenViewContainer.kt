package expo.modules.splashscreen

import android.view.View

enum class SplashScreenViewContext {
    BARE, MANAGED, HOME
}

class SplashScreenViewContainer {
    lateinit var view: View;
    lateinit var context: SplashScreenViewContext
}