json.array!(@managers) do |manager|
  json.extract! manager, :id, :employee_id, :dept_id
  json.url manager_url(manager, format: :json)
end
