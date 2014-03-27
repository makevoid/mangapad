require 'spec_helper'

# how?
#
# module DataMapper::Resource     
#   def self.included(base)
#     base.extend ClassMethods
#   end   
#   
#   module ClassMethods
#     def destroy_all
#       self.all.map{ |r| r.destroy }
#     end      
#   end           
# end

def destroy_all(model)
  model.send(:all).map{ |r| r.destroy }
  # truncate?
end

describe "Chapters" do
  describe "GET /chapters" do
    it "should show the title" do
      sites = %w{www.onemanga.com www.1000manga.com manga.animea.net}
      
      #Site.destroy_all 
      destroy_all Site
      destroy_all Manga
      destroy_all Chapter
      destroy_all Page
      
      # format: name chapter page
      onemanga  = Site.create(name: "onemanga", url: "www.onemanga.com", format: '"img-a.onemanga.com/mangas/#{manga.image_id}/#{chapter.image_id}/#{name}.jpg"', directory: "directory/", js_url_stub: "http://content.s-onemanga.com/manga-%d.js")
      
      
      eyeshield_21 = onemanga.mangas.create name: "Eyeshield 21", name_url: "eyeshield_21"
      chap = eyeshield_21.chapters.create name: "1", position: 1
      chap.pages.create name: "1"
      
      visit "/mangas/#{eyeshield_21.id}/chapters/#{chap.id}"
      page.body.should =~ /Eyeshield 21 - chapter: 1 - page: 1/
    end
    
    it "should get the image" do
      visit "/img/img-a.onemanga.com/mangas/00000001/000052552/01.jpg"
      page.status_code.should == 200
    end
  end
end
