class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :votes_count, null: false, default: 0

      t.timestamps
    end

    add_index :teams, :name, unique: true
  end
end
