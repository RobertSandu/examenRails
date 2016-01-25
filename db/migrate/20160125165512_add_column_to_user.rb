class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :zile_concediu, :integer, :default => 20
  end
end
