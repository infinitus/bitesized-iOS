class MainStylesheet < ApplicationStylesheet

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.gray
  end

  def search_label(st)
    st.frame = {l: 10, t: 60, w: app_width - 20, h: 40} 
    st.text = "Find"
    st.color = color.white
    st.font = font.large
  end

  def query(st)
    st.frame = {l: 10, t: 110, w: app_width - 20, h: 40} 
    st.background_color = color.white
    st.view.font = font.large 
  end

  def submit_button(st)
    st.frame = {l: 10, t: 160, w: app_width - 20, h: 40} 
    st.background_color = color.blue
    st.text = "Go"
    st.font = font.large
    st.color = color.white
  end
end
