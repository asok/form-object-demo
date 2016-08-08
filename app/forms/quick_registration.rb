class QuickRegistration
  include FormObject

  Attributes = [
    :email,
    :password,
    :password_confirmation
  ]

  define_attributes User, *Attributes

  validates_presence_of :email, :password, :password_confirmation
  validates_confirmation_of :password

  def initialize(attributes = {})
    assign_attributes(attributes)
  end
end
