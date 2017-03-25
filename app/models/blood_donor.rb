class BloodDonor < ActiveRecord::Base
  belongs_to :blood_group
  belongs_to :gender
  has_many :blood_receivers
  validates :name, :age, :address, :gender_id, :blood_group_id, presence: true
  validates :age, :phone_num, numericality: {only_integer: true}
  validates :phone_num, length: { is: 7 }
end