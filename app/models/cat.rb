class Cat < ActiveRecord::Base
  COLORS = %w(black calico tabby tortie white)

  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: %w(M F)

  def age
    # (Time.now - birth_date).in.english
  end
end
