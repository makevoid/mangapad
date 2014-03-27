# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

sites = %w{www.onemanga.com www.1000manga.com manga.animea.net}

# format: name chapter page
onemanga  = Site.create(name: "onemanga", url: "www.onemanga.com", format: "%s/%d/%s/", directory: "directory/", js_url_stub: "http://content.s-onemanga.com/manga-%d.js")
onekmanga = Site.create(name: "1000manga", url: "www.1000manga.com", format: "%s/%d/%s/", directory: "directory/", js_url_stub: "http://www.1000manga.com/manga-%d.js")
animea    = Site.create(name: "animea", url: "manga.animea.net", format: "%s-chapter-%d-page-%d.html")

Scraper.new(onemanga).scrape