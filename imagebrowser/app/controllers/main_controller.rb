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
      search_for_images @query.text
    end
  end

  def init_nav
    self.title = 'Image Browser'
  end

  def search_for_images(query)
    if query and !query.empty?
      query = query.gsub(/\s/, '%20')
      url = "https://secure.flickr.com/search/?q=#{query}&s=int"

      rmq.animations.start_spinner

      AFMotion::HTTP.get(url) do |result|
        if html = result.body
          images = html.scan(/src=\"(.+?\.jpg)\"/i).map do |m|
            m.first
          end

          open_images_controller(images) if !images.empty?
          rmq.animations.stop_spinner
        end
      end
    end
  end

  def open_images_controller(images)
    controller = ImagesController.new
    self.navigationController.pushViewController(controller, animated:true)
  end

end
