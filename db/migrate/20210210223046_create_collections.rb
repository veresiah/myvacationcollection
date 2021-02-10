class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :destination
      t.string :start_date
      t.string :end_date
      t.text :trip_summary 
    end 
  end
end
