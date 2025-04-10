# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.

# /app/assets
Rails.application.config.assets.precompile += %w[ users_backoffice.css ]

# /app/javascript
Rails.application.config.assets.precompile += %w[ users_backoffice.js ]

# /lib/assets
Rails.application.config.assets.precompile += %w[ custom.js custom.css img.jpg]

# /vendor/assets
Rails.application.config.assets.precompile += %w[ jquery-2.2.3/dist/jquery.js ]
