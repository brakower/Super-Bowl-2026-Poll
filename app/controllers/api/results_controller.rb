# frozen_string_literal: true

module Api
  class ResultsController < ApplicationController
    def show
      results = VoteManager.new.results

      render json: {
        teams: results.teams,
        total_votes: results.total_votes
      }
    end
  end
end
