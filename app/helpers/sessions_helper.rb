module SessionsHelper

def sign_in(user)
	remember_token = User.new_remember_token
	cookies.permanent[:remember_token] = remember_token
	user.update_attribute(:remember_token, User.encrypt(remember_token))
	self.current_user=user
end

def current_user=(user)
	@current_user=user

end		

def current_user
	remember_token= User.encrypt(cookies[:remember_token])

	@current_user ||= User.find_by(remember_token: remember_token) 
	
	end

def signed_in?
	!current_user.nil?

end

def greeting
    self.current_user.name
end

def sign_out
	current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
	cookies.delete(:remember_token)
	self.current_user = nil

end

def get_user(id)
	if !id.user_id.nil?
	User.find(id.user_id).name
end
end

def get_user_image(id)
	if !id.user_id.nil?
	User.find(id.user_id).image.url
end
end


end
