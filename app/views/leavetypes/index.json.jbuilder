json.array!(@leavetypes) do |leavetype|
  json.extract! leavetype, :id, :ltype
  json.url leavetype_url(leavetype, format: :json)
end
