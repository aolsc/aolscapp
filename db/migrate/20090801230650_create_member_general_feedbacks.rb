class CreateMemberGeneralFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :member_general_feedbacks do |t|
      t.integer :member_id
      t.string :feedback
      t.date :feedback_date
      t.string :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :member_general_feedbacks
  end
end
