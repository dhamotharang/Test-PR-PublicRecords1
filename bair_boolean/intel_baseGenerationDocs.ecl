Generated by SALT V3.0 Gold
File being processed :-
OPTIONS:-bh
MODULE:bair_boolean.intel_base
FILENAME:intel_base
RIDFIELD:newrid:GENERATE
DOCFIELD:eid:HASH5
IDNAME:newrid
IDSPACE:MDR.sourceTools.src_Bair_Analytics
FIELD:eid:0,0
FIELD:gh12:0,0
FIELD:etype:0,0
FIELD:id:0,0
FIELD:incident_id:0,0
FIELD:name_type:0,0
DATEFIELD:clean_incident_date:0,0
NUMBERFIELD:incident_time:0,0
FIELD:case_number:0,0
FIELD:call_case_number:0,0
FIELD:incident_address:0,0
FIELD:incident_city:0,0
FIELD:incident_state:0,0
FIELD:incident_zip:0,0
FIELD:address_name:0,0
FIELD:location_type:0,0
FIELD:source_reliability:0,0
FIELD:incident_content_validity:0,0
NUMBERFIELD:incident_source_score:0,0
DATEFIELD:clean_incident_entry_date:0,0
DATEFIELD:clean_incident_purge_date:0,0
FIELD:reporting_officer_first_name:0,0
FIELD:reporting_officer_last_name:0,0
FIELD:first_name:0,0
FIELD:middle_name:0,0
FIELD:last_name:0,0
FIELD:moniker:0,0
FIELD:ssn:0,0
DATEFIELD:clean_dob:0,0
FIELD:sex:0,0
FIELD:race:0,0
FIELD:ethnicity:0,0
FIELD:country_of_origin:0,0
NUMBERFIELD:height:0,0
NUMBERFIELD:weight:0,0
FIELD:eye_color:0,0
FIELD:hair_color:0,0
FIELD:hair_style:0,0
FIELD:facial_hair:0,0
FIELD:tattoo_text_1:0,0
FIELD:tattoo_location_1:0,0
FIELD:tattoo_text_2:0,0
FIELD:tattoo_location_2:0,0
FIELD:occupation:0,0
FIELD:place_of_employment:0,0
FIELD:entity_address:0,0
FIELD:entity_city:0,0
FIELD:entity_state:0,0
FIELD:entity_zip:0,0
NUMBERFIELD:person_x:0,0
NUMBERFIELD:person_y:0,0
FIELD:phone_number:0,0
FIELD:phone_type:0,0
FIELD:email_address:0,0
FIELD:social_media_type_1:0,0
FIELD:user_name_site_1:0,0
FIELD:social_media_type_2:0,0
FIELD:user_name_site_2:0,0
FIELD:social_media_type_3:0,0
FIELD:user_name_site_3:0,0
FIELD:social_media_type_4:0,0
FIELD:user_name_site_4:0,0
FIELD:organization_type:0,0
FIELD:organization_sub_type:0,0
FIELD:organization_name:0,0
FIELD:number_of_members:0,0
FIELD:organization_rank_role:0,0
FIELD:entity_source_type:0,0
FIELD:source_relaiability:0,0
FIELD:entity_content_validity:0,0
NUMBERFIELD:entity_source_score:0,0
DATEFIELD:clean_entity_entry_date:0,0
DATEFIELD:clean_entity_purge_date:0,0
FIELD:vehicle_type:0,0
FIELD:vehicle_make:0,0
FIELD:vehicle_model:0,0
FIELD:vehicle_color:0,0
FIELD:vehicle_year:0,0
FIELD:vehicle_plate:0,0
FIELD:vehicle_plate_state:0,0
FIELD:entity_notes:0,0
FIELD:incident_notes:0,0
FIELD:vehicle_notes:0,0
CONCEPT:NOTES:entity_notes:incident_notes:vehicle_notes:SEGTYPE(GroupSeg):1,0
CONCEPT:DATE:clean_incident_date:SEGTYPE(GroupSeg):1,0
 
Total available specificity:2
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
 
