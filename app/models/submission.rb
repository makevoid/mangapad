class Submission
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :chapters_url, String
  property :first_page_url, String
  property :email, String
end