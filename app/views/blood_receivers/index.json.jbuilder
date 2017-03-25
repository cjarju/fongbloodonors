json.array!(@blood_receivers) do |blood_receiver|
  json.extract! blood_receiver, :id, :name, :age, :phone_num, :address, :gender_id, :blood_group_id, :date_received
  json.url blood_receiver_url(blood_receiver, format: :json)
end
