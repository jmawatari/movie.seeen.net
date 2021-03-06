module ApplicationHelper
  def stars(evaluation)
    return_path = "layout/stars_off.png"
    if evaluation == "83"
      return_path = "layout/stars_on.png"
    end
    return_path
  end

  def activity_of_years(month)
    activities = {}
    month.each do |seen|
      if activities[seen.date.year].blank?
        activities[seen.date.year] = {
          :all    => 0,
          :stars  => 0,
          :wishes => 0
        }
      end

      activities[seen.date.year][:all]    += seen.all
      activities[seen.date.year][:stars]  += seen.stars
      activities[seen.date.year][:wishes] += seen.wishes
    end
    activities
  end

  def in_average_of_seens_monthly(month)
    total = in_total_of_seens month
    "%.2f" % (total.to_f / month.size.to_f)
  end

  def in_total_of_seens(month)
    month.map{|seen| seen.all}.inject(0){|sum, i| sum + i}
  end
end
