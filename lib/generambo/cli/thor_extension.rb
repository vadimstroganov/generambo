require 'thor'

module Generambo
  module CLI
    class ::Thor
      no_commands do
        def ask_non_empty_string(message, description = 'Value should be nonempty string')
          return ask_with_validation(message, ->(value) { value.length > 0 }, description)
        end

        def ask_with_validation(message, is_valid_value, description = 'Invalid value')
          loop do
            value = ask(message)
            return value if is_valid_value.call(value)
            puts(description.red)
          end
        end
      end
    end
  end
end
