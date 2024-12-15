class CreateScoringRules < ActiveRecord::Migration[7.1]
  def change
    create_table :scoring_rules do |t|
      t.integer :age_min
      t.integer :age_max
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.integer :threshold

      t.timestamps
    end
  end
end
