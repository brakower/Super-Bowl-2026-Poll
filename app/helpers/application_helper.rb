module ApplicationHelper
  def percent_for(votes, total)
    return 0.0 if total.to_i.zero?

    ((votes.to_f / total) * 100).round(1)
  end
end
