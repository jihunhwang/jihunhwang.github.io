source "https://rubygems.org"
# Hello! This is where you manage which Jekyll version is used to run.
# When you want to use a different version, change it below, save the
# file and run `bundle install`. Run Jekyll with `bundle exec`, like so:
#
#     bundle exec jekyll serve
#
# This will help ensure the proper Jekyll version is running.
# Happy Jekylling!
gem "jekyll", ">= 4.2.0"
# This is the default theme for new Jekyll sites. You may change this to anything you like.

gem "activesupport", ">= 6.1.7.3"
gem "kramdown", ">= 2.3.1"
gem 'jekyll-analytics'
gem 'jekyll-sitemap'
gem "rexml", ">= 3.3.6"
gem "nokogiri", ">= 1.16.5"
gem 'jekyll-paginate'
gem "minimal-mistakes-jekyll", "~> 4.24.0"
gem 'jekyll-archives'

# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
# gem "github-pages", group: :jekyll_plugins
# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem 'jekyll-data'
  gem "jekyll-remote-theme"
  # Github no longer supports minimal-mistakes-jekyll directly, so remote theme is now required.
  # https://batsov.com/articles/2021/12/19/changes-to-github-pages/
  gem "jekyll-compose"
  gem 'jekyll-redirect-from'
  gem 'jekyll-spaceship'
end


gem 'jemoji'
gem 'sassc'

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
install_if -> { RUBY_PLATFORM =~ %r!mingw|mswin|java! } do
  gem "tzinfo", "~> 2.0"
  gem "tzinfo-data"
end


# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :install_if => Gem.win_platform?


gem "webrick", "~> 1.7"

gem "faraday-retry"


