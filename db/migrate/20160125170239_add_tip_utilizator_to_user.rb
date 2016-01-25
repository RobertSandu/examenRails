class AddTipUtilizatorToUser < ActiveRecord::Migration
  def change
    add_column :users, :tip_utilizator, :integer
  end
end
