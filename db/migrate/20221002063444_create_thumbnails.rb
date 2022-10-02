class CreateThumbnails < ActiveRecord::Migration[5.2]
  def change
    create_table :thumbnails do |t|
      t.integer :video_id
      t.string :size
      t.string :url
      t.timestamps
    end
  end
end
