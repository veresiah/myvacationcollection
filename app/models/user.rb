class User < ActiveRecord::Base
    has_many :collections 
    has_secure_password 

    def slug 
        username.donwcase.gsub("","-")
    end 
    
    def self.find_by_slug(slug)
        User.all.find{|user| user.slug == slug}
    end 
end
