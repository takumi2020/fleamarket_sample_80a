class RemoveBirthDayFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :birth_date, :date
  end
end
