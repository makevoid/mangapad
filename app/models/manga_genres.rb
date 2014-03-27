class MangaGenre
  include DataMapper::Resource
  
  property :id, Serial
  
  belongs_to :manga
  belongs_to :genre
end