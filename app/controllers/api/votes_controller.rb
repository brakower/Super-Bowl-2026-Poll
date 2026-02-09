# frozen_string_literal: true

module Api
  class VotesController < ApplicationController
    before_action :ensure_voter_id

    def create
      result = VoteManager.new.cast_vote(params[:team], voter_id)
      set_voted_team_id(result.voted_team_id) if result.voted_team_id

      render json: {
        teams: result.teams,
        total_votes: result.total_votes,
        already_voted: result.already_voted,
        message: result.message
      }
    end
  end
end
