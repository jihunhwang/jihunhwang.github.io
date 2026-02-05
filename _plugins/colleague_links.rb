module Jekyll
  module ColleagueLinks
    def link_colleagues(input)
      colleagues = YAML.load_file("_data/colleagues.yml")
      colleagues.each do |name, url|
        input = input.gsub(name, "<a href='#{url}'>#{name}</a>")
      end
      input
    end
  end
end

Liquid::Template.register_filter(Jekyll::ColleagueLinks)