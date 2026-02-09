# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :ensure_voter_id

  def create
    result = VoteManager.new.cast_vote(params[:team], voter_id)
    set_voted_team_id(result.voted_team_id) if result.voted_team_id

    if result.status == :ok
      redirect_to root_path, notice: result.message
    else
      redirect_to root_path, alert: result.message
    end
  end

  def update
    if changed_vote?
      redirect_to root_path, alert: "You already changed your vote."
      return
    end

    result = VoteManager.new.change_vote(params[:team], voter_id)

    if result.status == :ok
      set_voted_team_id(result.voted_team_id)
      mark_changed_vote!
      redirect_to root_path, notice: result.message
    else
      redirect_to root_path, alert: result.message
    end
  end
end
