require "administrate/base_dashboard"

class PostDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    post_pictures_attachments: Field::HasMany.with_options(class_name: "ActiveStorage::Attachment"),
    post_pictures_blobs: Field::HasMany.with_options(class_name: "ActiveStorage::Blob"),
    writter: Field::BelongsTo.with_options(class_name: "User"),
    category: Field::BelongsTo,
    comments: Field::HasMany,
    likes: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    content: Field::Text,
    posting_date: Field::DateTime,
    writter_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :post_pictures_attachments,
    :post_pictures_blobs,
    :writter,
    :category,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :post_pictures_attachments,
    :post_pictures_blobs,
    :writter,
    :category,
    :comments,
    :likes,
    :id,
    :title,
    :content,
    :posting_date,
    :writter_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :post_pictures_attachments,
    :post_pictures_blobs,
    :writter,
    :category,
    :comments,
    :likes,
    :title,
    :content,
    :posting_date,
    :writter_id,
  ].freeze

  # Overwrite this method to customize how posts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(post)
  #   "Post ##{post.id}"
  # end
end
