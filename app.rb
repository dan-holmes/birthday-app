require "sinatra"
require "shotgun"

set :session_secret, "here be dan"

get "/" do
  erb(:form)
end

get "/result" do
  @name = params["name"]
  @days_until_birthday = days_until(next_birthday(Date.parse(params["birthday"])))
  if @days_until_birthday == 0
    erb(:happy_birthday)
  else
    erb(:result)
  end
end

def next_birthday(birthday)
  if Date.new(Date.today.year, birthday.month, birthday.day) < Date.today
    Date.new(Date.today.year + 1, birthday.month, birthday.day)
  else
    Date.new(Date.today.year, birthday.month, birthday.day)
  end
end

def days_until(birthday)
  (next_birthday(birthday) - Date.today).to_int
end
