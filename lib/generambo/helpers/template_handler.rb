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

            output_directory = File.dirname(file)
            output_filename  = properties[MODULE_NAME_KEY] + File.basename(file)
            output_path      = File.join(output_directory, output_filename)

            # write handled file
            File.open(output_path, 'w+') { |f| f.write(output) }
          end
        end

      end
    end
  end
end
