class MainController < UIViewController 

  def viewDidLoad
    super

    self.edgesForExtendedLayout = UIRectEdgeNone

    rmq.stylesheet = MainStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    rmq.append(UILabel, :search_label)
    @query = rmq.append(UITextField, :query).focus.get

    rmq.append(UIButton, :submit_button).on(:touch) do |sender|
      puts "submit button tapped"
    end
  end

  def init_nav
    self.title = 'Image Browser'
  end

end
