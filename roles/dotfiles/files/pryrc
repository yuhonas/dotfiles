def pbcopy(str)
  IO.popen('pbcopy', 'r+') {|io| io.puts str }
  output.puts "-- Copy to clipboard --\n#{str}"
end

Pry::Commands.block_command "pbpaste", "Paste from the clipboard" do
  target.eval(`pbpaste`)
end

Pry.config.commands.command "pbcopy", "Copy to clipboard" do |str|
  unless str
    str = "#{_pry_.input_array[-1]}#=> #{_pry_.last_result}\n"
  end
  pbcopy str
end

Pry.config.commands.command "lastcopy", "Last result copy to clipboard" do
  pbcopy _pry_.last_result.to_s.chomp
end

# alias 'q' for 'exit'
Pry.config.commands.alias_command "q", "exit-all"

# Load 'awesome_print'
#begin
#  require 'awesome_print'
#  require 'awesome_print/ext/active_record'
#  require 'awesome_print/ext/active_support'
#  AwesomePrint.pry!
#rescue LoadError => err
#end

# switch default editor for pry to sublime text
Pry.config.editor = proc { |file, line| "open subl://open?url=file://#{file}&line=#{line}" }

# format prompt to be <Rails version>@<ruby version>(<object>)>
#Pry.config.prompt = proc do |obj, level, _|
#  prompt = ""
#  if defined?(Rails)
    #prompt << "~#{Rails.application.class.to_s.split("::").first}"
    #prompt << "\e[37;44m#{Rails.application.class.to_s.split("::").first}"
    #prompt << " \e[49;34m #{Rails.version}@"
#  end

  #prompt << "#{RUBY_VERSION}"
  #"\e[2;32m#{prompt}\e[0m \e[2;37m(#{obj})> \e[0m"

 # "#{prompt} (#{obj})> "
#end

if defined?(Rails)
  old_prompt = Pry.config.prompt
  env        = Pry.config.color ? Pry::Helpers::Text.red(Rails.env) : Rails.env

  Pry.config.prompt = proc {|*a| "[#{env}] #{old_prompt.first.call(*a)}"}
end
