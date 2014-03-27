class MangasController < ApplicationController
  
  def index
    @mangas = if params[:lpage]
      lpage = Manga.lpages.index params[:lpage]
      Manga.all(published: true, letter_idx: lpage)
    else
      Manga.paginate(published: true, page: params[:page])
    end
  end
  
  def show
    @manga = first_named Manga
    return not_found if @manga.nil?
    @chapters = @manga.chapters
  end
  
  def redirect
    @manga = Manga.get(params[:id])
    return not_found if @manga.nil?
    redirect_to manga_path(@manga.name_url)
  end
  
  def our_favourites
  end
end