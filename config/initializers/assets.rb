# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')





Rails.application.config.assets.precompile += %w( usernew/step1.css )
Rails.application.config.assets.precompile += %w( usernew/new_telephone.css )
Rails.application.config.assets.precompile += %w( usernew/step3.css )
Rails.application.config.assets.precompile += %w( usernew/step4.css )
Rails.application.config.assets.precompile += %w( usernew/signup1.css )
Rails.application.config.assets.precompile += %w( usernew/signup2.css )
Rails.application.config.assets.precompile += %w( items.css )
Rails.application.config.assets.precompile += %w( usernew/new_credit.css )