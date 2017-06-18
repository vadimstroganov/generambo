module Generambo
  module CLI
    class SetupUsernameCommand < Thor

      no_commands {
        def setup_username
          username = Generambo::UserPreferences.obtain_username
          unless username
            puts('The author name is not configured!'.red)
            git_username = Git.init.config['user.name']
            if git_username != nil && yes?("Your name in git is configured as #{git_username}. Do you want to use it in code headers? (yes/no)")
              username = git_username
            else
              username = ask_non_empty_string('The author name which will be used in the headers:', 'User name should not be empty')
            end
            Generambo::UserPreferences.save_username(username)
          end

        end
      }
    end
  end
end
