class Stringify
  attr_accessor :name, :adjective

  def initialize(name, adjective)
    @name = name
    @adjective = adjective
  end

  def what_am_i
  	if not (@name.blank? or @adjective.blank?)
  		@name + " is so " + @adjective
  	else
  		"You are nothing!"
    end
  end
end
