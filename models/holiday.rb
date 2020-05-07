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

  enumerize :kind, in: { custom: 0, non_working_sunday: 1 }

  def self.present_on?(day)
    where(day: day).present?
  end

  private

  def is_holiday?
    errors.add(:day, :invalid) unless day.sunday?
  end
end
