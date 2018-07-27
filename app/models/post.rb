class Post < ApplicationRecord
  # validations
  validates_presence_of :content, :user_id
end
