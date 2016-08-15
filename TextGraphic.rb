class TextGraphic
  MAX_TB_CHR = 80.0
  TOP_LINE_DR = "\u2554" + "\u2550" * 80 + "\u2557" 
  BUTTOM_LINE_DR = "\u255A" + "\u2550" * 80 + "\u255D"
########################################################################################
  TOP_LINE_TABLE = "\u256D" + "\u2500" * 3 + "\u252C" + "\u2500" *76 + "\u256E"
  BUTTOM_LINE_TABLE = "\u2570" + "\u2500" * 3 + "\u2534" + "\u2500" *76 + "\u256F"
  MIDDLE_LINE_TABLE = "\u251C" + "\u2500" * 3 + "\u253C" + "\u2500" *76	 + "\u2524"
  def initialize
  end

  def directory array

    string = ""
    array.each do |i|
      string += "\u2192 #{i} "
    end
    string = "\u2551" + string[1..-1] + " " * + (80 - string[1..-1].length) + "\u2551"
    #len = string.length
    #line = (len / MAX_TB_CHR).ceil # number of lines to show in the box
    puts TOP_LINE_DR
    puts string
    puts BUTTOM_LINE_DR
  end

  def options array1,array2
    prinT = []
    cnt = 0
    prinT << TOP_LINE_TABLE
    array1.each do |i|
      prinT << "\u2502 #{array2[cnt]} \u2502 #{i}" + " " * (75 - i.length) + "\u2502"
      prinT << MIDDLE_LINE_TABLE
      cnt += 1
    end 
    prinT = prinT[0..-2]
    prinT << BUTTOM_LINE_TABLE
    puts prinT
    print "\u2192 "
  end

  def error text
    prinT = []
    prinT << TOP_LINE_TABLE
    prinT << "\u2502 \u2573 \u2502 #{text}" + " " * (75 - text.length) + "\u2502"
    prinT << BUTTOM_LINE_TABLE
    puts prinT
  end
end

# a = []
# a<< "Main"
# a<< "Add Entry"
# a<< "Add New Entry"
# textgraphic = TextGraphic.new
# textgraphic.error("This does not exits")

