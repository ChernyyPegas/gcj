# -*- coding: utf-8 -*-

MAPPING = {
 "a" => "y",
 "b" => "h",
 "c" => "e",
 "d" => "s",
 "e" => "o",
 "f" => "c",
 "g" => "v",
 "h" => "x",
 "i" => "d",
 "j" => "u",
 "k" => "i",
 "l" => "g",
 "m" => "l",
 "n" => "b",
 "o" => "k",
 "p" => "r",
 "q" => "z",
 "r" => "t",
 "s" => "n",
 "t" => "w",
 "u" => "j",
 "v" => "p",
 "w" => "f",
 "x" => "m",
 "y" => "a",
 "z" => "q",
 " " => " "
}

#puts  MAPPING.keys.map{|k| MAPPING.values.include?(k)}

def mapping(str)
  str.split("").map{|s| MAPPING[s] }.join
end

@cases = []
File.open("./A-small-attempt1.in"){|file|
  row = 0
  while line = file.gets
    row = row + 1
    next if row == 1
    @cases << line.chomp!
  end
}


@cases.each_with_index do |c, i|
  answer = mapping(c)
  puts "Case ##{i+1}: " + answer
end

