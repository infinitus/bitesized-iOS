class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    main_view_controller = MainViewController.alloc.init
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(main_view_controller)
    @window.makeKeyAndVisible
    true
  end
end
