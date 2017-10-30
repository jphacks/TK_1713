require "#{Rails.root}/lib/scraper/recipes_scraper.rb"
namespace :scrape do
    task :category, ['category_id'] => :environment do |task, args|
        CategoryScraper.scrape_category(args['category_id'])
    end
end

