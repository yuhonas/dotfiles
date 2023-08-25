#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'

# See also https://medium.com/simply-dev/do-more-with-rails-console-by-configuring-irbrc-e5c25284305d

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

%w[rubygems looksee/shortcuts ].each do |gem|
  begin
    require gem
  rescue LoadError
  end
end

# exit using `q`
alias q exit

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    system 'ri', method.to_s
  end
end

def clipcopy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def uf
  User.first
end

def ul
  User.last
end

def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
  copy content
end

def paste
  # use zsh clipboard aliases so it works cross platform
  # see https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/clipboard.zsh
  `zsh --interactive -c clippaste`
end
