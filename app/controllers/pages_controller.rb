class PagesController < ApplicationController

  def next
    build_request "next"
  end
  
  def prev
    build_request "prev"
  end
  
  private
  
  def build_request(direction)
    page = Page.get(params[:id])
    @page = page.send(direction)
    puts "PAGE: #{@page.inspect}"
    respond_to do |format|
      format.js {
        unless @page.nil?
          render json: { page: { page_id: @page.id, image_url: root_url + @page.image_url, prev_id: page.id, name: @page.good_name } }
        else
          render json: { page: nil, error: { message: "page not found" } }
        end
      }
    end
  end
  
end