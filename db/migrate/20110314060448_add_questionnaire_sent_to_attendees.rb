class AddQuestionnaireSentToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :questionnaire_sent, :boolean
  end

  def self.down
    remove_column :attendees, :questionnaire_sent
  end
end
