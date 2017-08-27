class Postlike < ApplicationRecord
  belongs_to :user_app
  belongs_to :post
end
