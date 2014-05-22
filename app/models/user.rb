class User < ActiveRecord::Base
has_many :comments
has_many :posts
before_create :create_remember_token

has_attached_file :image
validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

has_secure_password
#validates :name, presense:true
#validates_presence_of :password, length: {minimum: 3}
validates_presence_of :password, :on => create



	def info

		User.find(params[:id]).name

	end

def User.new_remember_token
	SecureRandom.urlsafe_base64
end

def User.encrypt(token)
	Digest::SHA1.hexdigest(token.to_s)
end



private

	def create_remember_token

	self.remember_token = User.encrypt(User.new_remember_token)
	end

end
