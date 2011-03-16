<?php /* Template Name: StateEvents
*/ ?>
<?php 
header("Cache-Control: no-cache, no-store");
get_header(); 
?>
<style type="text/css">
	#flashmap {
		text-align: center;
	}
  
  .spacer {
    height: 1em;
  }
  
	.event {
		padding: 10px;
	}

	.event  span{
		font-weight: bold;
	}

	.event ul li {
		list-style: none;
	}
	
	#events table.events-wrapper tr td.event {
	  padding: 0.5em 10em;
	}
	
	#events table tr td {
	  padding: 0.5em 2em;
	}
	
	#events table tr td.name {
		color: #FFFFFF;
		background: #333333;
		vertical-align: middle;
		padding: 10px 10px 10px 5px;
	}
	
	#events table tr td.register-now {
		color: #FFFFFF;
		text-align: right;
		background: #333333;
		vertical-align: middle;
		padding: 10px 10px 10px 5px;
	}
	
	#events table tr td.register-now span {
	}
	
	#events table tr td.register-now span a {
		color: yellow;
	}
	
	#events table tr td.location {
	  width: 55%;
	}
	
	#events table tr td.datetime {
	  width: 45%;
	}

	.events-wrapper table.event {
		background: #FFFFFF;
		width: 100%;
	}
</style>
<div id="flashmap">
  <embed width="530" 
         height="410"
         flashvars="xmlfile1=<?php echo bloginfo("url")."/getmapxml"; ?>"
         quality="high"
         bgcolor="#ffffff"
         name="sotester"
         id="sotester"
         src="<?php bloginfo('template_directory'); ?>/map/usa_locator.swf"
         type="application/x-shockwave-flash">
</div>
<div id="events">
  <table class="events-wrapper">
    <?php
    if ($_GET["state"]) {
      $feedURL = "http://eventregistration.theinnovativeinvestors.com/api/events/in/".$_GET["state"].".xml";
      $sxml = simplexml_load_file($feedURL);
  		$index = 0;
		
      foreach ($sxml->event as $event) {
  	  $index++;
        $event_attributes = get_object_vars($event);
        $name = stripslashes($event->name);
        $location = stripslashes($event->location);
        $startDate = stripslashes($event_attributes["start-date"]);
        $startTime = stripslashes($event_attributes["start-time"]);
        $endDate = stripslashes($event_attributes["end-date"]);
        $endTime = stripslashes($event_attributes["end-time"]);
        $state = stripslashes($event->state);
        $instructions = stripslashes($event->instructions);
        $description = stripslashes($event->description);
        $eventAddress = $event->address;
        ?>
    <tr>
      <td class="event">
        <table class="box1 event">
        <tr>
        		<td class="name">
          		<span>Event:</span> <strong><?php echo $name; ?></strong><br/>
        		</td>
        		<td class="register-now">
        			<?php if ($event->private === false || $event->private == "false") { ?>
        				<span><a href="<?php echo bloginfo("url")."/event-registration/?event_id=".$event->id; ?>">
        				  <img src="<?php bloginfo('template_directory'); ?>/images/registerbutton.png" alt="Register Now" width="150px" />
        				</a></span>
        			<?php } else { ?>
        				<span>Call Now: 1-888-551-7982</span>
        			<?php } ?>
        		</td>
        </tr>
        <tr>
        		<td class="location">
          		<span>Location:</span> <?php echo $location; ?><br/>
          		<?php  
      					if (isset($eventAddress)) {
        					$address = $eventAddress->street;

        					if (trim($eventAddress->unit)) {
        					  $address .= ", ".$eventAddress->unit;
        				  }

        					if (trim($eventAddress->city)) {
        						$address .= "<br />".$eventAddress->city;
        					}

        					if (trim($eventAddress->state)) {
        						$address .= ", ".$eventAddress->state;
        					}

        					if (trim($eventAddress->zip)) {
        						$address .= " ".$eventAddress->zip;
        					}

        					if (strpos(trim($address), ",") === 0) {
        						$address = substr(trim($address), 2);
        					}
      					}
      					else {
      					  $address = "";
      					}
      				?>
      				<span><?php echo $address; ?></span>
        		</td>
        		<td class="datetime">
          		<span>Start time:</span> <?php echo date("F d, Y", strtotime($startDate))." at ".date("h:i a", strtotime($startTime)); ?><br/>
          		<span>End time:</span> <?php echo date("F d, Y", strtotime($endDate))." at ".date("h:i a", strtotime($endTime)); ?><br/>
        		</td>
        </tr>
        <tr>
        	<td colspan="2" class="description">
        	<span>Description:</span> <?php echo $description; ?>
        	</td>
        </tr>
        </table>
      </td>
    </tr>
      <?php
    }
  }
  ?>
  </table>
</div>
<?php get_footer();	?>
