require 'thor'

module Generambo
  module CLI
    class Application < Thor

      desc 'setup', 'Creates a generambofile with a config for a given project'
      def setup
        does_generambofile_exist = Dir[GENERAMBO_FILE].count > 0

        if does_generambofile_exist
          answer = ask('Do you want to overwrite an existing generambofile? (y/n)'.colorize(:red))
          exit unless answer == 'y'
        end

        properties = {}

        setup_username_command = Generambo::CLI::SetupUsernameCommand.new
        setup_username_command.setup_username

        project_name = Pathname.new(Dir.getwd).basename.to_s
        is_right_project_name = yes?("The name of your project is #{project_name}. Do you want to use it? (yes/no)")

        properties[PROJECT_NAME_KEY] = is_right_project_name ? project_name : ask_non_empty_string('The project name:', 'Project name should not be empty')
        properties[PROJECT_PREFIX_KEY]  = ask('The project prefix (if any):')

        Generambo::GenerambofileGenerator.create_generambofile(properties)

        puts('Generambofile successful created!'.colorize(:green))
      end

    end
  end
end
