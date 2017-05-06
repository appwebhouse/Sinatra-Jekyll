require 'dotenv'

module Jekyll
  class EnvironmentVariablesGenerator < Generator
    priority :highest

    def generate(site)
      site.config['env'] = Dotenv.load
    end
  end
end