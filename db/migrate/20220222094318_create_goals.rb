class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
