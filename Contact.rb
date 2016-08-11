class Contact
  attr_reader :name,:number,:email
  attr_writer :number,:email
  def initialize name#,number
    @name = name
    @number = ""
    @email = ""
  end
end