class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_or_last_null
  validates :gender, inclusion: { in: %w(male female),
    message: "%{value} is not a valid gender" }
  validate :male_not_sue

  def first_or_last_null
    if first_name.nil? && last_name.nil?
      errors.add( :base, "Please, specify either a first or a last name." )
    end
  end

  def male_not_sue
    if gender == 'male' && first_name == 'Sue'
      errors.add( :first_name, "A male cannot have first name Sue!" )
    end
  end

  def self.get_all_profiles(min_byear, max_byear)
    Profile.where( "birth_year BETWEEN :min_byear AND :max_byear", min_byear: min_byear, max_byear: max_byear ).order( :birth_year )
  end
end
