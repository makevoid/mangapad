class Chapter
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, length: 100
  property :name_url, String, length: 100, index: true
  property :first_page, String
  property :image_id, String

  property :position, Integer, required: true
  belongs_to :manga

  has n, :pages
  
  def next
    manga.chapters[manga.chapters.index(self)+1]
  end
  
  def previous
    manga.chapters[manga.chapters.index(self)-1]
  end
  
  def first_page_url
    "#{manga.manga_url}#{name_url}/#{pages.first.name}/"
  end
end
