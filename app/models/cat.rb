class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  COLORS = %w(black calico tabby tortie white)

  validates :birth_date, :name, presence: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: %w(M F)
  validate :birthdate_in_past?

  has_many :requests, class_name: :CatRentalRequest, dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end

  def sorted_requests
    requests.sort { |a, b| a.start_date <=> b.start_date }
  end

  def birthdate_in_past?
    if birth_date
      unless Date.today > birth_date
        errors.add(:birth_date, "must be in the past")
      end
    end
  end
end
