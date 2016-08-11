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
  end

  def whatActInitial?
    puts "What would you like to do?"
    puts "1. Add entry 2. See Entries 3. Quit"
    puts "Please enter the number corresponding to your request"
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

  def addEntry
    puts "From the following options, please enter the number corresponding to your requats"
    puts "1. Add new entry 2. Update entry 3. Cancel"
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

  def seeEntry
    puts "From the following options, please enter the number corresponding to your requats"
    puts "1. See all entries 2. See single entry 3. Cancel"
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

  def email?
    puts "Do you want to add emial address? (Y/N)"
    email = gets
    if ['y','Y'].include? email[0]
      return true
    else
      return false
    end
  end

  def number?
    puts "Do you want to add phone number? (Y/N)"
    number = gets
    if ['y','Y'].include? number[0]
      return true
    else
      return false
    end
  end

  def getContactName
    puts 'Enter Name'
    name=gets.strip
    #number=gets.strip
    return {name: name} #, number: number}
  end

  def getContactNumber
    puts 'Enter Number or press 1 to cancel'
    number=gets.strip
    #number=gets.strip
    return {number: number} #, number: number}
  end

  def getContactEmail
    puts 'Enter Email or press 1 to cancel'
    email=gets.strip
    #number=gets.strip
    return {email: email} #, number: number}
  end

  def show contactsInfo
    contactsInfo.each{|j| 
    print "#{j[:name]} #{j[:number]} #{j[:email]}\n"
    }
  end

  def dontExist
    puts 'the contact you are searching for does not exist'
  end

end
