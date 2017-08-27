class UserApp < ApplicationRecord
	has_secure_password
	mount_uploader :ppic, ImageUploader
end
