# Setting
Pry.config.color = true
Pry.config.editor = "vim"
Pry.config.history.file = "~/.irb_history"

# Alias
alias :r :require
alias :l :load
Pry.config.commands.alias_command 'lM', 'ls -M'
Pry.config.commands.alias_command 'w', 'whereami'
Pry.config.commands.alias_command '.clr', '.clear'

# Prompt
Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "AWS@" if defined?(AWS)
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

# Exception
Pry.config.exception_handler = proc do |output, exception, _|
  puts ___.colorize "#{exception.class}: #{exception.message}", 31
  puts ___.colorize "from #{exception.backtrace.first}", 31
end

# Handy hotkeys for debugging!
# refs: https://github.com/nixme/pry-debugger#tips
if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# Rails
if defined?(Rails)
  begin
    require "rails/console/app"
    require "rails/console/helpers"
  rescue LoadError => e
    require "console_app"
    require "console_with_helpers"
  end
end
