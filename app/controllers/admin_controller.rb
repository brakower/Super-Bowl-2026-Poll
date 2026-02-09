# frozen_string_literal: true

class AdminController < ApplicationController
  def reset
    token = ENV["ADMIN_TOKEN"]
    header_token = request.headers["X-Admin-Token"]

    unless token.present? && ActiveSupport::SecurityUtils.secure_compare(token, header_token.to_s)
      head :unauthorized
      return
    end

    Vote.delete_all
    Team.update_all(votes_count: 0)

    render json: { status: "ok" }
  end
end
