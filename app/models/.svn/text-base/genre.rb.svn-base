class Genre
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  
  has n, :manga_genres
  has n, :mangas, through: :manga_genres
end
