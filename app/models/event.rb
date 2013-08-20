class Event < ActiveRecord::Base
  validates :date, presence: true
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :organizer_name, presence: true
  validates :organizer_email, presence: true 
  validate :organizer_email_must_be_valid
  validate :date_cannot_be_in_the_past
  # validate :valid_date

  def date_cannot_be_in_the_past
    unless date.present? && date > Date.today
      errors.add(:date, "Can't be in the past")
    end
  end

  def organizer_email_must_be_valid
    unless organizer_email.present? && (organizer_email =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i)
      errors.add(:organizer_email, "Not a valid email")
    end
  end

  # def valid_date
  #   using html date class instead of this to make it pretty
  #   errors.add(:date, 'must be a valid date') if ((DateTime.parse(date) rescue ArgumentError) == ArgumentError)
  # end

end


  

 