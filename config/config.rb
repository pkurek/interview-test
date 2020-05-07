class Config
  def working_hours
    {
      weekdays: {
        opens: weekday_working_hours_start,
        closes: weekday_working_hours_end
      },
      sunday: {
        opens: sunday_working_hours_start,
        closes: sunday_working_hours_end
      }
    }
  end

  def courier_delivery_time
    ENV.fetch('TIME_FOR_COURIER_DELIVERY_IN_HOURS', 1).to_i
  end

  private

  def weekday_working_hours_start
    ENV.fetch('MON_SAT_SHOP_WORKING_HOURS_START', 7).to_i
  end

  def weekday_working_hours_end
    ENV.fetch('MON_SAT_SHOP_WORKING_HOURS_END', 20).to_i
  end

  def sunday_working_hours_start
    ENV.fetch('MON_SUN_SHOP_WORKING_HOURS_START', 10).to_i
  end

  def sunday_working_hours_end
    ENV.fetch('MON_SUN_SHOP_WORKING_HOURS_END', 15).to_i
  end
end
