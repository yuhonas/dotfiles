# use exa over standard ls
function ls
  exa $argv
end

function ll
  exa -al $argv
end
