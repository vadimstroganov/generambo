require 'thor'
require 'liquid'
require 'generambo/cli/gen_command'
require 'generambo/cli/setup_command'
require 'generambo/cli/setup_username_command'
require 'generambo/cli/thor_extension'
require 'git'

module Generambo
  module CLI
    class Application < Thor
    end
  end
end
