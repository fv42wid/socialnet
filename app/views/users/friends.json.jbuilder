json.array!(@friends) do |friend|
  json.id friend.id
  json.name friend.email
end