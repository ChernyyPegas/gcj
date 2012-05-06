# -*- coding: utf-8 -*-
# Problem A. Diamond Inheritance

# D < B, C
# B < A
# C < A
#
# Your task is to determine whether or not a given class diagram contains a diamond inheritance.
require 'rgl/adjacency'
INPUT = <<__EOL__
3
3
1 2
1 3
0
5
2 2 3
1 4
1 5
1 5
0
3
2 2 3
1 3
0
__EOL__

# 3    # the number of classes in this diagram, N. class 1, 2, 3.
# 1 2  # 1st class inherits from 2nd class
# 1 3  # 1st class inherits from 3rd class
# 0

def make_graph(input)
  dg    = RGL::AdjacencyGraph[]
  lines = input.split("\n")
  n     = lines[0].to_i
  for i in 1..n do
    data = lines[i].split(" ")
    next if data[0].to_i <= 0
    data.shift # break data
    data.each{|v| dg.add_edge i, v.to_i }
  end
  dg
end

def cycled?(dg)
  cycled = dg.cycles.select{|s| s.size >= 3}
  cycled.size >= 1 ? true : false
end

outfile = File.open("./out.txt", "w+")

File.open("./A-small-attempt0.in.txt") do |infile|
  row = 0
  @store = ""; @testnum = 0
  # infile = INPUT 
  # for line in infile.split("\n") do
  while line = infile.gets
    row += 1
    next if row == 1
    @qline = line.to_i + 1 if (@qline == 0) or (@qline == nil)
    @store << line + "\n" && @qline = @qline - 1
    if @qline == 0
      flag = cycled?(make_graph(@store))
      outfile.write "Case ##{@testnum + 1}: #{flag ? "Yes" : "No"}\n"
      @store = ""; @testnum = @testnum + 1
    end
  end

end
outfile.close

