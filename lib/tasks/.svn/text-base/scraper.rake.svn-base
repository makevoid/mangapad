namespace :scrape do
  desc "index pages per letter"
  task :lindex => :environment do
    Scraper.index_lpages
  end
  
  desc "scrape chapters"
  task :chapters => :environment do
    Scraper.om.scrape_chapters
  end
  
  desc "scrape images"
  task :images => :environment do
    Scraper.om.scrape_images
  end
end