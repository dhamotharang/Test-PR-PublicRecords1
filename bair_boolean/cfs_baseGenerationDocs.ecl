Generated by SALT V3.0 Gold
File being processed :-
OPTIONS:-bh
MODULE:bair_boolean.cfs_base
FILENAME:cfs_base
RIDFIELD:newrid:GENERATE
DOCFIELD:eid:HASH5
IDNAME:newrid
IDSPACE:MDR.sourceTools.src_Bair_Analytics
FIELD:eid:0,0
FIELD:gh12:0,0
FIELD:etype:0,0
FIELD:cfs_id:0,0
FIELD:ori:0,0
FIELD:event_number:0,0
FIELD:caller_address:0,0
FIELD:address:0,0
FIELD:place_name:0,0
FIELD:location_type:0,0
FIELD:district:0,0
FIELD:beat:0,0
FIELD:rd:0,0
FIELD:how_received:0,0
FIELD:initial_type:0,0
FIELD:final_type:0,0
FIELD:incident_code:0,0
FIELD:incident_progress:0,0
FIELD:city:0,0
FIELD:call_taker:0,0
FIELD:contacting_officer:0,0
FIELD:complainant:0,0
FIELD:status:0,0
FIELD:apartment_number:0,0
NUMBERFIELD:total_minutes_on_call:1,0
NUMBERFIELD:x_coordinate:1,0
NUMBERFIELD:y_coordinate:1,0
FIELD:geocoded:0,0
FIELD:accuracy:0,0
NUMBERFIELD:complainant_x_coordinate:1,0
NUMBERFIELD:complainant_y_coordinate:1,0
FIELD:initial_ucr_group:0,0
FIELD:final_ucr_group:0,0
FIELD:cfs_officers_id:0,0
NUMBERFIELD:minutes_on_call:1,0
NUMBERFIELD:minutes_response:1,0
FIELD:unit:0,0
FIELD:officer_name:0,0
FIELD:primary_officer:0,0
FIELD:dispatcher_comments:0,0
FIELD:synopsis:0,0
//Note, we need to use the cleaned version of the date fields which donÃ¢â‚¬â„¢t contain the time.
DATEFIELD:clean_date_time_received:1,0
DATEFIELD:clean_date_time_archived:1,0
DATEFIELD:clean_date_time_dispatched:1,0
DATEFIELD:clean_date_time_enroute:1,0
DATEFIELD:clean_date_time_arrived:1,0
DATEFIELD:clean_date_time_cleared:1,0
//CONCEPT:NON_NOTES:eid:cfs_id:ori:event_number:caller_address:address:place_name:location_type:district:beat:rd:how_received:initial_type:final_type:incident_code:incident_progress:city:call_taker:contacting_officer:complainant:status:apartment_number:total_minutes_on_call:x_coordinate:y_coordinate:geocoded:accuracy:complainant_x_coordinate:complainant_y_coordinate:initial_ucr_group:final_ucr_group:cfs_officers_id:minutes_on_call:minutes_response:unit:officer_name:primary_officer:clean_date_time_received:clean_date_time_archived:clean_date_time_dispatched:clean_date_time_enroute:clean_date_time_arrived:clean_date_time_cleared:SEGTYPE(GroupSeg):1,0
CONCEPT:NOTES:dispatcher_comments:synopsis:SEGTYPE(GroupSeg):1,0
CONCEPT:DATE:clean_date_time_received:SEGTYPE(GroupSeg):1,0
 
Total available specificity:15
Search Threshold set at -4
Use of PERSISTs in code set at:3
 
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
 
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
 
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
 
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
 
