# frozen_string_literal: true

require "digest"

class VoteManager
  Result = Struct.new(
    :status,
    :message,
    :teams,
    :total_votes,
    :already_voted,
    :voted_team_id,
    keyword_init: true
  )

  def cast_vote(team_name, voter_id)
    team = find_team(team_name)
    return result(status: :invalid_team, message: "Invalid team.") unless team

    voter_hash = hash_voter(voter_id)
    existing_vote = Vote.find_by(voter_hash: voter_hash)
    if existing_vote
      return result(
        status: :already_voted,
        message: "You already voted for #{existing_vote.team.name}.",
        already_voted: true,
        voted_team_id: existing_vote.team_id
      )
    end

    vote = Vote.create!(team: team, voter_hash: voter_hash)
    result(
      status: :ok,
      message: "Vote recorded for #{team.name}.",
      already_voted: false,
      voted_team_id: vote.team_id
    )
  end

  def results
    result(status: :ok, message: "OK")
  end

  def change_vote(new_team_name, voter_id)
    team = find_team(new_team_name)
    return result(status: :invalid_team, message: "Invalid team.") unless team

    voter_hash = hash_voter(voter_id)
    existing_vote = Vote.find_by(voter_hash: voter_hash)
    return result(status: :not_voted, message: "No existing vote to change.") unless existing_vote

    if existing_vote.team_id == team.id
      return result(status: :no_change, message: "You already voted for #{team.name}.")
    end

    Vote.transaction do
      existing_vote.destroy!
      Vote.create!(team: team, voter_hash: voter_hash)
    end

    result(
      status: :ok,
      message: "Vote changed to #{team.name}.",
      already_voted: false,
      voted_team_id: team.id
    )
  end

  private

  def find_team(team_name)
    Team.find_by("lower(name) = ?", team_name.to_s.downcase)
  end

  def hash_voter(voter_id)
    Digest::SHA256.hexdigest(voter_id.to_s)
  end

  def result(status:, message:, already_voted: false, voted_team_id: nil)
    teams = Team.order(Arel.sql("CASE name WHEN 'Seahawks' THEN 1 WHEN 'Patriots' THEN 2 ELSE 3 END")).map do |team|
      {
        name: team.name,
        votes: team.votes_count,
        percent: percent(team.votes_count, total_votes)
      }
    end

    Result.new(
      status: status,
      message: message,
      teams: teams,
      total_votes: total_votes,
      already_voted: already_voted,
      voted_team_id: voted_team_id
    )
  end

  def total_votes
    Team.sum(:votes_count)
  end

  def percent(votes, total)
    return 0.0 if total.to_i.zero?

    ((votes.to_f / total) * 100).round(1)
  end
end
