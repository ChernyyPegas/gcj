# -*- coding: utf-8 -*-

outfile = File.open("./out.txt", "w+")

# largeやったら重すぎた
File.open("./C-large.in"){|infile|

  row = 0
  while line = infile.gets
    done = []; recycled = []
    row += 1
    next if row == 1
    start, endat = line.split.map(&:to_i)

    for i in start..endat do
      #print "================= i: ", i, "\n"
      done << i
      ary = i.to_s.split("")
      keta = ary.size
      for k in 1..keta-1 do
        # print "#{k} ----\n"
        ary_dup = ary.dup
        piece = ary_dup.slice!(k, keta - k)
        # print "#{piece} + #{ary_dup}\n"
        next if piece[0] == "0"
        # ary.unshift(ary.pop)的なことかと思ったけど一気にごそっとずれる。
        shifted = (piece + ary_dup).join.to_i
        if shifted <= endat && i < shifted && !recycled.include?(shifted)
          # print "#{k}th shift -- #{start} <= #{i} < #{shifted} <= #{endat}\n"
          recycled << [i, shifted]
        end
      end
    end

    # distinctと言われてuniquしてみたら合致。
    answer = recycled.uniq.size

    outfile.write "Case ##{row-1}: #{answer}\n"

  end
}

outfile.close
