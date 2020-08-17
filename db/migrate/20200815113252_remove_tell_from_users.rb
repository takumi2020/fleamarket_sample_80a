class RemoveTellFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :tell, :string
  end
end
