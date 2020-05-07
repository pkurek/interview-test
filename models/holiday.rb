# == Schema Information
#
# Table name: holidays
#
#  id         :bigint(8)        not null, primary key
#  day        :date
#  kind       :integer          default("custom")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Holiday < ApplicationRecord
  extend Enumerize

  validates :day, presence: true
  validate :is_holiday?

  scope :holidays_between, ->(start_date, end_date) { where("day BETWEEN ? AND ?", start_date, end_date).map(&:day).uniq }
  enumerize :kind, in: { custom: 0, non_working_sunday: 1 }

  private

  def is_holiday?
    errors.add(:day, :invalid) unless day.sunday?
  end
end
