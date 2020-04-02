﻿Generated by SALT V3.11.9
Command line options: -MScrubs_eMerges -eC:\Users\granjo01\AppData\Local\Temp\TFRBDD.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_eMerges
FILENAME:eMerges
NAMESCOPE:Voters
 
FIELDTYPE:Invalid_No:ALLOW(0123456789 )
FIELDTYPE:Invalid_Float:ALLOW(0123456789 .-/)
FIELDTYPE:Invalid_Alpha:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .'-)
FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .'-)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)
FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9,10)
 
FIELD:process_date:TYPE(STRING8):LIKE(Invalid_Date):0,0
FIELD:date_first_seen:TYPE(STRING8):LIKE(Invalid_Date):0,0
FIELD:date_last_seen:TYPE(STRING8):LIKE(Invalid_Date):0,0
FIELD:score:TYPE(STRING3):LIKE(Invalid_No):0,0
FIELD:best_ssn:TYPE(STRING9):LIKE(Invalid_Float):0,0
FIELD:did_out:TYPE(STRING12):LIKE(Invalid_No):0,0
FIELD:source:TYPE(STRING7):0,0
FIELD:file_id:TYPE(STRING4):LIKE(Invalid_Alpha):0,0
FIELD:vendor_id:TYPE(STRING13):0,0
FIELD:source_state:TYPE(STRING2):LIKE(Invalid_State):0,0
FIELD:source_code:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:file_acquired_date:TYPE(STRING8):LIKE(Invalid_Date):0,0
FIELD:_use:TYPE(STRING2):LIKE(Invalid_AlphaNum):0,0
FIELD:title_in:TYPE(STRING10):LIKE(Invalid_Alpha):0,0
FIELD:lname_in:TYPE(STRING30):LIKE(Invalid_Alpha):0,0
FIELD:fname_in:TYPE(STRING30):LIKE(Invalid_Alpha):0,0
FIELD:mname_in:TYPE(STRING30):LIKE(Invalid_Alpha):0,0
FIELD:maiden_prior:TYPE(STRING30):LIKE(Invalid_Alpha):0,0
FIELD:name_suffix_in:TYPE(STRING3):LIKE(Invalid_AlphaNum):0,0
FIELD:votefiller:TYPE(STRING15):0,0
FIELD:source_voterid:TYPE(STRING12):LIKE(Invalid_No):0,0
FIELD:dob:TYPE(STRING8):LIKE(Invalid_Date):0,0
FIELD:agecat:TYPE(STRING2):LIKE(Invalid_No):0,0
FIELD:headhousehold:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:place_of_birth:TYPE(STRING18):LIKE(Invalid_Date):0,0
FIELD:occupation:TYPE(STRING30):LIKE(Invalid_Alpha):0,0
FIELD:maiden_name:TYPE(STRING30):LIKE(Invalid_Alpha):0,0
FIELD:motorvoterid:TYPE(STRING15):LIKE(Invalid_No):0,0
FIELD:regsource:TYPE(STRING10):LIKE(Invalid_Alpha):0,0
FIELD:regdate:TYPE(STRING8):LIKE(Invalid_Date):0,0
FIELD:race:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:gender:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:poliparty:TYPE(STRING2):LIKE(Invalid_No):0,0
FIELD:poliparty_mapped:TYPE(STRING25):LIKE(Invalid_Alpha):0,0
FIELD:phone:TYPE(STRING10):LIKE(Invalid_Float):0,0
FIELD:work_phone:TYPE(STRING10):LIKE(Invalid_Float):0,0
FIELD:other_phone:TYPE(STRING10):LIKE(Invalid_Float):0,0
FIELD:active_status:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:active_status_mapped:TYPE(STRING20):LIKE(Invalid_Alpha):0,0
FIELD:votefiller2:TYPE(STRING1):0,0
FIELD:active_other:TYPE(STRING1):LIKE(Invalid_AlphaNum):0,0
FIELD:voterstatus:TYPE(STRING2):LIKE(Invalid_AlphaNum):0,0
FIELD:voterstatus_mapped:TYPE(STRING50):LIKE(Invalid_AlphaNum):0,0
FIELD:resaddr1:TYPE(STRING40):LIKE(Invalid_AlphaNum):0,0
FIELD:resaddr2:TYPE(STRING40):LIKE(Invalid_AlphaNum):0,0
FIELD:res_city:TYPE(STRING40):LIKE(Invalid_Alpha):0,0
FIELD:res_state:TYPE(STRING2):LIKE(Invalid_State):0,0
FIELD:res_zip:TYPE(STRING9):LIKE(Invalid_Zip):0,0
FIELD:res_county:TYPE(STRING3):LIKE(Invalid_AlphaNum):0,0
FIELD:mail_addr1:TYPE(STRING40):LIKE(Invalid_AlphaNum):0,0
FIELD:mail_addr2:TYPE(STRING40):LIKE(Invalid_AlphaNum):0,0
FIELD:mail_city:TYPE(STRING40):LIKE(Invalid_Alpha):0,0
FIELD:mail_state:TYPE(STRING2):LIKE(Invalid_State):0,0
FIELD:mail_zip:TYPE(STRING9):LIKE(Invalid_Zip):0,0
FIELD:mail_county:TYPE(STRING3):LIKE(Invalid_No):0,0
FIELD:addr_filler1:TYPE(STRING40):0,0
FIELD:addr_filler2:TYPE(STRING40):0,0
FIELD:city_filler:TYPE(STRING40):0,0
FIELD:state_filler:TYPE(STRING2):0,0
FIELD:zip_filler:TYPE(STRING9):0,0
FIELD:county_filler:TYPE(STRING3):0,0
FIELD:towncode:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0
FIELD:distcode:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0
FIELD:countycode:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0
FIELD:schoolcode:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0
FIELD:cityinout:TYPE(STRING1):LIKE(Invalid_AlphaNum):0,0
FIELD:spec_dist1:TYPE(STRING20):LIKE(Invalid_AlphaNum):0,0
FIELD:spec_dist2:TYPE(STRING20):LIKE(Invalid_AlphaNum):0,0
FIELD:precinct1:TYPE(STRING7):LIKE(Invalid_AlphaNum):0,0
FIELD:precinct2:TYPE(STRING7):LIKE(Invalid_AlphaNum):0,0
FIELD:precinct3:TYPE(STRING7):LIKE(Invalid_AlphaNum):0,0
FIELD:villageprecinct:TYPE(STRING7):LIKE(Invalid_AlphaNum):0,0
FIELD:schoolprecinct:TYPE(STRING7):LIKE(Invalid_AlphaNum):0,0
FIELD:ward:TYPE(STRING7):LIKE(Invalid_AlphaNum):0,0
FIELD:precinct_citytown:TYPE(STRING7):LIKE(Invalid_AlphaNum):0,0
FIELD:ancsmdindc:TYPE(STRING7):LIKE(Invalid_AlphaNum):0,0
FIELD:citycouncildist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:countycommdist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:statehouse:TYPE(STRING3):LIKE(Invalid_AlphaNum):0,0
FIELD:statesenate:TYPE(STRING3):LIKE(Invalid_AlphaNum):0,0
FIELD:ushouse:TYPE(STRING3):LIKE(Invalid_AlphaNum):0,0
FIELD:elemschooldist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:schooldist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:schoolfiller:TYPE(STRING5):0,0
FIELD:commcolldist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:dist_filler:TYPE(STRING5):0,0
FIELD:municipal:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:villagedist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:policejury:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:policedist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:publicservcomm:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:rescue:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:fire:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:sanitary:TYPE(STRING4):LIKE(Invalid_Alpha):0,0
FIELD:sewerdist:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:waterdist:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:mosquitodist:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:taxdist:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:supremecourt:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:justiceofpeace:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:judicialdist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:superiorctdist:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:appealsct:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:courtfiller:TYPE(STRING4):0,0
FIELD:contributorparty:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:recptparty:TYPE(STRING2):LIKE(Invalid_No):0,0
FIELD:dateofcontr:TYPE(STRING8):LIKE(Invalid_Date):0,0
FIELD:dollaramt:TYPE(STRING7):LIKE(Invalid_No):0,0
FIELD:officecontto:TYPE(STRING3):0,0
FIELD:cumuldollaramt:TYPE(STRING7):0,0
FIELD:contfiller1:TYPE(STRING21):0,0
FIELD:contfiller2:TYPE(STRING21):0,0
FIELD:conttype:TYPE(STRING5):0,0
FIELD:contfiller3:TYPE(STRING15):0,0
FIELD:primary02:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special02:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:other02:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special202:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:general02:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:primary01:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special01:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:other01:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special201:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:general01:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:pres00:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:primary00:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special00:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:other00:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special200:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:general00:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:primary99:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special99:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:other99:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special299:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:general99:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:primary98:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special98:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:other98:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special298:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:general98:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:primary97:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special97:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:other97:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special297:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:general97:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:pres96:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:primary96:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special96:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:other96:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:special296:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:general96:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:lastdayvote:TYPE(STRING8):LIKE(Invalid_Date):0,0
FIELD:title:TYPE(STRING5):LIKE(Invalid_Alpha):0,0
FIELD:fname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0
FIELD:mname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0
FIELD:lname:TYPE(STRING20):LIKE(Invalid_Alpha):0,0
FIELD:name_suffix:TYPE(STRING5):LIKE(Invalid_Alpha):0,0
FIELD:score_on_input:TYPE(STRING3):LIKE(Invalid_No):0,0
FIELD:prim_range:TYPE(STRING10):LIKE(Invalid_No):0,0
FIELD:predir:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:prim_name:TYPE(STRING28):LIKE(Invalid_AlphaNum):0,0
FIELD:suffix:TYPE(STRING4):LIKE(Invalid_Alpha):0,0
FIELD:postdir:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:unit_desig:TYPE(STRING10):LIKE(Invalid_Alpha):0,0
FIELD:sec_range:TYPE(STRING8):LIKE(Invalid_AlphaNum):0,0
FIELD:p_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0
FIELD:city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0
FIELD:st:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:zip:TYPE(STRING5):LIKE(Invalid_Zip):0,0
FIELD:zip4:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:cart:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:cr_sort_sz:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:lot:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:lot_order:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:dpbc:TYPE(STRING2):LIKE(Invalid_No):0,0
FIELD:chk_digit:TYPE(STRING1):LIKE(Invalid_No):0,0
FIELD:record_type:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:ace_fips_st:TYPE(STRING2):LIKE(Invalid_AlphaNum):0,0
FIELD:county:TYPE(STRING3):LIKE(Invalid_No):0,0
FIELD:county_name:TYPE(STRING18):LIKE(Invalid_Alpha):0,0
FIELD:geo_lat:TYPE(STRING10):LIKE(Invalid_Float):0,0
FIELD:geo_long:TYPE(STRING11):LIKE(Invalid_Float):0,0
FIELD:msa:TYPE(STRING4):LIKE(Invalid_Float):0,0
FIELD:geo_blk:TYPE(STRING7):LIKE(Invalid_Float):0,0
FIELD:geo_match:TYPE(STRING1):LIKE(Invalid_Float):0,0
FIELD:err_stat:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:mail_prim_range:TYPE(STRING10):LIKE(Invalid_No):0,0
FIELD:mail_predir:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:mail_prim_name:TYPE(STRING28):LIKE(Invalid_AlphaNum):0,0
FIELD:mail_addr_suffix:TYPE(STRING4):LIKE(Invalid_Alpha):0,0
FIELD:mail_postdir:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:mail_unit_desig:TYPE(STRING10):LIKE(Invalid_Alpha):0,0
FIELD:mail_sec_range:TYPE(STRING8):LIKE(Invalid_AlphaNum):0,0
FIELD:mail_p_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0
FIELD:mail_v_city_name:TYPE(STRING25):LIKE(Invalid_Alpha):0,0
FIELD:mail_st:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:mail_ace_zip:TYPE(STRING5):LIKE(Invalid_Zip):0,0
FIELD:mail_zip4:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:mail_cart:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:mail_cr_sort_sz:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:mail_lot:TYPE(STRING4):LIKE(Invalid_No):0,0
FIELD:mail_lot_order:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:mail_dpbc:TYPE(STRING2):LIKE(Invalid_No):0,0
FIELD:mail_chk_digit:TYPE(STRING1):LIKE(Invalid_No):0,0
FIELD:mail_record_type:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:mail_ace_fips_st:TYPE(STRING2):LIKE(Invalid_No):0,0
FIELD:mail_fipscounty:TYPE(STRING3):LIKE(Invalid_No):0,0
FIELD:mail_geo_lat:TYPE(STRING10):LIKE(Invalid_Float):0,0
FIELD:mail_geo_long:TYPE(STRING11):LIKE(Invalid_Float):0,0
FIELD:mail_msa:TYPE(STRING4):LIKE(Invalid_Float):0,0
FIELD:mail_geo_blk:TYPE(STRING7):LIKE(Invalid_Float):0,0
FIELD:mail_geo_match:TYPE(STRING1):LIKE(Invalid_Float):0,0
FIELD:mail_err_stat:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
 
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
 
