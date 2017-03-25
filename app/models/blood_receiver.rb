class BloodReceiver < ActiveRecord::Base
  belongs_to :gender
  belongs_to :blood_group
  belongs_to :blood_donor

  validates :name, :age, :address, :gender_id, :blood_group_id, :blood_donor_id, presence: true
  validates :age, :phone_num, numericality: {only_integer: true}
  validates :phone_num, length: { is: 7 }

end
