# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
  editor-style.css
  editor-default.css
  editor-animate.css
  editor-style-responsive.css
  sunny-editor
  lightbox.css
  pace.js
  gallery.demo.js
  sunny-detail.js
  sunny-home.js
  sunny-search.js
  sunny-editor.js
  qrcode.min.js
  lightbox-2.6.min.js

  jquery-1.9.1
  jquery.isotope.js

  editor-apps.js
  editor-pace.js
  sunny-admin.js
  sunny-profile.js
  )
