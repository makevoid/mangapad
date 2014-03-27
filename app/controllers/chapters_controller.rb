
class URI::HTTP
  def valid?
    self.to_s =~ /http:\/\/.+/
  end
end

class ChaptersController < ApplicationController
  def show
    @chapter = first_named Chapter
    return not_found if @chapter.nil?
    @manga = @chapter.manga
    @pages = @chapter.pages
    @chapters = @manga.chapters
    @page = params[:page].blank? ? @pages.first : @pages[params[:page].to_i]
    return not_found if @page.nil?
    render layout: "read"
  end
  
  def jq #show
    render layout: nil
  end

  
  def test
    #require 'open-uri'
    require 'net/http'

    uri = URI.parse("http://#{params[:id]}")
    return not_found if uri.nil? || !uri.valid?
    
    http = Net::HTTP::new(uri.host, uri.port)
    http.open_timeout = 4
    http.read_timeout = 4
    
    begin 
      response = http.start do |http|
        req = Net::HTTP::Get.new(uri.path, {"User-Agent" =>
            "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; en-us) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27"})
        http.request(req)          
      end
    rescue Timeout::Error
      send_data File.read("#{Rails.root}/public/images/fail_image.png"), :filename => 'image.jpg', :type => 'image/jpeg', :disposition => 'inline'
      return false
    end
    
    if response.code.to_s == "200"
      #puts res.inspect
      data_string = response.body
      send_data data_string, :filename => 'image.jpg', :type => 'image/jpeg', :disposition => 'inline'
    else
      send_data File.read("#{Rails.root}/public/images/fail_image.png"), :filename => 'image.jpg', :type => 'image/jpeg', :disposition => 'inline'
    end
    #data_string = open("http://img-a.onemanga.com/mangas/00000550/000027749/00-cover.jpg")
    
  end
end