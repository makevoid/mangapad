set :application, "mangapad"


set :domain, "kim.makevoid.com" # old: ovh.makevoid.com
set :domain2,      "makevoid.com"

set :repository,  "svn://makevoid.com/svn/#{application}"


set :deploy_to,   "/www/#{application}"



set :use_sudo,    false
set :user,        "www-data"     

set :scm_username, "makevoid"
set :scm_password, "final33man"
# set :deploy_via, :copy
# set :copy_exclude, [".git", "db", "nbproject", "public/images/cars"]


role :app, domain
role :web, domain
role :db,  domain, :primary => true


after :deploy, "deploy:create_symlinks"

after :deploy, "deploy:cleanup"
after :deploy, "chmod:entire"


namespace :deploy do
  
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  
  desc "Create symlinks (managing server)"
  task :create_symlinks do
    #run "cd #{current_path}/public; ln -s #{shared_path}/sitemap.xml sitemap.xml"
  end
  
end

namespace :chmod do 
  desc "chmod entire dir"
  task :entire do
    run "cd #{current_path}; chown www-data:www-data -R *"
  end
end


set :apache_name, "apache2"
set :pub_domain, domain



def path
  File.expand_path File.dirname(__FILE__)
end


namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
  
  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end
  
  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock;"
  end
  
  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock;"
  end
end

# HOOKS
after "deploy:update_code" do
  bundler.bundle_new_release
  # ...
end

namespace :sitemap do
  desc "regenerate and uploads sitemap"
  task :regen do
    `rm -f tmp/sitemap.*`
    `cd tmp; wget http://localhost:3000/sitemap.xml`
    upload( "tmp/sitemap.xml", "#{shared_path}/sitemap.xml", :via => :scp)
  end
  
  desc "regenerate and uploads sitemap"
  task :delete do
    run "rm -f #{shared_path}/sitemap.xml"
  end
end


namespace :db do
  desc "Create database"
  task :create do
    run "mysql -u root --password=final33man -e 'CREATE DATABASE IF NOT EXISTS #{application}_production;'"
  end
  
  desc "Seed database"
  task :seeds do
    run "cd #{current_path}; RAILS_ENV=production rake db:seeds"
  end
  
  desc "Send the local db to production server"
  task :toprod do
    # `rake db:seeds`
    `mysqldump -u root #{application}_development > db/#{application}_development.sql`
    `gzip -c db/#{application}_development.sql > db/#{application}_development.tgz`
    upload "db/#{application}_development.tgz", "#{current_path}/db", :via => :scp
    run "cd #{current_path}/db && gunzip -c #{application}_development.tgz > #{application}_development.sql"
    run "mysql -u root --password=final33man #{application}_production < #{current_path}/db/#{application}_development.sql"
  end
  
  desc "Get the remote copy of production db"
  task :todev do
    run "mysqldump -u root --password=final33man #{application}_production > #{current_path}/db/#{application}_production.sql"
    download "#{current_path}/db/#{application}_production.sql", "db/#{application}_production.sql"
    local_path = `pwd`.strip
    `mysql -u root #{application}_development < #{local_path}/db/#{application}_production.sql`
  end
end