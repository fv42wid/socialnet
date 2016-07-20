json.array!(@friends) do |user|
  json.id user.id
  json.email user.email
end