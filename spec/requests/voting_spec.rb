# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Voting", type: :request do
  before do
    Team.create!(name: "Seahawks")
    Team.create!(name: "Patriots")
  end

  it "increments count when voting" do
    get root_path
    post vote_path, params: { team: "Seahawks" }

    expect(Team.find_by(name: "Seahawks").votes_count).to eq(1)
  end

  it "prevents double vote with cookie" do
    get root_path
    post vote_path, params: { team: "Seahawks" }
    post vote_path, params: { team: "Patriots" }

    expect(Team.find_by(name: "Seahawks").votes_count).to eq(1)
    expect(Team.find_by(name: "Patriots").votes_count).to eq(0)
  end

  it "allows a one-time vote change" do
    get root_path
    post vote_path, params: { team: "Seahawks" }
    patch vote_path, params: { team: "Patriots" }

    expect(Team.find_by(name: "Seahawks").votes_count).to eq(0)
    expect(Team.find_by(name: "Patriots").votes_count).to eq(1)
  end

  it "requires admin token for reset" do
    ENV["ADMIN_TOKEN"] = "secret"

    post "/admin/reset"
    expect(response).to have_http_status(:unauthorized)

    post "/admin/reset", headers: { "X-Admin-Token" => "secret" }
    expect(response).to have_http_status(:ok)
  ensure
    ENV.delete("ADMIN_TOKEN")
  end

  it "returns API results shape" do
    get "/api/results"

    body = JSON.parse(response.body)
    expect(body).to include("teams", "total_votes")
    expect(body["teams"]).to be_an(Array)
    expect(body["teams"].first).to include("name", "votes", "percent")
  end
end
