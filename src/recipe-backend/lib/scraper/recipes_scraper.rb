require "active_record"
require "#{Rails.root}/app/models/application_record.rb"
require "#{Rails.root}/app/models/recipe.rb"
require "#{Rails.root}/app/models/recipe_food.rb"
require "#{Rails.root}/app/models/food.rb"
require "#{Rails.root}/app/models/category.rb"

require "open-uri"
require 'nokogiri'

#poltergistの設定
Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 5000 })
end
Capybara.default_selector = :xpath

module CategoryScraper
    VISITED_LOG = "visited_log.txt"
    MAX_PAGE = 2

    # https://delishkitchen.tv/categories/9238
    # https://wapi.delishkitchen.tv/categories/9238?page=1&per=12&parents=true
    def self.scrape_category(category_id)
        (1..MAX_PAGE).each do |n|
            url = "https://wapi.delishkitchen.tv/categories/#{category_id}?page=#{n}&per=12&parents=true"
            response = open(url).read
            json = JSON.parse(response)
            category = Category.find_or_create_by(name: json["data"]["name"])

            json["data"]["recipes"].each do |recipe|
                RecipeScraper.save_recipe(recipe, category)
            end
        end
    end
end

module RecipeScraper
    def self.save_thumbnail_urls
        Recipe.all.each do |recipe|
            url = "https://wapi.delishkitchen.tv/recipes/#{recipe.original_id}"
            response = open(url).read
            json = JSON.parse(response)
            recipe.thumbnail_url = json["data"]["square_video"]["poster_url"]
            recipe.save
        end
    end

    def self.save_recipe(recipe, category)
        # "https://wapi.delishkitchen.tv/recipes/167010489358877075"
        recipe_id = recipe["id"]
        # api_url = "https://wapi.delishkitchen.tv/recipes/#{recipe_id}"
        if Recipe.find_by(original_id: recipe_id)
            return
        end
        puts name = recipe["title"]
        movie_url = recipe["square_video"]["url"]

        recipe_model = Recipe.new(name: name, original_id: recipe_id, movie_url: movie_url, category: category)

        serving_text = recipe["recipe_servings"][0]["name"]
        # serving = serving_text.scan(/\d+/)[0].to_i
        recipe["ingredient_groups"].each do |ingredient_group|
            ingredient_group["recipe_ingredients"].each do |ingredient|
                food = Food.find_or_create_by(name: ingredient["name"])
                ingredient_serving = ingredient["servings1"]
                # 分数 or 小数
                # amount = ingredient_serving.scan(/(\d+\/\d+)|[\d+\.\d+]/)[0].to_r.to_f
                RecipeFood.create(amount_name: serving_text, serving_name: ingredient_serving, food: food, recipe: recipe_model)
            end
        end
        recipe_model.save
    end
end
