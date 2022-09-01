class FeatureWindow < ApplicationRecord
  validates_presence_of :start_date, :end_date
  validates_inclusion_of :featured, in: [true, false]

  belongs_to :product

  scope :expired, -> { where('end_date < ?', DateTime.current.utc) }
  scope :active, -> { where('featured = true AND start_date <= :date AND end_date >= :date', date: DateTime.current.utc) }
end
