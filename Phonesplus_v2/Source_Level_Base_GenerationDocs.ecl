﻿Generated by SALT V3.11.11
Command line options: -MPhonesplus_v2 -eC:\Users\czajda01\AppData\Local\Temp\TFR4E99.tmp 
File being processed :-
OPTIONS:-gh
NAMESCOPE:Source_Level_Base
FILENAME:Source_Level_Base
MODULE:PhonesPlus_V2
 
RIDFIELD:record_sid
SOURCEFIELD:source
 
//DF-27472 update rules field on detail records
 
// Uncomment up to NINES for internal or external adl
// IDFIELD:EXISTS:<NameOfIDField>
// RIDFIELD:<NameOfRidField>
// RECORDS:<NumberOfRecordsInDataFile>
// POPULATION:<ExpectedNumberOfEntitiesInDataFile>
// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
// Uncomment Process if doing external adl
// PROCESS:<ProcessName>
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// FUZZY can be used to create new types of FUZZY linking
// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.
// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running
// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.
FIELD:cellphoneidkey:TYPE(DATA16):0,0
FIELD:source:TYPE(STRING2):0,0
FIELD:src_bitmap:TYPE(UNSIGNED8):0,0
FIELD:household_flag:TYPE(BOOLEAN):0,0
FIELD:rules:TYPE(UNSIGNED8):0,0
FIELD:cellphone:TYPE(STRING10):0,0
FIELD:npa:TYPE(STRING3):0,0
FIELD:phone7:TYPE(STRING7):0,0
FIELD:phone7_did_key:TYPE(DATA16):0,0
FIELD:pdid:TYPE(UNSIGNED6):0,0
FIELD:did:TYPE(UNSIGNED6):0,0
FIELD:did_score:TYPE(STRING3):0,0
FIELD:datefirstseen:TYPE(UNSIGNED3):0,0
FIELD:datelastseen:TYPE(UNSIGNED3):0,0
FIELD:datevendorfirstreported:TYPE(UNSIGNED3):0,0
FIELD:datevendorlastreported:TYPE(UNSIGNED3):0,0
FIELD:dt_nonglb_last_seen:TYPE(UNSIGNED3):0,0
FIELD:glb_dppa_flag:TYPE(STRING1):0,0
FIELD:did_type:TYPE(STRING10):0,0
FIELD:origname:TYPE(STRING90):0,0
FIELD:address1:TYPE(STRING25):0,0
FIELD:address2:TYPE(STRING25):0,0
FIELD:origcity:TYPE(STRING20):0,0
FIELD:origstate:TYPE(STRING2):0,0
FIELD:origzip:TYPE(STRING9):0,0
FIELD:orig_phone:TYPE(STRING10):0,0
FIELD:orig_carrier_name:TYPE(STRING60):0,0
FIELD:prim_range:TYPE(STRING10):0,0
FIELD:predir:TYPE(STRING2):0,0
FIELD:prim_name:TYPE(STRING28):0,0
FIELD:addr_suffix:TYPE(STRING4):0,0
FIELD:postdir:TYPE(STRING2):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:TYPE(STRING25):0,0
FIELD:v_city_name:TYPE(STRING25):0,0
FIELD:state:TYPE(STRING2):0,0
FIELD:zip5:TYPE(STRING5):0,0
FIELD:zip4:TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dpbc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:ace_fips_st:TYPE(STRING2):0,0
FIELD:ace_fips_county:TYPE(STRING3):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:TYPE(STRING20):0,0
FIELD:mname:TYPE(STRING20):0,0
FIELD:lname:TYPE(STRING20):0,0
FIELD:name_suffix:TYPE(STRING5):0,0
FIELD:name_score:TYPE(STRING3):0,0
FIELD:dob:TYPE(STRING8):0,0
FIELD:rawaid:TYPE(UNSIGNED8):0,0
FIELD:cleanaid:TYPE(UNSIGNED8):0,0
FIELD:current_rec:TYPE(BOOLEAN):0,0
FIELD:first_build_date:TYPE(UNSIGNED4):0,0
FIELD:last_build_date:TYPE(UNSIGNED4):0,0
FIELD:ingest_tpe:TYPE(UNSIGNED1):0,0
FIELD:verified:TYPE(STRING1):0,0
FIELD:cord_cutter:TYPE(STRING1):0,0
FIELD:activity_status:TYPE(STRING2):0,0
FIELD:prepaid:TYPE(STRING1):0,0
FIELD:global_sid:TYPE(UNSIGNED4):0,0
FIELD:record_sid:TYPE(UNSIGNED8):0,0
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
 
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
 
