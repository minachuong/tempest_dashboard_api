class CreateMetricEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :metric_events do |t|
      t.datetime :time, :null => false
      t.string :event_type, :null => false
      t.integer :user_id, :null => false
      t.float :revenue, :null => false

      t.timestamps
    end
  end
end
