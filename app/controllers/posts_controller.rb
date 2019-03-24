# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

  def index
    @post = Post.new
    @posts = Post.search(params[:search])
    @comment = Comment.new
    @categories = Category.all
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @categories = Category.all
  end

  def create
    @comment = Comment.new
    @post = Post.new(title: params[:title], content: params[:content], category_id: params[:category_id], writter: current_user, post_pictures: params[:post_pictures])

    if @post.save
      respond_to do |format|
        format.js
        format.html { redirect_to posts_path, notice: 'Publications cree avec succes.' }
      end
    else
      respond_to do |format|
        format.js { render "fail_create" }
        format.html { redirect_to posts_path, notice: "Erreur lors de la creation de votre publications" }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Publications editee avec succes.' }
      else
        format.html { redirect_to posts_path, "Erreur lors de l'edition de votre publications" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Publications supprimee avec succes.' }
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id, :search)
  end
end
