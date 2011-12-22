require 'rbconfig'

module Tokenifier
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def create_templates
      template 'config/tokenifier.yml.erb', 'config/tokenifier.yml'
    end

    protected

    def embed_file(source, indent='')
      IO.read(File.join(self.class.source_root, source)).gsub(/^/, indent)
    end

    def embed_template(source, indent='')
      template = File.join(self.class.source_root, source)
      ERB.new(IO.read(template), nil, '-').result(binding).gsub(/^/, indent)
    end
  end
end