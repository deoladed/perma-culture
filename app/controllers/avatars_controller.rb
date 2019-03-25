class AvatarsController < ApplicationController

	 	def create
		@user = User.find(params[:user_id])
		
		unless params[:avatar].nil?
			@user.avatar.attach(params[:avatar])
			respond_to do |format|
				format.html { redirect_to posts_path, notice: "Avatar mis a jour !" }
				# format.js
			end
		end
	end
end
