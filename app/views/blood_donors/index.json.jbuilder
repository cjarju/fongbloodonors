json.array!(@blood_donors) do |blood_donor|
  json.extract! blood_donor, :id, :name, :age, :phone_num, :address, :gender_id, :blood_group_id
  json.url blood_donor_url(blood_donor, format: :json)
end
