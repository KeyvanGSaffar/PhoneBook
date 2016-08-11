class PhoneBook

  def initialize
    @contacts=[]
    @count=0
  end
  
  def save contact
    @contacts<<contact
    @count+=1
  end
  
  def fetch
    return @contacts
  end
end