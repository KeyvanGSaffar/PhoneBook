class TextGraphic
  MAX_TB_CHR = 80.0
  TOP_LINE = "\u2554" + "\u2550" * 80 + "\u2557" 
  BUTTOM_LINE = "\u255A" + 80 * "\u2550" + "\u255D"
  def initialize
  end

  def directory array

  	string = []
  	array.each {|i|
  	  string+ = "u2192 #{i} "
  	}
  	string = string[1..-2]
  	len = string.length
  	line = len / MAX_TB_CHR # number of lines to show in the box

  end
end