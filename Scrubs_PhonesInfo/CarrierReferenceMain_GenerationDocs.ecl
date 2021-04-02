﻿Generated by SALT V3.11.11
Command line options: -MScrubs_PhonesInfo -eC:\Users\taojx\AppData\Local\Temp\TFR3D6B.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:CarrierReferenceMain
 
FIELDTYPE:Invalid_Alpha:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_AlphaNum:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:Invalid_Char:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&-/',.)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Email:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-@=.)
FIELDTYPE:Invalid_Flag:SPACES( ):ALLOW(1)
FIELDTYPE:Invalid_Indicator:SPACES( ):ALLOW(X)
FIELDTYPE:Invalid_Ocn_Name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(1..)
FIELDTYPE:Invalid_NotBlank:LENGTHS(1..)
FIELDTYPE:Invalid_Num:SPACES( ):ALLOW(0123456789)
FIELDTYPE:Invalid_SpecialChar:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:/@&#-,&.')
FIELDTYPE:Invalid_Type:ALLOW(0123):LENGTHS(1)
 
FIELD:dt_first_reported:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:dt_last_reported:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:dt_start:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:dt_end:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:ocn:LIKE(Invalid_Ocn_Name):TYPE(STRING8):0,0
FIELD:carrier_name:LIKE(Invalid_NotBlank):TYPE(STRING60):0,0
FIELD:serv:LIKE(Invalid_Type):TYPE(STRING1):0,0
FIELD:line:LIKE(Invalid_Type):TYPE(STRING1):0,0
FIELD:prepaid:LIKE(Invalid_Flag):TYPE(STRING2):0,0
FIELD:high_risk_indicator:LIKE(Invalid_Flag):TYPE(STRING2):0,0
FIELD:activation_dt:TYPE(UNSIGNED8):0,0
FIELD:number_in_service:TYPE(STRING5):0,0
FIELD:spid:LIKE(Invalid_Ocn_Name):TYPE(STRING10):0,0
FIELD:operator_full_name:LIKE(Invalid_NotBlank):TYPE(STRING60):0,0
FIELD:is_current:TYPE(BOOLEAN1):0,0
FIELD:override_file:LIKE(Invalid_Alpha):TYPE(STRING1):0,0
FIELD:data_type:LIKE(Invalid_Alpha):TYPE(STRING1):0,0
FIELD:ocn_state:LIKE(Invalid_Alpha):TYPE(STRING2):0,0
FIELD:overall_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0
FIELD:target_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0
FIELD:overall_target_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0
FIELD:ocn_abbr_name:TYPE(STRING25):0,0
FIELD:rural_lec_indicator:LIKE(Invalid_Indicator):TYPE(STRING1):0,0
FIELD:small_ilec_indicator:LIKE(Invalid_Indicator):TYPE(STRING1):0,0
FIELD:category:LIKE(Invalid_Alpha):TYPE(STRING10):0,0
FIELD:carrier_address1:TYPE(STRING30):0,0
FIELD:carrier_address2:TYPE(STRING30):0,0
FIELD:carrier_floor:TYPE(STRING15):0,0
FIELD:carrier_room:TYPE(STRING15):0,0
FIELD:carrier_city:LIKE(Invalid_Char):TYPE(STRING30):0,0
FIELD:carrier_state:LIKE(Invalid_Alpha):TYPE(STRING2):0,0
FIELD:carrier_zip:LIKE(Invalid_AlphaNum):TYPE(STRING9):0,0
FIELD:carrier_phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:affiliated_to:TYPE(STRING80):0,0
FIELD:overall_company:TYPE(STRING45):0,0
FIELD:contact_function:TYPE(STRING20):0,0
FIELD:contact_name:TYPE(STRING60):0,0
FIELD:contact_title:TYPE(STRING30):0,0
FIELD:contact_address1:TYPE(STRING30):0,0
FIELD:contact_address2:TYPE(STRING30):0,0
FIELD:contact_city:LIKE(Invalid_Char):TYPE(STRING30):0,0
FIELD:contact_state:LIKE(Invalid_Alpha):TYPE(STRING2):0,0
FIELD:contact_zip:LIKE(Invalid_AlphaNum):TYPE(STRING9):0,0
FIELD:contact_phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:contact_fax:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:contact_email:LIKE(Invalid_Email):TYPE(STRING60):0,0
FIELD:contact_information:TYPE(STRING70):0,0
 
FIELD:prim_range:TYPE(STRING10):0,0
FIELD:predir:TYPE(STRING2):0,0
FIELD:prim_name:TYPE(STRING28):0,0
FIELD:addr_suffix:TYPE(STRING4):0,0
FIELD:postdir:TYPE(STRING2):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:TYPE(STRING25):0,0
FIELD:v_city_name:TYPE(STRING25):0,0
FIELD:st:TYPE(STRING2):0,0
FIELD:z5:TYPE(STRING5):0,0
FIELD:zip4:TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dpbc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:ace_fips_st:TYPE(STRING2):0,0
FIELD:fips_county:TYPE(STRING3):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
 
FIELD:append_rawaid:TYPE(UNSIGNED8):0,0
FIELD:address_type:TYPE(STRING5):0,0
FIELD:privacy_indicator:TYPE(STRING5):0,0
 
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
 
