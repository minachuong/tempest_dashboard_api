class CreateMetricEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :metric_events do |t|
      t.datetime :time
      t.string :event_type
      t.integer :user_id
      t.float :revenue

      t.timestamps
    end
  end
end
