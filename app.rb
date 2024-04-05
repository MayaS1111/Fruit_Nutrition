require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  api_url = "https://www.fruityvice.com/api/fruit/all"
  raw_data =  HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  @parsed_data = JSON.parse(raw_data_string)

  fruit_info = @parsed_data.fetch(1)
  @fruit_array = []
  count = 0

  @parsed_data.each do |fruit_info|
    name = fruit_info.fetch("name")
    @fruit_array.push(name)
  end

  erb(:home)
end

get("/nutrition") do
  api_url = "https://www.fruityvice.com/api/fruit/all"
  raw_data =  HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  @parsed_data = JSON.parse(raw_data_string)

  fruit_info = @parsed_data.fetch(0)
  @fruit_names = fruit_info.fetch("name")

  erb(:nutrition)
end
