class CreateKeyResults < ActiveRecord::Migration[6.1]
  def change
    create_table :key_results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true
      t.string :title
      t.float :status, :default => 0

      t.timestamps
    end
  end
end
