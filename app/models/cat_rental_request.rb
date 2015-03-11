class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: %w(PENDING APPROVED DENIED)
  validate :no_overlapping_approved_requests?
  validate :valid_dates

  belongs_to :cat

  after_initialize :set_status

  def approve!
    transaction do
      if no_overlapping_approved_requests?
        self.status = "APPROVED"
        self.save!
        overlapping_pending_requests.each(&:deny!)
      end
    end
  end

  # do not call on approved requests!
  def deny!
    self.status = "DENIED"
    self.save!
  end

  private

  def no_overlapping_approved_requests?
    unless overlapping_approved_requests.empty?
      errors[:request] << "can't overlap approved requests"
      return false
    end

    true
  end

  def overlapping_approved_requests
    reqs = []
    overlapping_requests.each do |overlapping_req|
      reqs << overlapping_req if overlapping_req.status == 'APPROVED'
    end

    reqs
  end

  def overlapping_pending_requests
    reqs = []
    overlapping_requests.each do |overlapping_req|
      reqs << overlapping_req if overlapping_req.status == 'PENDING'
    end

    reqs
  end

  def overlapping_requests
    args = { cat_id: cat_id, id: id, start_date: start_date, end_date: end_date }
    CatRentalRequest.find_by_sql([<<-SQL, args])
      SELECT
        *
      FROM
        cat_rental_requests
      WHERE
        cat_id = :cat_id AND id != :id AND (
          start_date BETWEEN :start_date AND :end_date OR
          end_date BETWEEN :start_date AND :end_date OR
          (start_date < :start_date AND end_date > :end_date)
        )
    SQL
  end

  def set_status
    status ||= 'PENDING'
  end

  def valid_dates
    if start_date && end_date
      unless start_date >= Date.today && end_date > start_date
        errors[:dates] << "are not valid"
      end
    end
  end
end
