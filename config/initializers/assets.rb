# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( jquery.js )
Rails.application.config.assets.precompile += %w( angular/controller/orderController.js )
Rails.application.config.assets.precompile += %w( angular/controller/stockController.js )
Rails.application.config.assets.precompile += %w( angular/controller/customerController.js )
Rails.application.config.assets.precompile += %w( angular/controller/productController.js )
Rails.application.config.assets.precompile += %w( angular/controller/userController.js )
Rails.application.config.assets.precompile += %w( angular/controller/modelController.js )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
