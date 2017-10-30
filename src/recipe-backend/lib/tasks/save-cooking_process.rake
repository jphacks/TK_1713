require "#{Rails.root}/lib/scraper/recipes_scraper.rb"
require "csv"
namespace :save do
    task :cooking_process, ['filename'] => :environment do |task, args|
        csv = CSV.read(args['filename'], headers: true)
        movie_id = args['filename'].scan(/(\d+)\.csv/)[0][0]
        p recipe = Recipe.where("movie_url like ?", "https://media.delishkitchen.tv/recipe/#{movie_id}%").first
        csv.each do |row|
            CookingProcess.create(
                step: row["stepNo"].to_i,
                description: row["text"],
                use_stove: row["useStove"],
                leavable: row["leavable"],
                duration: row["duration"],
                movie_start: row["start"].to_f,
                movie_end: row["end"].to_f,
                recipe: recipe
            )
        end
    end
end

