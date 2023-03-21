class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :status_id
      t.datetime :resolved_at
      t.integer :resolved_by
      t.boolean :resolved
      t.integer :created_by
      t.boolean :active
      t.datetime :active_from
      t.datetime :active_to

      t.timestamps
    end
  end
end
