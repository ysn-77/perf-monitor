class CreatePerformanceTests < ActiveRecord::Migration[6.0]
  def change
    create_table :performance_tests do |t|
      t.string :url, limit: 2083, null: false
      
      t.integer :max_ttfb, null: false
      t.integer :max_tti, null: false
      t.integer :max_speed_index, null: false
      t.integer :max_ttfp, null: false
      
      t.integer :ttfb, null: false
      t.integer :tti, null: false
      t.integer :speed_index, null: false
      t.integer :ttfp, null: false

      t.boolean :passed, null: false

      t.datetime :created_at, null: false
    end
  end
end
