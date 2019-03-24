class CommentsController < ApplicationController
	def create
		params[:comment_id] ? commenteable = Comment.find(params[:comment_id]) : commenteable = Post.find(params[:post_id])

		@comment = Comment.new(user: current_user, content:params[:comment][:content], commenteable: commenteable)

		if @comment.save
			respond_to do |format|
				format.html { redirect_to posts_path(params[:post_id]), notice: "Votre commentaire a bien été créé" }
				format.js
			end
		else
			redirect_to posts_path(params[:post_id])
		end
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
		post_params = params.require(:comment).permit(:content)

		if @comment.update(post_params)
			respond_to do |format|
				format.html { redirect_to posts_path, notice: 'Votre commentaire a bien été édité' }
				format.js
			end
		else
			redirect_to posts_path, notice: "Erreur lors de l'edition de votre commentaire"
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to posts_path, notice: 'Commentaire supprime !'}
			format.js
		end			
	end
end