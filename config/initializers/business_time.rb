start_date = Time.current.beginning_of_year - 1.year
end_date = Time.current.next_year.end_of_year

BusinessTime::Config.beginning_of_workday = "10:00:00 am"
BusinessTime::Config.end_of_workday = "08:00:00 pm"

HolidayJp.between(start_date, end_date).each { |h| BusinessTime::Config.holidays << h.date }
