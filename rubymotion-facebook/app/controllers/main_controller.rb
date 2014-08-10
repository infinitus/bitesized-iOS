class MainController < UIViewController 

  def viewDidLoad
    super

    rmq.stylesheet = MainStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    @hello_world_label = rmq.append(UILabel, :hello_world).get

    @fb_login_button = rmq.append(FBLoginView.new, :fb_login_button).get
    @fb_login_button.delegate = self
  end

  def init_nav
    self.title = 'Title Here'

    self.navigationItem.tap do |nav|
      nav.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAction,
                                                                           target: self, action: :nav_left_button)
      nav.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh,
                                                                           target: self, action: :nav_right_button)
    end
  end

  def nav_left_button
    puts 'Left button'
  end

  def nav_right_button
    puts 'Right button'
  end

  def loginViewShowingLoggedInUser(_)
    set_title 'User logged in'
  end

  def loginViewShowingLoggedOutUser(_)
    set_title 'User logged out' 
    if @name_label
      rmq(@name_label).animations.fade_out
      @name_label.removeFromSuperview
      rmq(@fb_login_button).animate { |button| button.move(b: 300) }
    end
  end

  def set_title(text)
    self.title = text
  end

  def loginViewFetchedUserInfo(_, user:user)
    rmq(@fb_login_button).animate { |button| button.move(b: 400) } 
    @name_label = rmq.append(UILabel, :name_label).get
    @name_label.text = "#{user['first_name']} #{user['last_name']}"
    rmq(@name_label).animations.fade_in
  end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end

end


__END__

# You don't have to reapply styles to all UIViews, if you want to optimize, 
# another way to do it is tag the views you need to restyle in your stylesheet, 
# then only reapply the tagged views, like so:
def logo(st)
  st.frame = {t: 10, w: 200, h: 96}
  st.centered = :horizontal
  st.image = image.resource('logo')
  st.tag(:reapply_style)
end

# Then in willAnimateRotationToInterfaceOrientation
rmq(:reapply_style).reapply_styles


