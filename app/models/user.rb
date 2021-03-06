class User < ActiveRecord::Base
    has_many :collections 
    has_secure_password 
    validates :username, :email, presence: true, uniqueness: true
    validates :first_name, :last_name, presence: true

    def slug 
        username.downcase.gsub(" ","-")
    end 
    
    def self.find_by_slug(slug)
        User.all.find{|user| user.slug == slug}
    end 
end