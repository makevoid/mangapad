class SitemapController < ApplicationController
  def index
    @mangas = Manga.all
    
    # set last modified header to the date of the latest entry.

    respond_to do |format| 
      format.html
      format.xml {
        headers["Last-Modified"] = @mangas.first(:order => :last_update.desc).last_update.httpdate
        headers["Content-Type"] = "application/xml; charset=utf-8"           
        render layout: false
      }
    end
  end
end