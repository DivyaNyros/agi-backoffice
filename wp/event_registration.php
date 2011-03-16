<?php /* Template Name: EventRegistration
 */ ?>
<?php
header("Cache-Control: no-cache, no-store");
get_header();
?>
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery.validate/1.5.5/jquery.validate.min.js"></script>
<script type="text/javascript">
  jQuery(document).ready(function(){
    jQuery("#eventRegistrationForm").validate();
  });

  jQuery.extend(jQuery.validator.messages, {
    required: "&laquo;",
    email: "&laquo; Invalid Email",
    digits: "&laquo; Numbers Only",
  });
</script>

<style type="text/css">
  h4 {
    margin: 0.5em 0em;
  }
  
  label {
    clear: left;
    display: block;
    float: left;
    width: 12em;
    font-weight: bold;
  }

  select.textInput {
    width: auto;
    padding: 4px;
  }

  #registration_section,
	#event_details {
    padding: 10px;
    width: 45%;
		float: left;
  }
	
	#event_details {
		padding-left: 20px;
	}
	
	#event_details table tr {
		height: 30px;
	}
	
	#event_details table tr td {
		font-size: 1em;
	}
	
	#event_details table tr td.label {
	  white-space: nowrap;
	  width: 25%;
	}
	
	#register_now {
		font-size: 2em;
		font-weight: bold;
		margin: 0em 0em 1em 0em;
	}
</style>

<?php
	$sources_url = "http://agi-backoffice.heroku.com/api/sources.json";
	$content = file_get_contents($sources_url);
	$sources_array = json_decode($content);
	$sources = array();
	
	foreach ($sources_array as $index => $source) {
		$sources[$source->source->id] = $source->source->name;
	}
	
	$event_url = "http://agi-backoffice.heroku.com/api/events/".$_GET["event_id"].".xml";
	$event = @simplexml_load_file($event_url);

	if (!$event || $event->private == "true") {
		echo "<script type='text/javascript'>location.href='". get_bloginfo("url"). "/live-events'</script>";
		
		return;
	}
?>
<div id="event_details">
	<table align="center" style="width: 80%;">
		<tr>
			<td colspan="2">
				<h3><?php echo $event->name; ?></h3>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<h4>Time &amp; Place:</h4>
			</td>
		</tr>
    <tr>
			<td class="label">
				<strong>Start time</strong>
			</td>
			<td>
				<?php echo date("F d, Y", strtotime($event->start_date))." at ".date("h:i a", strtotime($event->start_time)); ?>
			</td>
		</tr>
		<tr>
			<td class="label">
				<strong>End time</strong>
			</td>
			<td>
				<?php echo date("F d, Y", strtotime($event->end_date))." at ".date("h:i a", strtotime($event->end_time)); ?>
			</td>
		</tr>
		<tr>
			<td class="label">
				<strong>Location</strong>
			</td>
			<td>
				<?php echo trim($event->location) ? trim($event->location)."<br />" : ""; ?>
				<?php  
					$address = $event->street;
					
					if (trim($event->unit)) {
					  $address .= ", ".$event->unit;
				  }
					
					if (trim($event->city)) {
						$address .= "<br />".$event->city;
					}
					
					if (trim($event->state)) {
						$address .= ", ".$event->state;
					}
					
					if (trim($event->zip)) {
						$address .= " ".$event->zip;
					}
					
					if (strpos(trim($address), ",") === 0) {
						$address = substr(trim($address), 2);
					}
				?>
				<span><?php echo $address; ?></span>
			</td>
		</tr>
		<?php if (trim($event->website)) { ?>
			<tr>
				<td class="label">
					<strong>Website</strong>
				</td>
				<td>
					<a href="http://<?php echo $event->website; ?>" target="_blank"><?php echo $event->website; ?></a>
				</td>
			</tr>
		<?php } ?>
		
		<?php if (trim($event->phone)) { ?>
			<tr>
				<td class="label">
					<strong>Phone</strong>
				</td>
				<td>
					<?php echo $event->phone; ?>
				</td>
			</tr>
		<?php } ?>
		
		<?php if (trim($event->description)) { ?>
			<tr>
				<td colspan="2">
					<h4>Description</h4>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<?php echo $event->description; ?>
				</td>
			</tr>
		<?php } ?>
		
		<?php if (trim($event->instructions)) { ?>
			<tr>
				<td colspan="2">
					<h4>Instructions</h4>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<?php echo $event->instructions; ?>
				</td>
			</tr>
		<?php } ?>
	</table>
</div>
<div id="registration_section">
<div id="register_now">Register Now</div>
<table align="center" class="style38" style="width: 99%;">
  <tbody><tr>
      <td>
        <form id="eventRegistrationForm" method="post" action="http://eventregistration.theinnovativeinvestors.com/api/attendees">
          <input type="hidden" value="http://www.theinnovativeinvestors.com/thankyou" name="redirect_url">

          <p>
            <label>First Name</label>
            <input type="text" class="required textInput" name="attendee[first_name]">
          </p>

          <p>
            <label>Last Name</label>
            <input type="text" class="required textInput" name="attendee[last_name]">
          </p>

          <p>
            <label>Email</label>
            <input type="text" class="required email textInput" name="attendee[email]">
          </p>

          <p>
            <label>Phone</label>
            <input type="text" class="textInput" size="14" name="attendee[phone_numbers_attributes][0][data]">
            <select name="attendee[phone_numbers_attributes][0][category]" class="textInput">
              <option value="work">work</option>
              <option value="home">home</option>
              <option value="mobile">mobile</option>
            </select>
          </p>

          <p>
            <label>How did you find us?</label>
            <select name="source[id]" class="textInput">
              <option value=""></option>
							<?php foreach ($sources as $id => $name) { ?>
								<option value="<?php echo $id; ?>"><?php echo $name; ?></option>
							<?php } ?>
            </select>
          </p>

          <p class="submit">
            <label>&nbsp;</label>
            <input type="hidden" name="event[id]" value="<?php echo $_GET["event_id"]; ?>"/>
            <input type="submit" class="btn" value="Register" />
          </p>
        </form>
      </td>
    </tr>
  </tbody></table>
</div>
<?php get_footer(); ?>
