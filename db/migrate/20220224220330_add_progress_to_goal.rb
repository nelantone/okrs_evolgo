class AddProgressToGoal < ActiveRecord::Migration[6.1]
  def change
    add_column :goals, :progress, :string, :default => '0 %'
  end
end
