class MainLayout < MotionKit::Layout
  view :search_button
  view :search_text_field

  def layout
    add UIView, :container do
      frame [[0, 0], [320, 568]]
      background_color UIColor.whiteColor

      @search_text_field = add UITextField, :search_text_field do
        frame [[10, '40%'], [300, 50]]
        font UIFont.systemFontOfSize(40)
      end

      @search_text_field.layer.borderWidth = 0.5
      @search_text_field.layer.borderColor = UIColor.blackColor.CGColor
      @search_text_field.layer.cornerRadius = 3; 

      @search_button = add UIButton, :search_button do
        width 80  
        height 30 
        frame below(:search_text_field, down: 15)
        title_color UIColor.blackColor
      end

      @search_button.titleLabel.font = UIFont.systemFontOfSize(25)
    end
  end

  def search_button_style
    title "Search"
  end

  def search_text_field_style
    placeholder "search for.."
  end

end
