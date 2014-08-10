class MainController < UIViewController 

  def viewDidLoad
    super

    self.edgesForExtendedLayout = UIRectEdgeNone

    rmq.stylesheet = MainStylesheet
    init_nav
    rmq(self.view).apply_style :root_view
  end

  def init_nav
    self.title = 'Image Browser'
  end

end
