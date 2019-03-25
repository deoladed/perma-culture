# frozen_string_literal: true

class Post < ApplicationRecord
  has_many_attached :post_pictures
  
  # after_create :tweet
  # after_create :fb_post

  belongs_to :writter, class_name: 'User', counter_cache: true
  belongs_to :category
  has_many :comments, as: :commenteable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

	validates :content, 
	presence: true,	
	length:{minimum: 5, maximum: 3000}
	
	validates :title,
	presence: true,
	length:{minimum: 5, maximum: 60}

  scope :by_latest_comment, -> {Post.joins(:comments).merge(Comment.order(created_at: :desc))}
  scope :by_date, -> { order(created_at: :asc)}

  def readable_date
    self.created_at.strftime("%d/%m/%y à %H:%M")
  end

  def self.search(search)
    if search
      where('content ILIKE ?', "%#{search}%").or(
      where('title ILIKE ?', "%#{search}%"))
    else
      all.reverse
    end
  end

  def comments_size
    self.comments.size + self.comments.map{|comment| comment.comments.size}.sum
  end

  def poeple_who_like
    self.likes.map{|like| like.user.user_name}.join(', ')
  end

  def writter_name
    self.writter.user_name.capitalize
  end

  def category_name
    self.category.name.downcase
  end

  def was_writted_by(user)
    self.writter == user || user.is_admin
  end

  def likes_size
    self.likes.size
  end

  def content_safe
    self.content.gsub(URI.regexp, '<a target:"_blank" href="\0">\0</a>').html_safe
  end

  private

  def tweet
    BotTwitter.new(self.title, self.writter.user_name).perform
  end

  def fb_post
    FacebookPost.new(self.title, self.content, self.writter).perform
  end
end
