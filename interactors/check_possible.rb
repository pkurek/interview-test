class CheckPossible
  def initialize(delivery_created_time, courier_delivery_time, config = Config.new)
    @delivery_created_time = delivery_created_time
    @courier_delivery_time = courier_delivery_time
    @config                = config
  end

  def call
    # order is possible to realise when time to courier delivery intersection with shop open time hour ranges is non-empty
    shop_working_ranges = shop_days_open_range.step(1.day).map do |day|
      shop_working_day = Time.at(day).to_datetime
      next if holiday?(shop_working_day)

      hours     = working_hours(shop_working_day)
      opens_at  = set_hour_to_time(time_or_day: shop_working_day, hour: hours[:opens])
      closes_at = set_hour_to_time(time_or_day: shop_working_day, hour: hours[:closes])

      opens_at..closes_at
    end.compact

    shop_working_ranges.any? { |shop_working_range| time_ranges_overlapped?(shop_working_range, order_delivery_range) }
  end

  private

  attr_reader :delivery_created_time, :courier_delivery_time, :config

  def holiday?(date)
    Holiday.present_on?(date)
  end

  def order_delivery_range
    delivery_created_time + config.courier_delivery_time.hours..courier_delivery_time.to_time
  end

  def shop_days_open_range
    delivery_created_time.to_i..(courier_delivery_time.to_date.to_time + 1.day).to_i
  end

  def time_ranges_overlapped?(range_a, range_b)
    start_a = range_a.first
    end_a   = range_a.last
    start_b = range_b.first
    end_b   = range_b.last

    (start_a <= end_b) && (end_a >= start_b)
  end

  def set_hour_to_time(time_or_day:, hour:)
    Time.new(time_or_day.year, time_or_day.month, time_or_day.day, hour, 0, 0, '+02:00')
  end

  def working_hours(date)
    config.working_hours.fetch(date.strftime('%A').downcase.to_sym) { config.working_hours[:weekdays] }
  end
end
