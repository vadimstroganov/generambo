require 'fileutils'

module Generambo
  module Helpers
    module Copier
      class << self

        def transfer(from_path, to_path)
          unless File.directory?(to_path)
            FileUtils.mkdir_p(to_path)
          end

          FileUtils.cp_r(Dir["#{from_path}/*"], to_path)
        end

      end
    end
  end
end
