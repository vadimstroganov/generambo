require 'liquid'

module Generambo
  class GenerambofileGenerator

    def self.create_generambofile(properties)
      file_source = IO.read(File.dirname(__FILE__) + '/Generambofile.liquid')

      template = Liquid::Template.parse(file_source)
      output = template.render(properties)

      File.open(GENERAMBO_FILE, 'w+') { |f| f.write(output) }
    end

  end
end
