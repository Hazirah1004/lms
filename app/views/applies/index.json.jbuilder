json.array!(@applies) do |apply|
  json.extract! apply, :id, :leave_type, :start_date, :end_date, :replace_person, :address_on_leave
  json.url apply_url(apply, format: :json)
end
