module ChaptersHelper
  def no_prev_page
    params[:page].to_i < 1
  end
  
  def no_next_page
    params[:page].to_i+2 > @pages.count
  end
end