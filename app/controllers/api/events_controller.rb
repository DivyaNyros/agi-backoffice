class Api::EventsController < Api::ApiController
  # TODO: secure this with API keys or something
  skip_before_filter :authenticate_user!
  
  make_resourceful do
    actions :index, :show

    response_for :index do |format|
      format.xml { render :xml => current_objects.to_xml }
      format.json { render :json => current_objects.to_json }
      format.html { }
    end

    response_for :show do |format|
      format.xml { 
        event_xml = current_object.to_xml do |xml|
          current_object.addresses.first.to_xml(:builder => xml, :skip_instruct => true)
        end
        
        render :xml => event_xml
      }
      format.json { render :json => current_object.to_json(:methods => :address) }
      format.html { }
    end
  end

  def registration_events
    events = []
    
    unless params[:invite_code].blank?
      invite = Invitation.find(:first, :conditions => ["code = ? AND accepted = ?", params[:invite_code], false])

      unless invite.nil?
        events = Event.type(invite.event_type_id).public.published.upcoming
      end
    end

    respond_to do |format|
      format.xml { render :xml => events.to_xml(:include => :address) }
      format.json { render :json => events.to_json }
      format.html
    end
  end
  
  def map
    respond_to do |format|
      format.xml { }
    end
  end
  
  def in
    respond_to do |format|
      format.xml { render :xml => current_objects.to_xml(:include => :address) }
      format.json { render :json => current_objects.to_json }
      format.html
    end
  end
  
  def current_objects
    if params[:state].blank?
      if params[:event_type_id].blank?
        @current_objects ||= current_model.published.upcoming
      else
        @current_objects ||= current_model.type(params[:event_type_id]).published.upcoming
      end
    else
      if params[:event_type_id].blank?
        @current_objects ||= current_model.published.in_state(params[:state]).upcoming
      else
        @current_objects ||= current_model.type(params[:event_type_id]).published.in_state(params[:state]).upcoming
      end
    end
  end
end
