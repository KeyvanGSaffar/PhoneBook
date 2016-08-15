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
      dir = ["Main"]
      #index = [1,2,3]
      action = @view.whatActInitial? dir
###########################################################################################
      if action == :addEntry # add entry
        dir << "Add Entry"
        step1 = @view.addEntry dir 
        begin 
          if step1 == :addNewEntry #add new entry
            dir << "Add New Entry"
            dir << "Contact Name:"
          	contactName = @view.getContactName dir# getting the name and save it
          	contact = Contact.new(contactName[:name])
            @phoneBook.save(contact)
            dir = dir[0..-2] << "Add Number?"
            if @view.number? dir # ask if he wants to add phone number
              done = 0
              begin
                dir = dir[0..-2] << "Number: (1 => Cancel)"
                number_temp = @view.getContactNumber dir
                
                number2 = number_temp[:number]
                
                if number2 =~ /^(?:\+?(?:[1-9]{1,3}))? (?:(?:\([0-9]{3}\))|(?:[0-9]{3}))?[0-9]{3}-?[0-9]{4}$/ #re match
                  puts number2
                  if !(number2 =~ /^\+/) # if + does not exist
                    number2 = '+' + number2
                  end
                  if !(number2 =~ /-/)
                    number2 = number2[0..-5] + '-' + number2[-4..-1]
                  end 
                  if !(number2 =~ /\(/)
                    number2 = number2[0..-12] + '(' + number2[-11..-9] + ')' + number2[-8..-1]
                  end
                  if number2 =~ /^\+\(/ # if + exists but country code doesn't
                    number2 = '+1' + number2[1..-1]
                  end

                  contact.number = number2
                  done = 1
                elsif number2 == '1'
                  done = 1
                end
              end while done == 0
            end
            dir = dir[0..-2] << "Add Email?"
            if @view.email? dir# ask if he wants to add email
              done = 0
              begin
                dir = dir[0..-2] << "Email: (1  => Cancel)"
                email2 = @view.getContactEmail dir
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
            dir << "Update Entry" 
            dir << "Contact Name:"
            
          	contactName = @view.getContactName dir
          	contacts = @phoneBook.fetch
          	contactFnd = []
            contacts.each{|j| 
          	  if j.name == contactName[:name]
			        contactFnd = j
          	  end
            }
            if !(contactFnd == [])
              dir = dir[0..-2] << "Add Number?"
              if @view.number? dir# ask if he wants to add phone number
                done = 0
                begin
                  dir = dir[0..-2] << "Number:"
                  number2 = @view.getContactNumber dir
                  number2 = number2[:number]
                  if number2 =~ /^(?:\+?(?:[1-9]{1,3}))? (?:(?:\([0-9]{3}\))|(?:[0-9]{3}))?[0-9]{3}-?[0-9]{4}$/ # re match
                    if !(number2 =~ /^\+/) # if + does not exist
                      number2 = '+' + number2
                    end
                    # if number2 =~ /^\+[\((?:[0-9]{3})\(|(?:[0-9]{3})]?[0-9]{3}-?[0-9]{4}$/ # if + exists but country code doesn't
                    #   number2 = '+1' + number2[1..-1]
                    # end
                    if !(number2 =~ /-/)
                      number2 = number2[0..-5] + '-' + number2[-4..-1]
                    end 
                    if !(number2 =~ /\(/)
                      number2 = number2[0..-12] + '(' + number2[-11..-9] + ')' + number2[-8..-1]
                    end
                    if number2 =~ /^\+\(/ # if + exists but country code doesn't
                    number2 = '+1' + number2[1..-1]
                    end
                    contactFnd.number = number2
                    done = 1
                  elsif number2 == '1'
                    done = 1
                  end
                end while done == 0
              end
              dir = dir[0..-2] << "Add Email?"
              if @view.email? dir # ask if he wants to add email
                done = 0
                begin
                  dir = dir[0..-2] << "Email:"
                  email2 = @view.getContactEmail dir
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
              step1 = :cancel
            end
          elsif step1 == :cancel # cancel

          else # wrong input
            @view.invalid
            #dir = ["Main"]
          	step1=@view.addEntry dir
          end
        end while !(step1 == :cancel)
      end  
############################################################################################
      if action == :seeEntry # see entries
        begin
        dir = ["Main","See Entry"]
        step2 = @view.seeEntry dir
          
          if step2 == :seeAll # see all contacts info
            dir << "See All Entries"
            contacts = @phoneBook.fetch
            contactsInfo=[]
            contacts.each{|j|
            contactsInfo<<{name:j.name , number:j.number , email:j.email}
            }
            @view.show(contactsInfo,dir)
            step2 = :cancel
          elsif step2 == :seeSingle # see an contact by name
            dir << "See Single Entry"
            dir << "Contact Name:" 
            contactName = @view.getContactName dir
            contacts = @phoneBook.fetch
            contactFnd = []
            contacts.each{|j| 
              if j.name == contactName[:name]
              contactFnd = j
              end
            }
            if !(contactFnd == [])
              @view.show([{name: contactFnd.name , number: contactFnd.number , email: contactFnd.email}],dir)
              step2 = :cancel
            else
              @view.dontExist
            end
            step2 = :cancel
          elsif step2 == :cancel # cancel
          else
            @view.invalid
            dir = ["Main","See Entry"]
            step2 = @view.seeEntry dir
          end
        end while !(step2 == :cancel)
      end
      if action == :invalidReq
        @view.invalid
      end
    end while !(action==:quit)
  end 
end
main = Main.new
main.start
