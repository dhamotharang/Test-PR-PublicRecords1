﻿Generated by SALT V3.11.4
Command line options: -MScrubs_Cortera -eC:\Users\oneillbw\AppData\Local\Temp\TFR9D2D.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Cortera
FILENAME:Cortera
NAMESCOPE:Header
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
FIELDTYPE:alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0)
FIELDTYPE:feintype:ALLOW(0123456789):LENGTHS(0,9)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.functions.fn_valid_date>0,'future')
FIELDTYPE:OwnershipTypes:ENUM(P|V| )
FIELDTYPE:StatusTypes:ENUM(A|D| )
FIELDTYPE:YesNo:ENUM(Y|N| )
FIELDTYPE:CorpHierarchy:ENUM(S|B|H| )
FIELDTYPE:StateAbrv:CUSTOM(Scrubs.functions.fn_alpha_optional>0,2)
FIELDTYPE:Numeric:CUSTOM(Scrubs.functions.fn_numeric>0)
FIELDTYPE:Invalid_LatLong:CUSTOM(Scrubs.functions.fn_geo_coord>0)
FIELDTYPE:invalid_sic:CUSTOM(Scrubs.fn_valid_SicCode> 0)
FIELDTYPE:invalid_naics:CUSTOM(Scrubs.fn_valid_NAICSCode > 0)
FIELD:link_id:LIKE(Numeric):0,0
FIELD:name:0,0
FIELD:alternate_business_name:0,0
FIELD:address:0,0
FIELD:address2:0,0
FIELD:city:0,0
FIELD:state:0,0
FIELD:country:LIKE(StateAbrv):0,0
FIELD:postalcode:0,0
FIELD:phone:0,0
FIELD:fax:0,0
FIELD:latitude:LIKE(Invalid_LatLong):0,0
FIELD:longitude:LIKE(Invalid_LatLong):0,0
FIELD:url:0,0
FIELD:fein:LIKE(feintype):0,0
FIELD:position_type:LIKE(CorpHierarchy):0,0
FIELD:ultimate_linkid:LIKE(Numeric):0,0
FIELD:ultimate_name:0,0
FIELD:loc_date_last_seen:LIKE(Invalid_Date):0,0
FIELD:primary_sic:LIKE(invalid_sic):0,0
FIELD:sic_desc:0,0
FIELD:primary_naics:LIKE(invalid_naics):0,0
FIELD:naics_desc:0,0
FIELD:segment_id:0,0
FIELD:segment_desc:0,0
FIELD:year_start:0,0
FIELD:ownership:LIKE(OwnershipTypes):0,0
FIELD:total_employees:0,0
FIELD:employee_range:0,0
FIELD:total_sales:0,0
FIELD:sales_range:0,0
FIELD:executive_name1:LIKE(alpha):0,0
FIELD:title1:LIKE(alpha):0,0
FIELD:executive_name2:LIKE(alpha):0,0
FIELD:title2:LIKE(alpha):0,0
FIELD:executive_name3:LIKE(alpha):0,0
FIELD:title3:LIKE(alpha):0,0
FIELD:executive_name4:LIKE(alpha):0,0
FIELD:title4:LIKE(alpha):0,0
FIELD:executive_name5:LIKE(alpha):0,0
FIELD:title5:LIKE(alpha):0,0
FIELD:executive_name6:LIKE(alpha):0,0
FIELD:title6:LIKE(alpha):0,0
FIELD:executive_name7:LIKE(alpha):0,0
FIELD:title7:LIKE(alpha):0,0
FIELD:executive_name8:LIKE(alpha):0,0
FIELD:title8:LIKE(alpha):0,0
FIELD:executive_name9:LIKE(alpha):0,0
FIELD:title9:LIKE(alpha):0,0
FIELD:executive_name10:LIKE(alpha):0,0
FIELD:title10:LIKE(alpha):0,0
FIELD:status:LIKE(StatusTypes):0,0
FIELD:is_closed:LIKE(YesNo):0,0
FIELD:closed_date:0,0
 
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
 
