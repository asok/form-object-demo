class FullRegistration < QuickRegistration
  Attributes = QuickRegistration::Attributes + [
    :date_of_birth,
    :terms_accepted
  ]

  define_attributes User, *Attributes

  validates_acceptance_of :terms_accepted
  validates_presence_of :date_of_birth
  validate :date_of_birth_in_the_past

  protected

  def date_of_birth_in_the_past
    errors.add(:date_of_birth, "have to be in the past") unless date_of_birth.past?
  end
end
