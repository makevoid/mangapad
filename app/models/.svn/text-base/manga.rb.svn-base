class Manga
  include DataMapper::Resource

  require "#{Rails.root}/lib/paginable"
  include Paginable
  
  STATUSES = ["active", "suspended", "completed", "no_longer_available"]
  
  property :id, Serial
  property :name, String, length: 150
  property :name_url, String, length: 150, index: true
  #property :first_chapter, Integer
  property :latest_chapter, Integer
  property :status_id, Integer, index: true
  property :letter_idx, Integer, index: true
  property :last_update, DateTime
  property :rank_om, Integer
  property :image_id, String
  property :scraped, Boolean
  property :published, Boolean, default: true, index: true
  
  belongs_to :site
  has n, :chapters
  
  has n, :manga_genres
  has n, :genres, through: :manga_genres
  
  #default_scope(:default).update(published: true)
  
  def self.lpages
    (["0"]+("A".."Z").to_a)
  end
  
  def js_url
    site.js_url_stub % number
  end
  
  def number
    image_id.gsub(/^[0]+/, '').to_i
  end
  
  def manga_url
    "http://#{site.url}/#{name_url}/"
  end
  
  def first_chapter_url
    "#{manga_url}#{chapters.first.name_url}/"
  end

  # status
  
  def status
    STATUSES[status_id]
  end
  
  def status=(status_name)
    status_id = STATUSES.index(status_name)
  end
end
