# -*- coding: utf-8 -*-

INPUT = <<__EOL__
3 3 1
###
#X#
###
__EOL__

# coordinates -- start at up-left

# def split_cases(data)
#   lines = data.split("\n")
#   for i in 1...lines.size do
#     info = lines[i].split.map(&:to_i)
#   end
# end

# split_cases(INPUT)

#   3 3 2
#   ###
#   #X#
#   ###
KEYS = [:height, :width, :dim]
def scan_case(data)
  lines = data.split("\n")
  pre_info  = lines.first
  pre_info  = pre_info.split.map(&:to_i)
  info = Hash[*[KEYS,pre_info].transpose.flatten]
  map = lines[1..-1]
  return {info: info, map: map}
end

# p scan_case(INPUT)

def whereami(map)
  map.each_with_index do |line, row|
    if line.index("X")
      line.split("").each_with_index do |char, col|
        return [row, col] if char == "X"
      end
    end
  end
end

def distance(p1, p2)
  Math.sqrt((p2[1] - p1[1])**2 + (p2[0] - p1[0])**2)
end

def mirror?(coord, map)
  # coord[0]: row
  # coord[1]: col
  map[coord[0]].split("")[coord[1]] == "#"
end

def myself?(coord, map)
  map[coord[0]].split("")[coord[1]] == "X"
end

# p mirror?([0,2], scan_case(INPUT)[:map])

# 123
# 4X6
# 789
def can_you_see?(map, dim, direction)
  plus = case direction
         when 1 then [-1,-1]
         when 2 then [-1, 0]
         when 3 then [-1, 1]
         when 4 then [ 0,-1]
         when 6 then [ 0, 1]
         when 7 then [ 1,-1]
         when 8 then [ 1, 0]
         when 9 then [ 1, 1]
         end

  #print "whereami: "
  whereami = whereami(map)
  coord = whereami

  while dim > 0 do
    whereamfrom = coord
    coord = [coord,plus].transpose.map{|ary| ary.inject(&:+) }

    #print "distance: "
    distance = distance(whereamfrom, coord)

    if whereamfrom == whereami || coord == whereami
      # 最初は0.5しか進まないわけだが...。
      if plus.any?{|e| e==0}
        dim -= 0.5
      else #角度を付けて入ってきた場合
        dim -= Math.sqrt(0.5**2 + 0.5**2)
      end
    else
      dim -= distance
    end
    return false if dim < 0
    #print "now: "
    #p coord
    #print "dim: "
    #p dim
    if myself?(coord, map)
      return true
    elsif mirror?(coord, map)
     # print "!!! mirror #{plus} -> "
      # TODO: 入った角度による。これはきれいに反射した場合
      plus = plus.map{|e| -1*e }
     # print "#{plus}\n"
    end
  end
end

outfile = File.open("./out.txt", "w+")
File.open("./D-small-attempt1.in"){|infile|

  @cases = []; @one_case = []
  infile.read.split("\n").each_with_index do |line, index|
    next if index == 0
    if line.split.size == 3
      #height = line.split.first
      if @one_case.size == 0
        @one_case << line
      elsif @one_case.size >= 2
        @cases << @one_case.join("\n")
        @one_case = []
        @one_case << line
      end
      next
    end
    @one_case << line unless line.split.size == 3
  end
  # のこり。
  @cases << @one_case.join("\n") if @one_case.size >= 2

  @cases.each_with_index do |case_input, how|
    scaned_case = scan_case(case_input)
    count = 0
    for i in 1..9 do
      next if i == 5
      #  p "============== direction: #{i} ==============="
      if can_you_see?(scaned_case[:map], scaned_case[:info][:dim], i)
        count += 1
      end
    end
    outfile.write "Case ##{how+1}: #{count}\n"
  end
}
outfile.close

