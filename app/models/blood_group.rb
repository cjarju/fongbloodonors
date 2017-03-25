class BloodGroup < ActiveRecord::Base
  has_many :blood_donors
  has_many :blood_receivers
end
