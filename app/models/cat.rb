class Cat < ActiveRecord::Base
  COLORS = %w(black calico tabby tortie white)

  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: %w(M F)

  has_many :requests, class_name: :CatRentalRequest, dependent: :destroy

  def age
    # (Time.now - birth_date).in.english
  end

  def sorted_requests
    requests.sort { |a, b| a.start_date <=> b.start_date }
  end
end
