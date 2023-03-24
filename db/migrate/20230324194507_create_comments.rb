class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :event_id
      t.text :description
      t.integer :author_id
      t.integer :status_id
      t.timestamps
    end
  end
end
