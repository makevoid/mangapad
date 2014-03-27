class Page
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :lazy => true
  
  belongs_to :chapter
  
  def next
    pages = chapter.pages
    pages_ids = pages.map{ |p| p.id }
    next_idx = pages_ids.index(self.id)+1
    unless next_idx >= pages.size
      pages[next_idx]
    else
      chapter.next.pages.first
    end
  end
  
  def prev
    pages = chapter.pages
    pages_ids = pages.map{ |p| p.id }
    next_idx = pages_ids.index(self.id)-1
    unless next_idx >= pages.size
      pages[next_idx]
    else
      chapter.next.pages.first
    end
  end
  
  # formats:
  # onemanga  > "img-a.onemanga.com/mangas/#{manga.image_id}/#{chapter.image_id}/#{name}.jpg"
  # 1000manga > "img.1000manga.com/mangas/#{manga.image_id}/#{chapter.image_id}/#{name}.jpg"
  # makevoid  > "uploads.makevoid.com/reepad/#{name}.jpg"
  
  def raw_url
    manga = chapter.manga
    format = eval(manga.site.format)
    format
  end
  
  def image_url
    "img/#{raw_url}"
  end
  
  def good_name
    if name == "0" || name == "00"
      0
    else
      if name.to_i == 0
        name
      else
        name.to_i
      end
    end
  end
end
