# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :likeable, polymorphic: true, counter_cache: true
end
