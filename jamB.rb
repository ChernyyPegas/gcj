# -*- coding: utf-8 -*-

@normal_scores   = (0..10).to_a.repeated_permutation(3).select{|a| (a.max - a.min) <  2}
@surprising_scores = (0..10).to_a.repeated_permutation(3).select{|a| (a.max - a.min) == 2}

# n = googlers
# s = surprisings
# p = threshold
# scores = total_scores
def solve(n, s, p, *scores)
  counter = 0
  scores  = scores.sort.reverse!
  res = scores.map{|sum|
    normal_matchs     = @normal_scores.select{|score| score.inject(&:+) == sum}
    surprising_matchs = @surprising_scores.select{|score| score.inject(&:+) == sum}
    [normal_matchs.select{|score| score.max >= p }.size >= 1,
    surprising_matchs.select{|score| score.max >= p }.size >= 1]
  }
  res.each do |a|
    if a[0] == true
      counter += 1
    elsif a[0] == false && a[1] == true
      next if s <= 0
      counter += 1
      s -= 1
    end
  end
  counter
end

### sample ###
# lines = [
#   "3 1 5 15 13 11",
#   "3 0 8 23 22 21",
#   "2 1 1 8 0",
#   "6 2 8 29 20 8 18 18 21"
# ]

outfile = File.open("./out.txt", "w+")

File.open("./B-large.in"){|infile|
  row = 0
  while line = infile.gets
    row += 1
    next if row == 1
    answer = solve *line.split.map(&:to_i)
    outfile.write "Case ##{row-1}: #{answer}\n"
  end
}

outfile.close
