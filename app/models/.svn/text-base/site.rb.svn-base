
class Site
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :url, String
  property :format, String, length: 255
  property :directory, String
  property :js_url_stub, String
    
  has n, :mangas
end
