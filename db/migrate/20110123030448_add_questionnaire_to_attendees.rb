class AddQuestionnaireToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :questionnaire, :string, :limit => 8192
  end

  def self.down
    remove_column :attendees, :questionnaire
  end
end
