﻿Generated by SALT V3.11.4
Command line options: -MScrubs_Cortera -eC:\Users\oneillbw\AppData\Local\Temp\TFR22E4.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Cortera
FILENAME:Cortera
NAMESCOPE:Executives
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
FIELDTYPE:Alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0)
FIELDTYPE:CorpHierarchy:ENUM(S|B|H| )
FIELDTYPE:Country:CUSTOM(Scrubs.functions.fn_Alpha_optional>0,2)
FIELDTYPE:Feintype:ALLOW(0123456789):LENGTHS(0,9)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.functions.fn_valid_date>0)
FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.functions.fn_valid_date>0,'future')
FIELDTYPE:Invalid_LatLong:CUSTOM(Scrubs.functions.fn_geo_coord>0)
FIELDTYPE:Invalid_Naics:CUSTOM(Scrubs.fn_valid_NAICSCode > 0)
FIELDTYPE:Invalid_Phone:CUSTOM(Scrubs.functions.fn_verify_optional_phone>0)
FIELDTYPE:Invalid_Sic:CUSTOM(Scrubs.fn_valid_SicCode> 0)
FIELDTYPE:Invalid_St:CUSTOM(Scrubs.functions.fn_valid_StateAbbrev>0)
FIELDTYPE:Numeric:CUSTOM(Scrubs.functions.fn_numeric>0)
FIELDTYPE:Numeric_Optional:ALLOW(0123456789)
FIELDTYPE:OwnershipTypes:ENUM(P|V| )
FIELDTYPE:StatusTypes:ENUM(A|D| )
FIELDTYPE:YesNo:ENUM(Y|N| )
 
FIELD:link_id:LIKE(Numeric):0,0
FIELD:name:0,0
FIELD:alternate_business_name:0,0
FIELD:address:0,0
FIELD:address2:0,0
FIELD:city:0,0
FIELD:state:LIKE(Invalid_St):0,0
FIELD:country:LIKE(Country):0,0
FIELD:postalcode:LIKE(Numeric_Optional):0,0
FIELD:phone:LIKE(Invalid_Phone):0,0
FIELD:fax:LIKE(Invalid_Phone):0,0
FIELD:latitude:LIKE(Invalid_LatLong):0,0
FIELD:longitude:LIKE(Invalid_LatLong):0,0
FIELD:url:0,0
FIELD:fein:LIKE(Feintype):0,0
FIELD:position_type:LIKE(CorpHierarchy):0,0
FIELD:ultimate_linkid:LIKE(Numeric_Optional):0,0
FIELD:ultimate_name:0,0
FIELD:loc_date_last_seen:LIKE(Invalid_Future_Date):0,0
FIELD:primary_sic:LIKE(Invalid_Sic):0,0
FIELD:sic_desc:0,0
FIELD:primary_naics:LIKE(Invalid_Naics):0,0
FIELD:naics_desc:0,0
FIELD:segment_id:0,0
FIELD:segment_desc:0,0
FIELD:year_start:0,0
FIELD:ownership:LIKE(OwnershipTypes):0,0
FIELD:total_employees:0,0
FIELD:employee_range:0,0
FIELD:total_sales:0,0
FIELD:sales_range:0,0
FIELD:executive_name1:LIKE(Alpha):0,0
FIELD:title1:LIKE(Alpha):0,0
FIELD:executive_name2:LIKE(Alpha):0,0
FIELD:title2:LIKE(Alpha):0,0
FIELD:executive_name3:LIKE(Alpha):0,0
FIELD:title3:LIKE(Alpha):0,0
FIELD:executive_name4:LIKE(Alpha):0,0
FIELD:title4:LIKE(Alpha):0,0
FIELD:executive_name5:LIKE(Alpha):0,0
FIELD:title5:LIKE(Alpha):0,0
FIELD:executive_name6:LIKE(Alpha):0,0
FIELD:title6:LIKE(Alpha):0,0
FIELD:executive_name7:LIKE(Alpha):0,0
FIELD:title7:LIKE(Alpha):0,0
FIELD:executive_name8:LIKE(Alpha):0,0
FIELD:title8:LIKE(Alpha):0,0
FIELD:executive_name9:LIKE(Alpha):0,0
FIELD:title9:LIKE(Alpha):0,0
FIELD:executive_name10:LIKE(Alpha):0,0
FIELD:title10:LIKE(Alpha):0,0
FIELD:status:LIKE(StatusTypes):0,0
FIELD:is_closed:LIKE(YesNo):0,0
FIELD:closed_date:0,0
FIELD:processdate:LIKE(Invalid_Date):0,0
FIELD:version:LIKE(Invalid_Date):0,0
FIELD:persistent_record_id:LIKE(Numeric):0,0
FIELD:dt_first_seen:LIKE(Invalid_Date):0,0
FIELD:dt_last_seen:LIKE(Invalid_Date):0,0
FIELD:dt_vendor_first_reported:LIKE(Invalid_Date):0,0
FIELD:dt_vendor_last_reported:LIKE(Invalid_Date):0,0
FIELD:prim_name:LIKE(Alpha):0,0
FIELD:p_city_name:LIKE(Alpha):0,0
FIELD:v_city_name:LIKE(Alpha):0,0
FIELD:executive_name:LIKE(Alpha):0,0
FIELD:exec_title:LIKE(Alpha):0,0
 
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
 
