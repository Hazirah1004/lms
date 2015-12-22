json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :ic, :address, :phone, :position, :email, :dept, :startdate
  json.url employee_url(employee, format: :json)
end
