json.array!(@records) do |record|
  json.extract! record, :id, :last_payment, :last_taking, :paid, :taken, :last_paid, :last_taken, :paid_count, :taken_count
  json.user do
  	json.extract! record.user, :id, :email, :nick_name
  end
  json.record_url group_record_path(record.group.id, record.id, action: :destroy, format: :json)
end
