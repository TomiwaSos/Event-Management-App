class AddResolvedToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :resolved, :boolean, default: false
  end
end
