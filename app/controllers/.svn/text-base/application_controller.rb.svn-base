class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  # dm not found
  def not_found
    render file: "public/404.html", status: 404, layout: false
  end
  
  # named resources
  
  def first_named(klass, options={})
    if params[:id].to_i != 0 && params[:id].to_s.size == params[:id].to_i.to_s.size # seems_int?
      klass.get(params[:id])
    else
      klass.first(options.merge(name_url: params[:id]))
    end
  end
  
end
