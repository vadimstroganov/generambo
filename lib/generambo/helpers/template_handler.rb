module Generambo
  module Helpers
    module TemplateHandler
      class << self

        def handle!(path, properties)
          files = Dir["#{path}/**/*"]
          files.each do |file|
            next if File.directory?(file)

            file_source = IO.read(file)
            template = Liquid::Template.parse(file_source)
            output = template.render(properties)

            # delete template file
            File.delete(file)

            # remove .liquid extension
            file.slice! File.extname(file)

            # write handled file
            File.open(file, 'w+') { |f| f.write(output) }
          end
        end

      end
    end
  end
end
