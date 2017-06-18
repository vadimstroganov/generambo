require 'generambo/constants/user_preferences_constants.rb'

module Generambo

  # A class that provides methods for working with user-specific information.
  class UserPreferences
    class << self
      def obtain_username
        path = obtain_user_preferences_path

        file_contents = open(path).read
        preferences = file_contents.empty? ? {} : YAML.safe_load(file_contents).to_hash

        preferences[USERNAME_KEY]
      end

      def save_username(username)
        path = obtain_user_preferences_path

        file_contents = open(path).read
        preferences = file_contents.empty? ? {} : YAML.safe_load(file_contents).to_hash

        preferences[USERNAME_KEY] = username
        File.open(path, 'w+') { |f| f.write(preferences.to_yaml) }
      end

      def obtain_user_preferences_path
        home_path = Pathname.new(ENV['HOME']).join(GENERAMBO_HOME_DIR)

        path_exists = Dir.exist?(home_path)

        unless path_exists
          FileUtils.mkdir_p home_path
        end

        preferences_path = home_path.join(USER_PREFERENCES_FILE)
        preferences_exist = File.file?(preferences_path)

        unless preferences_exist
          File.open(preferences_path, 'w+') { |f| f.write('') }
        end

        preferences_path
      end
    end
  end
end
