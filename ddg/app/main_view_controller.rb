class MainViewController < UIViewController

  def loadView
    @main_layout = MainLayout.new
    self.view = @main_layout.view
    self.title = "Search DuckDuckGo"

    @search_text_field = @main_layout.get(:search_text_field)
    @search_button = @main_layout.get(:search_button)
  end

  def viewDidLoad
    super
    @search_button.on(:touch) do
      search(@search_text_field.text)
    end
  end

  def search(search_term)
    AFMotion::HTTP.get("http://api.duckduckgo.com/?q=#{search_term}&format=json") do |result|
      results_hash = BW::JSON.parse(result.object.to_str)
      p results_hash["results"]
    end
  end

end
