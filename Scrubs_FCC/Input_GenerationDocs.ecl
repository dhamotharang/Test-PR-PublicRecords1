﻿Generated by SALT V3.11.9
Command line options: -MScrubs_FCC -eC:\Users\granjo01\AppData\Local\Temp\TFR2CE.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_FCC
FILENAME:FCC
NAMESCOPE:Input
 
FIELDTYPE:Invalid_No:ALLOW(0123456789 )
FIELDTYPE:Invalid_Float:ALLOW(0123456789 .-/)
FIELDTYPE:Invalid_Alpha:ALLOW(AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz )
FIELDTYPE:Invalid_AlphaChar:ALLOW(AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz .,-'&)
FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz )
FIELDTYPE:Invalid_AlphaNumChar:ALLOW(0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz _.,:;'#/-&\(\))
FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)
FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9,10)
FIELDTYPE:Invalid_Phone:LIKE(Invalid_Float):LENGTHS(0,9,10)
FIELDTYPE:Invalid_Date:CUSTOM(fn_valid_Date > 0)
FIELDTYPE:Invalid_Future:CUSTOM(fn_valid_Date > 0, 'Future')
 
FIELD:license_type:TYPE(STRING3):LIKE(Invalid_AlphaNum):0,0
FIELD:file_number:TYPE(STRING15):LIKE(Invalid_AlphaNum):0,0
FIELD:callsign_of_license:TYPE(STRING10):LIKE(Invalid_AlphaNum):0,0
FIELD:radio_service_code:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:licensees_name:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0
FIELD:licensees_attention_line:TYPE(STRING35):LIKE(Invalid_AlphaChar):0,0
FIELD:dba_name:TYPE(STRING40):LIKE(Invalid_AlphaNumChar):0,0
FIELD:licensees_street:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0
FIELD:licensees_city:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0
FIELD:licensees_state:TYPE(STRING2):LIKE(Invalid_State):0,0
FIELD:licensees_zip:TYPE(STRING9):LIKE(Invalid_Zip):0,0
FIELD:licensees_phone:TYPE(STRING10):LIKE(Invalid_Phone):0,0
FIELD:date_application_received_at_fcc:TYPE(STRING10):LIKE(Invalid_Date):0,0
FIELD:date_license_issued:TYPE(STRING10):LIKE(Invalid_Date):0,0
FIELD:date_license_expires:TYPE(STRING10):LIKE(Invalid_Future):0,0
FIELD:date_of_last_change:TYPE(STRING10):LIKE(Invalid_Date):0,0
FIELD:type_of_last_change:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:latitude:TYPE(STRING6):LIKE(Invalid_Float):0,0
FIELD:longitude:TYPE(STRING7):LIKE(Invalid_Float):0,0
FIELD:transmitters_street:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0
FIELD:transmitters_city:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0
FIELD:transmitters_county:TYPE(STRING30):LIKE(Invalid_AlphaChar):0,0
FIELD:transmitters_state:TYPE(STRING2):LIKE(Invalid_State):0,0
FIELD:transmitters_antenna_height:TYPE(STRING8):LIKE(Invalid_Float):0,0
FIELD:transmitters_height_above_avg_terra:TYPE(STRING8):LIKE(Invalid_Float):0,0
FIELD:transmitters_height_above_ground_le:TYPE(STRING8):LIKE(Invalid_Float):0,0
FIELD:power_of_this_frequency:TYPE(STRING9):LIKE(Invalid_Float):0,0
FIELD:frequency_mhz:TYPE(STRING17):LIKE(Invalid_Float):0,0
FIELD:class_of_station:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0
FIELD:number_of_units_authorized_on_freq:TYPE(STRING9):LIKE(Invalid_No):0,0
FIELD:effective_radiated_power:TYPE(STRING9):LIKE(Invalid_Float):0,0
FIELD:emissions_codes:TYPE(STRING45):LIKE(Invalid_AlphaNum):0,0
FIELD:frequency_coordination_number:TYPE(STRING30):LIKE(Invalid_AlphaNumChar):0,0
FIELD:paging_license_status:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:control_point_for_the_system:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0
FIELD:pending_or_granted:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:firm_preparing_application:TYPE(STRING40):LIKE(Invalid_AlphaChar):0,0
FIELD:contact_firms_street_address:TYPE(STRING40):LIKE(Invalid_AlphaNumChar):0,0
FIELD:contact_firms_city:TYPE(STRING40):LIKE(Invalid_Alpha):0,0
FIELD:contact_firms_state:TYPE(STRING2):LIKE(Invalid_State):0,0
FIELD:contact_firms_zipcode:TYPE(STRING9):LIKE(Invalid_Zip):0,0
FIELD:contact_firms_phone_number:TYPE(STRING10):LIKE(Invalid_Phone):0,0
FIELD:contact_firms_fax_number:TYPE(STRING10):LIKE(Invalid_Phone):0,0
FIELD:unique_key:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0
FIELD:crlf:TYPE(STRING2):0,0
 
Total available specificity:0
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
 
