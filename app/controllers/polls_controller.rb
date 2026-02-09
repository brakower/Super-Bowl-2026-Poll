# frozen_string_literal: true

class PollsController < ApplicationController
  before_action :ensure_voter_id

  def show
    @teams = ordered_teams
    @total_votes = Team.sum(:votes_count)
    @voted_team = Team.find_by(id: voted_team_id)
    @already_voted = @voted_team.present?
    @change_mode = params[:change].present? && @already_voted && !changed_vote?
  end

  private

  def ordered_teams
    Team.order(Arel.sql("CASE name WHEN 'Seahawks' THEN 1 WHEN 'Patriots' THEN 2 ELSE 3 END"))
  end
end
