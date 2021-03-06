class Api::InvitationsController < Api::ApiController
  # TODO: secure this with API keys or something
  skip_before_filter :authenticate_user! #, :only => [ :create ]
  prepend_before_filter :determine_source
  before_filter :normalize_params, :only => [ :create, :update ]
  
  make_resourceful do
    actions :create, :show    
  end
  
  protected
  
    def current_object
      @current_object ||= current_model.find_by_code(params[:id].to_s.downcase)
    end
    
    def normalize_params
      case @source
      when :infusion_soft
        # translate infusion params to rails
        event_type_id = nil
        event_type = nil
        event_type = EventType.find(:first, :conditions => {:name => params["EventType"]}) unless params["EventType"].nil? || params["EventType"].blank?
        event_type_id = event_type.id unless event_type.nil?
        params[:invitation] = {
          :email      => params[:Email],
          :first_name => params[:FirstName],
          :last_name  => params[:LastName],
          :event_type_id => event_type_id
        }
      else
        # assume rails-style params and do nothing
      end
    end
end

=begin
Processing Api::InvitationsController#create (for 208.76.24.4 at 2011-01-25 14:23:42) [POST]
  Parameters: {
    "Signature"=>"NSM Error getting value: com.infusion.crm.modules.contact.Contact.getSignature()", 
    "Groups"=>"155,145", 
    "StreetAddress1"=>"133 Sweet Bay St.", 
    "City"=>"Davenport", 
    "LastName"=>"Cartwright", 
    "OwnerID"=>"0", 
    "HTMLSignature"=>"NSM Error getting value: com.infusion.crm.modules.contact.Contact.getHTMLSignature()", 
    "DateCreated"=>"2011-01-25 17:23:41.0", 
    "Country"=>"United States", 
    "PostalCode"=>"33837", 
    "Id"=>"1448", 
    "State2"=>"FL", 
    "FirstName"=>"Jason", 
    "Address2Street1"=>"133 Sweet Bay St.", 
    "Country2"=>"United States", 
    "PostalCode2"=>"33837", 
    "CompanyID"=>"0", 
    "Phone1"=>"(863) 438-1844", 
    "City2"=>"Davenport", 
    "LastUpdated"=>"2011-01-25 17:23:41.0", 
    "Email"=>"jason@myopt.info", 
    "State"=>"FL", 
    "CreatedBy"=>"5", 
    "LastUpdatedBy"=>"5"
  }
=end