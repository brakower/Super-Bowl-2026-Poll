require "securerandom"

class ApplicationController < ActionController::Base
  helper_method :changed_vote?

  private

  def ensure_voter_id
    cookies.signed.permanent[:voter_id] ||= SecureRandom.uuid
  end

  def voter_id
    cookies.signed[:voter_id]
  end

  def voted_team_id
    cookies.signed[:voted_team_id]
  end

  def set_voted_team_id(team_id)
    cookies.signed.permanent[:voted_team_id] = team_id
  end

  def changed_vote?
    cookies.signed[:changed_vote] == true
  end

  def mark_changed_vote!
    cookies.signed.permanent[:changed_vote] = true
  end
end
