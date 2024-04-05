require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  api_url = "https://www.fruityvice.com/api/fruit/all"
  raw_data =  HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  @parsed_data = JSON.parse(raw_data_string)

  fruit_array = []
  count = 0

  @parsed_data.each do |fruit_info|
    name = fruit_info.fetch("name")
    fruit_array.push(name)
  end

  @fruit_array = fruit_array.sort

  erb(:home)
end

get("/fruit") do
  @param = params.fetch("fruit_name")

  api_url = "https://www.fruityvice.com/api/fruit/#{@param}"
  raw_data =  HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  @parsed_data = JSON.parse(raw_data_string)

  nutrition_hash = @parsed_data.fetch("nutritions")
  @calories = nutrition_hash.fetch("calories")
  @fat = nutrition_hash.fetch("fat")
  @sugar = nutrition_hash.fetch("sugar")
  @carbohydrates = nutrition_hash.fetch("carbohydrates")
  @protein = nutrition_hash.fetch("protein")

  @family = @parsed_data.fetch("family")
  @order = @parsed_data.fetch("order")
  @genus = @parsed_data.fetch("genus")

  erb(:fruit)
end

get("/nutrition") do
  api_url = "https://www.fruityvice.com/api/fruit/all"
  raw_data =  HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  @parsed_data = JSON.parse(raw_data_string)

  name_array = []
  count = 0

  @parsed_data.each do |fruit_info|
    name = fruit_info.fetch("name")
    name_array.push(name)
  end

  @name_array = name_array.sort

  @calories_array = []
  @fat_array = []
  @sugar_array = []
  @carbohydrates_array = []
  @protein_array = []
  @family_array = []
  @order_array = []
  @genus_array = []

  @name_array.each do |fruit|
    @parsed_data.each do |fruit_info|
      @name = fruit_info.fetch("name")

      if fruit == @name
        nutrition_hash = fruit_info.fetch("nutritions")
        calories = nutrition_hash.fetch("calories")
        fat = nutrition_hash.fetch("fat")
        sugar = nutrition_hash.fetch("sugar")
        carbohydrates = nutrition_hash.fetch("carbohydrates")
        protein = nutrition_hash.fetch("protein")
        family = fruit_info.fetch("family")
        order = fruit_info.fetch("order")
        genus = fruit_info.fetch("genus")  

        @calories_array.push(calories) 
        @fat_array.push(fat)
        @sugar_array.push(sugar)
        @carbohydrates_array.push(carbohydrates)
        @protein_array.push(protein)
        @family_array.push(family)
        @order_array.push(order)
        @genus_array.push(genus)
      end
    end  
  end  

  erb(:nutrition)
end

get("/gallary") do
  api_url = "https://www.fruityvice.com/api/fruit/all"
  raw_data =  HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  @parsed_data = JSON.parse(raw_data_string)

  fruit_info = @parsed_data.fetch(0)
  @fruit_names = fruit_info.fetch("name")

  erb(:gallary)
end
