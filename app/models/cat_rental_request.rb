class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: %w(PENDING APPROVED DENIED)
  validate :no_overlapping_approved_requests?

  belongs_to :cat

  after_initialize :set_status

  private

  def no_overlapping_approved_requests?
    overlapping_approved_requests.empty?
  end

  def overlapping_approved_requests
    reqs = []
    overlapping_requests.each do |overlapping_req|
      reqs << overlapping_req if overlapping_req.status == 'APPROVED'
    end

    reqs
  end

  def overlapping_requests
    reqs = []
    CatRentalRequest.all.each do |other_req|
      next if other_req == self
      if other_req.start_date.between?(start_date, end_date) ||
         other_req.end_date.between?(start_date, end_date) ||
         (other_req.start_date < start_date && other_req.end_date > end_date)
        reqs << other_req
      end
    end

    reqs
  end

  def set_status
    status ||= 'PENDING'
  end
end
