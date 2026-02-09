class CreateVotes < ActiveRecord::Migration[7.2]
  def change
    create_table :votes do |t|
      t.references :team, null: false, foreign_key: true
      t.string :voter_hash, null: false

      t.timestamps
    end

    add_index :votes, :voter_hash, unique: true
  end
end
