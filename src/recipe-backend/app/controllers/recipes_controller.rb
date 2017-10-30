class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @recipe = Recipe.find(params[:id])
  end

  def rempi
    ids = params["ids"].split(",").map(&:to_i)
    uri = URI.parse("http://localhost:5000/post")
    http = Net::HTTP.new(uri.host,uri.port)
    req = Net::HTTP::Post.new(uri.path)
    req["Content-Type"] = "application/json"
    req.body = {recipe_ids: ids}.to_json

    res = http.request(req)
    p body = res.body
    @steps = JSON.parse(res.body)["ResultSet"]["result"]
    @recipes = Recipe.where(id: ids).all
  end
end
