# encoding: utf-8 

class Scraper
  
  def self.index_lpages
    Manga.all.each do |manga|
      lindex = if Manga.lpages.include? manga.name[0]
        Manga.lpages.index manga.name[0]
      else
        0
      end
      manga.update letter_idx: lindex
    end
  end
  
  def self.om
    new(Site.first(:name => "onemanga"))
  end
  
  def initialize(site)
    require 'mechanize'
    @agent = Mechanize.new
    
    @site = site
  end
  
  def scrape    
    scrape_mangas
    scrape_chapters
  end
  
  require 'net/http'
  
  def scrape_undone
    Dir.glob("/Volumes/backup/mangas/*/**").map do |f|
      num = File.basename(f).gsub(/\/.jpg/, '')
    end
  end
  
  def scrape_images
    path = "/Volumes/backup/mangas/"
    stopped_at = 295000
    stopped_at = 29711
    stopped_at = 1
    # 2300 - 24785 # Addicted to curry - timeout
    # 27319 - 29711 # Ai kora
    
    
    i = stopped_at
    #Manga.all.map{ |manga|     `mkdir -p #{path}/#{manga.name_url}` }
    
    timer = Time.now
    @threads = []
    options = {}
    options = { chapter: eval(File.read("#{Rails.root}/lib/om_chapters.rb")) }
    #options = { chapters: Site.first.mangas.map{|m| m.chapters.map{|c| c.id} }.flatten }
    batch_find(Page, stopped_at, 2000000, options) do |page|
    #Page.all(offset: stopped_at, limit: 2000000).map do |page|
      threaded_scrape_page(page, path, i, timer, stopped_at) 
      i = i+1
    end    
  end
  
  def batch_find(klass, offset, limit, options={}, &block)
    batch = 5000
    times = limit - offset    
    #puts "offset: #{offset}, limit: #{limit}, times:#{(times.to_f/batch).ceil} "
    (times.to_f/batch).ceil.times.map do |i|
      
      puts "deh"
      #puts "batch #{i}"
      off = batch*i+offset
      lim = off+batch
      #puts ">> offset: #{off}, lim: #{lim}"
      klass.all(options.merge(offset: off, limit: batch)).map do |obj|
        block.call obj
      end
    end
  end
  
  
  #  bundle exec rake scrape:images --trace
  
  def threaded_scrape_page(page, path, i, timer, stopped_at)
    if @threads.size > 10#Thread.list.size > 4
      
      
      #Thread.list[1..-1].map{ |t| t.join }
      #puts Thread.list.inspect
      Thread.list.map{ |t| t.exit if t.status == false }  
      @threads.each{ |t| t.join }
      @threads = []
      sleep(0.1)
    else
      Thread.abort_on_exception = true
      @threads << Thread.new {
        puts "speed: #{(i-stopped_at)/(Time.now-timer)}, p.id: #{page.id}" if i%100==0
        begin
          unless File.exist? page_path(page, path) 
            scrape_page(page, path) 
            puts "recovered i:#{i},  p.id:#{page.id}" if i < 295000 # FIXME: remove
          end
        rescue Timeout::Error
          puts "ERROR: Timeout for i: #{i}"
          puts "#{page.chapter.manga.name} #{page.chapter.name}"
          puts "http://#{page.raw_url}"
        else
          #puts "i: #{i}, page_id: #{page.id}"
        end
     }
    end
  end
  
  def scrape_page(page, path)
    uri = URI.parse "http://"+page.raw_url
    #puts "http://"+page.raw_url
    
    http = Net::HTTP::new(uri.host, uri.port)
    http.open_timeout = 4
    http.read_timeout = 4

    response = http.start do |http|
      req = Net::HTTP::Get.new(uri.path, {"User-Agent" =>
          "Mozilla/5.0 (Windows; U; Windows NT 6.1; ja-JP) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16"})
      http.request(req)
    end

    if response.code.to_s == "200"
      File.open(page_path(page, path), "w:ASCII-8BIT") do |file|
        file.write(response.body)
        #puts "page.id: #{page.id}"
      end
    end
  end
  
  def page_path(page, path)
    "#{path}/#{page.chapter.manga.name_url}/#{page.id}.jpg"
  end
  
  # onemanga, 1000manga

  def scrape_chapters
    #repository(:default).adapter.execute 'TRUNCATE TABLE chapters'
    #repository(:default).adapter.execute 'TRUNCATE TABLE pages'
    mangas = Manga.all
    #mangas = [Manga.first(name: "vagabond")]
    mangas.map do |manga|
      #chap_first = manga.latest_chapter == 0 ? 0 : 1
      next if manga.scraped
      manga.chapters.map(&:pages).flatten.map(&:destroy)
      manga.chapters.map(&:destroy)
      manga = Manga.get manga.id
      p manga.manga_url
      page = @agent.get manga.manga_url
      
      page.search("table.ch-table td.ch-subject a").reverse.each_with_index do |a, index|
        name = a.inner_text.gsub("#{manga.name}", '')
        name_url = a["href"].split("/")[-1],gsub(/'/, "").gsub(/&/, 'and')
        chap = manga.chapters.new(name: name.strip, name_url: name_url, position: index)
        chap.save
        p chap.errors.map{|e| e} unless chap.errors.map{|e| e} == []
      end
            
      ## 
      p manga.first_chapter_url
      first_chapter_page = @agent.get manga.first_chapter_url
      
      # handle unavailability
      if first_chapter_page.body =~ /Read this series at 1000manga\.com/
        manga.update(site: Site.first(name: "1000manga"))
        manga.save
        p manga.first_chapter_url
        first_chapter_page = @agent.get manga.first_chapter_url
      end
      if first_chapter_page.body =~ /This series is no longer available/
        manga.status = "no_longer_available"; manga.scraped = true; manga.save 
        next
      end
      
      first_page_url = first_chapter_page.links.find{ |l| l.text =~ /Begin reading/i }.href
      
      #chapter = manga.chapters.first
      
      scrape_first_page(manga.chapters.first, first_page_url)

      manga.update(scraped: true)
      #p page
    end
  end
  
  private
  
  def scrape_first_page(chapter, first_page_url)
    first_page_name = first_page_url.split("/")[-1]
    first_page_url = chapter.manga.first_chapter_url + first_page_name
    #mpage = chapter.pages.new(name: first_page_name)
    #mpage.save

    first_page = Mechanize.new{|m| m.history.max_size=0}.get first_page_url
    #first_page = @agent.get first_page_url
    ##
    first_page.search("select.page-select option").map do |opt|
      pg = chapter.pages.new(name: opt["value"])
      pg.save

    end
    img = first_page.search("img.manga-page").first
    split = img["src"].split("/")
    chapter.update(image_id: split[5]) 
    ##
    manga = chapter.manga
    manga.update(image_id: split[4])
    

    chapters_js = Mechanize.new{|m| m.history.max_size=0}.get manga.js_url
    chapters_js.body.match(/Array\((.+?)\);/m)[1].split(/\],\s*\[/).map do |smatch|
      matchz = smatch.match(/,\s*"(.+)\/(.+)"/)
      #p smatch
      chap = manga.chapters.first(name_url: matchz[1])
      chap.pages.create(name: matchz[2])
    end
    
    chapters = manga.chapters - [manga.chapters.first]
    chapters.map do |chapter|
      scrape_pages(chapter)
    end
  end
  
  def scrape_pages(chapter)
    page = Mechanize.new{|m| m.history.max_size=0}.get chapter.first_page_url
    ##
    page.search("select.page-select option")[1..-1].map do |opt|
      chapter.pages.create(name: opt["value"])
    end
    img = page.search("img.manga-page").first
    split = img["src"].split("/")
    chapter.update(image_id: split[5]) 
    ##
  end
  
  def scrape_mangas
    page_dir = @agent.get "http://#{@site.url}/#{@site.directory}"
    # tmpdir = File.expand_path "~/tmp"
    # File.open("#{tmpdir}/mangapad.html", "w:ascii-8bit"){ |f| f.write page_dir.body.encode("ascii-8bit") }
    # `open #{tmpdir}/mangapad.html`
    page_dir.search("table.ch-table tr")[2..-1].map do |tr|
      a = tr.search "td.ch-subject a"
      
      next if a.nil? || a.size == 0
      manga = @site.mangas.new
      
      manga.name = a.inner_text.strip
      manga.name_url = a.first["href"].gsub(/^\/|\/$/, '')
      status = tr.search("td")[2].inner_text
      if Manga::STATUSES.map(&:capitalize).include? status
        manga.status = status.downcase
      else
        manga.status = "active"
        manga.last_update = Date.parse(status)
      end
      manga.latest_chapter = tr.search("td.ch-chapter").inner_text.gsub(/Chapter/, '').strip.to_i
      manga.rank_om = tr.search("td.ch-subject span").inner_text.gsub(/\(|\)/, '').strip.to_i
      manga.save
      puts manga.errors.map{|e| e}
    end
  end
end