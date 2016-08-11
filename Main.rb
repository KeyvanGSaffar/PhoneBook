require './View'
require './PhoneBook'
require './Contact'

class Main
  
  def initialize
    @view = View.new
    @phoneBook=PhoneBook.new
  end
  def start
    begin
      action = @view.whatActInitial?
###########################################################################################
      if action == :addEntry # add entry
        step1 = @view.addEntry
        begin 
          if step1 == :addNewEntry #add new entry
          	contactName = @view.getContactName # getting the name and save it
          	contact = Contact.new(contactName[:name])
            @phoneBook.save(contact)
            if @view.number? # ask if he wants to add phone number
              done = 0
              begin
                number_temp = @view.getContactNumber
                
                number2 = number_temp[:number]
                
                if number2 =~ /^(?:\+?(?:[1-9]{1,3}))?[\((?:[0-9]{3})\(|(?:[0-9]{3})]?[0-9]{3}-?[0-9]{4}$/ #re match
                  puts number2
                  if !(number2 =~ /^\+/) # if + does not exist
                    number2 = '+' + number2
                  end
                  if number2 =~ /^+[\((?:[0-9]{3})\(|(?:[0-9]{3})]?[0-9]{3}-?[0-9]{4}$/ # if + exists but country code doesn't
                    number2 = '+1' + number2[1..-1]
                  end
                  if !(number2 =~ /-/)
                    number2 = number2[0..-5] + '-' + number2[-4..-1]
                  end 
                  if !(number2 =~ /\(/)
                    number2 = number2[0..-12] + '(' + number2[-11..-9] + ')' + number2[-8..-1]
                  end
                  contact.number = number2
                  done = 1
                elsif number2 == '1'
                  done = 1
                end
              end while done == 0
            end

            if @view.email? # ask if he wants to add email
              done = 0
              begin
                email2 = @view.getContactEmail
                email2 = email2[:email]
                if email2 =~ /^[a-zA-Z0-9_\.]+@[a-zA-Z]+\.[a-zA-Z]{2,4}$/
                  contact.email= email2
                  done = 1                
                elsif email2 == '1'
                  done = 1
                end
              end while done == 0
            end
            step1 = :cancel
          elsif step1 == :updateEntry # update entry
          	contactName = @view.getContactName
          	contacts = @phoneBook.fetch
          	contactFnd = []
            contacts.each{|j| 
          	  if j.name == contactName[:name]
			        contactFnd = j
          	  end
            }
            if !(contactFnd == [])

              if @view.number? # ask if he wants to add phone number
                done = 0
                begin
                  number2 = @view.getContactNumber
                  number2 = number2[:number]
                  if number2 =~ /^(?:\+?(?:[1-9]{1,3}))?[\((?:[0-9]{3})\(|(?:[0-9]{3})]?[0-9]{3}-?[0-9]{4}$/ #re match
                    if !(number2 =~ /^\+/) # if + does not exist
                      number2 = '+' + number2
                    end
                    if number2 =~ /^+[\((?:[0-9]{3})\(|(?:[0-9]{3})]?[0-9]{3}-?[0-9]{4}$/ # if + exists but country code doesn't
                      number2 = '+1' + number2[1..-1]
                    end
                    if !(number2 =~ /-/)
                      number2 = number2[0..-5] + '-' + number2[-4..-1]
                    end 
                    if !(number2 =~ /\(/)
                      number2 = number2[0..-12] + '(' + number2[-11..-9] + ')' + number2[-8..-1]
                    end
                    contactFnd.number = number2
                    done = 1
                  elsif number2 == '1'
                    done = 1
                  end
                end while done == 0
              end

              if @view.email? # ask if he wants to add email
                done = 0
                begin
                  email2 = @view.getContactEmail
                  email2 = email2[:email]
                  if email2 =~ /^[a-zA-Z0-9_\.]+@[a-zA-Z]+\.[a-zA-Z]{2,4}$/
                    contactFnd.email= email2
                    done = 1               	
                  elsif email2 == '1'
                    done = 1
                  end
                end while done == 0
              end
              step1 = :cancel
            else
              @view.dontExist
            end
          elsif step1 == :cancel # cancel
          else # wrong input
          	step1=@view.addEntry 
          end
        end while !(step1 == :cancel)
      end  
############################################################################################
      if action == :seeEntry # see entries
        step2 = @view.seeEntry
        begin
          if step2 == :seeAll # see all contacts info
            contacts = @phoneBook.fetch
            contactsInfo=[]
            contacts.each{|j|
            contactsInfo<<{name:j.name , number:j.number , email:j.email}
            }
            @view.show(contactsInfo)
            step2 = :cancel
          elsif step2 == :seeSingle # see an contact by name
            contactName = @view.getContactName
            contacts = @phoneBook.fetch
            contactFnd = []
            contacts.each{|j| 
              if j.name == contactName[:name]
              contactFnd = j
              end
            }
            if !(contactFnd == [])
              @view.show([{name: contactFnd.name , number: contactFnd.number , email: contactFnd.email}])
              step2 = :cancel
            else
              @view.dontExist
            end
          elsif step2 == :cancel # cancel
          else
            step2 = @view.seeEntry
          end
        end while !(step2 == :cancel)
      end
    end while !(action==:cancel)
  end 
end
main = Main.new
main.start
