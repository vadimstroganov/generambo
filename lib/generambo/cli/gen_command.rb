require 'thor'
require 'fileutils'

module Generambo
  module CLI
    class Application < Thor

      desc 'gen [MODULE_NAME] [TEMPLATE_FOLDER]', 'Creates a new VIPER module with a given name from a specific template'
      def gen(module_name, template_folder)
        does_generambofile_exist = Dir[GENERAMBO_FILE].count > 0

        unless does_generambofile_exist
          puts('generambofile not found! Run `generambo setup` in the working directory instead!'.colorize(:red))
          exit
        end

        setup_username_command = Generambo::CLI::SetupUsernameCommand.new
        setup_username_command.setup_username

        properties = YAML.load_file(GENERAMBO_FILE)
        properties[USERNAME_KEY] = Generambo::UserPreferences.obtain_username
        properties[CURRENT_DATE_KEY] = Time.now.strftime('%d/%m/%Y')
        properties[MODULE_NAME_KEY] = module_name

        template_folder_path = File.join(Dir.pwd, 'Templates', template_folder)
        unless File.directory?(template_folder_path)
          puts('Template does not exist!'.colorize(:red))
          exit
        end

        module_path = File.join(Dir.pwd, module_name)

        if File.directory?(module_path)
          answer = ask('The module already exists. Overwrite it? (y/n)'.colorize(:blue))
          exit unless answer == 'y'

          # remove old directory
          FileUtils.rm_rf(module_path)
        end

        # copying template files
        Generambo::Helpers::Copier.transfer(template_folder_path, module_path)

        # processing template files
        Generambo::Helpers::TemplateHandler.handle!(module_path, properties)
      end

    end
  end
end
