class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :destination
      t.string :start_date
      t.string :end_date
      t.text :trip_summary 
      t.references :user, foreign_key: {on_delete: :cascade} 
    end 
  end
end
