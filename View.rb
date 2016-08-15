require './TextGraphic'

class View
  
  ADD_ENTRY=1
  SEE_ENTRY=2
  QUIT=3
  ####################
  ADD_NEW_ENTRY = 1
  UPDATE_ENTRY = 2
  CANCEL = 3
  ####################
  SEE_ALL = 1
  SEE_SINGLE = 2

  def initialize 
    puts "Thanks for using Phone Book Application\nwritten by Keyvan Gharouni Saffar"
    @textgraphic = TextGraphic.new
  
  end

  def whatActInitial? dir
    @textgraphic.directory(dir)
    @textgraphic.options(["Add entry","See Entries","Quit"],[1,2,3])
    action = gets.to_i
    if action==ADD_ENTRY
      return :addEntry
    elsif action == SEE_ENTRY
      return :seeEntry
    elsif action == QUIT 
      return :quit
    else
      return :invalidReq
    end
  end

  def addEntry dir
    @textgraphic.directory(dir)
    @textgraphic.options(["Add New Entry","Update Entry","Cancel"],[1,2,3])
    step1 = gets.to_i
    if step1==ADD_NEW_ENTRY
      return :addNewEntry
    elsif step1 == UPDATE_ENTRY
      return :updateEntry
    elsif step1 == CANCEL 
      return :cancel
    else
      return :invalidReq
    end
  end

  def seeEntry dir
    @textgraphic.directory(dir)
    @textgraphic.options(["See All Entries","See Single Entry","Cancel"],[1,2,3])
    step2 = gets.to_i
    if step2==SEE_ALL
      return :seeAll
    elsif step2 == SEE_SINGLE
      return :seeSingle
    elsif step2 == CANCEL 
      return :cancel
    else
      return :invalidReq
    end
  end

  def email? dir
    @textgraphic.directory(dir)
    @textgraphic.options(["Yes","No"],["Y","N"])
    email = gets
    if ['y','Y'].include? email[0]
      return true
    else
      return false
    end
  end

  def number? dir
    @textgraphic.directory(dir)
    @textgraphic.options(["Yes","No"],["Y","N"])
    number = gets
    if ['y','Y'].include? number[0]
      return true
    else
      return false
    end
  end

  def getContactName dir
    #puts 'Enter Name'
    @textgraphic.directory(dir)
    print "\u2192 "
    name=gets.strip
    #number=gets.strip
    return {name: name} #, number: number}
  end

  def getContactNumber dir
    @textgraphic.directory(dir)
    @textgraphic.error('Put a space after country code')
    print "\u2192 "
    number=gets.strip
    #number=gets.strip
    return {number: number} #, number: number}
  end

  def getContactEmail dir
    @textgraphic.directory(dir)
    print "\u2192 "
    email=gets.strip
    #number=gets.strip
    return {email: email} #, number: number}
  end

  def show contactsInfo,dir
    cnt = 0
    @textgraphic.directory(dir)
    contactsInfo.each{|j|
    cnt += 1  
    print "\n #{cnt}) #{j[:name]} #{j[:number]} #{j[:email]}\n"
    }
  end

  def dontExist
    @textgraphic.error('the contact you are searching for does not exist')
  end

  def invalid
    @textgraphic.error('Invalid Request')
  end

end
