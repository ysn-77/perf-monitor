class AddClonedFromToPerformanceTest < ActiveRecord::Migration[6.0]
  def change
    add_column :performance_tests, :original_test_id, :bigint
  end
end
