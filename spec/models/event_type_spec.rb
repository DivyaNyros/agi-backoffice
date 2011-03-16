require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventType do
  describe 'Create event type' do
    it "should increate #event type by 1" do
      count = EventType.count
      create_event_type
      EventType.count.should == count + 1
    end

    it "should faile if name is nil" do
      event_type = create_event_type({:name => nil})
      event_type.errors.length.should >= 1
      event_type.errors.on(:name).should be_true
    end
  end

  protected
  def create_event_type(options = {})
    record = EventType.new({:name => "name", :description => "Description"}.merge(options))
    record.save if record.valid?

    return record
  end
end
