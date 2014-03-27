module ViewHelpers
  
  include NavHelper
  
  def manga_link(name)
    haml_tag :li do
      haml_tag :a, href: name.gsub(/\s/, "_") do
        haml_concat name
      end
    end
  end
  
  # basic texts
  
  def site_title
    "MangaPad - "
  end
  
  def site_slogan
    "Read manga on the iPad and on android tablets"
  end
  
  def footer_text
    raw "<p>The manga scansubs images are taken from public submissions manga databases and their &copy; copyrights are of their respective owners.</p><p>If you own the copyright of some images send us a message and we will take care of verifying that you own the images and we will remove them istantly.</p>"
  end
  
  # SEO (and RDF)
  
  def analytics_tracker
    "UA-10682634-5"
  end
  
  def meta_keywords
    "mangapad, ipad, manga, mangas, reader, viewer, online, html5, webkit, webapp, manga scans"
  end
  
  def meta_description
    "MangaPad is the ultimate Manga Reader for the iPad. Read your favourite manga scans with the iPad directly from Safari --- This is an attempt in bringing a great manga reading experience to the people who own a tablet device like an iPad (Android support will come soon). We think the tablet-sized & touch-enabled devices are a great way to rediscover the pleasure to read, especially mangas. Please, consider the work done by mangakas and buy the real mangas in the original format as they come to your country."
  end
  
  def meta_author
    "Francesco 'makevoid' Canessa"
  end
  
end