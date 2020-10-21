﻿Generated by SALT V3.11.4
Command line options: -MScrubs_Voters -eC:\Users\oneillbw\AppData\Local\Temp\TFRF874.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Voters
FILENAME:Voters
NAMESCOPE:In_Reg
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
 
//FIELDTYPE DEFINITIONS
FIELDTYPE:invalid_agecat:CUSTOM(Scrubs_Voters.Functions.fn_valid_agecat>0)
FIELDTYPE:invalid_alphanum:CUSTOM(Scrubs_Voters.Functions.fn_non_empty_alphanum>0)
FIELDTYPE:invalid_alphanum_empty:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz )
FIELDTYPE:invalid_alphanum_empty_specials:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()@#-:./,`&'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº )
FIELDTYPE:invalid_alphanum_specials:CUSTOM(Scrubs_Voters.Functions.fn_non_empty_alphanum_specials>0)
FIELDTYPE:invalid_alphanumquot_empty:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" )
FIELDTYPE:invalid_boolean_yn_empty:ENUM(N|Y|)
FIELDTYPE:invalid_changedate:CUSTOM(Scrubs_Voters.Functions.fn_optional_past_yyyymmdd>0)
FIELDTYPE:invalid_dob:CUSTOM(Scrubs_Voters.Functions.fn_valid_generic_date>0)
FIELDTYPE:invalid_gender:ENUM(F|M|U|N|)
FIELDTYPE:invalid_lastdatevote:CUSTOM(Scrubs_Voters.Functions.fn_valid_generic_date>0)
FIELDTYPE:invalid_last_name:CUSTOM(Scrubs_Voters.Functions.fn_populated_strings>0,first_name,middle_name)
FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_Voters.Functions.fn_populated_strings>0)
FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Voters.Functions.fn_numeric>0)
FIELDTYPE:invalid_nums_empty:ALLOW(0123456789)
FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_Voters.Functions.fn_past_yyyymmdd>0)
FIELDTYPE:invalid_percentage:CUSTOM(Scrubs_Voters.Functions.fn_range_numeric>0,0,100)
FIELDTYPE:invalid_phone:CUSTOM(Scrubs_Voters.Functions.fn_verify_optional_phone>0)
FIELDTYPE:invalid_race:CUSTOM(Scrubs_Voters.Functions.fn_race>0)
FIELDTYPE:invalid_regdate:CUSTOM(Scrubs_Voters.Functions.fn_valid_generic_date>0)
FIELDTYPE:invalid_source_state:CUSTOM(Scrubs_Voters.Functions.fn_verify_state>0)
FIELDTYPE:invalid_st:CUSTOM(Scrubs_Voters.Functions.fn_verify_state>0)
 
//FIELD DEFINITIONS
FIELD:active_status:TYPE(STRING1):LIKE(invalid_alphanum_empty):0,0
FIELD:agecat:TYPE(STRING2):LIKE(invalid_agecat):0,0
FIELD:changedate:TYPE(STRING10):LIKE(invalid_changedate):0,0
FIELD:countycode:TYPE(STRING5):LIKE(invalid_alphanum_empty):0,0
FIELD:distcode:TYPE(STRING5):LIKE(invalid_alphanum_empty):0,0
FIELD:dob:TYPE(STRING8):LIKE(invalid_dob):0,0
FIELD:EMID_number:TYPE(STRING13):LIKE(invalid_alphanum):0,0
FIELD:file_acquired_date:TYPE(STRING8):LIKE(invalid_pastdate8):0,0
FIELD:first_name:TYPE(STRING30):LIKE(invalid_alphanum_specials):0,0
FIELD:gender:TYPE(STRING1):LIKE(invalid_gender):0,0
FIELD:gendersurnamguess:TYPE(STRING1):LIKE(invalid_alphanum_empty):0,0
FIELD:home_phone:TYPE(STRING10):LIKE(invalid_phone):0,0
FIELD:idcode:TYPE(STRING1):LIKE(invalid_alphanum_empty):0,0
FIELD:lastdatevote:TYPE(STRING8):LIKE(invalid_lastdatevote):0,0
FIELD:last_name:TYPE(STRING30):LIKE(invalid_last_name):0,0
FIELD:marriedappend:TYPE(STRING2):LIKE(invalid_boolean_yn_empty):0,0
FIELD:middle_name:TYPE(STRING30):LIKE(invalid_alphanum_empty_specials):0,0
// FIELD:political_party:TYPE(STRING2):LIKE(invalid_numeric):0,0
FIELD:political_party:TYPE(STRING2):LIKE(invalid_nums_empty):0,0
FIELD:race:TYPE(STRING2):LIKE(invalid_race):0,0
FIELD:regdate:TYPE(STRING8):LIKE(invalid_regdate):0,0
FIELD:res_addr1:TYPE(STRING40):LIKE(invalid_mandatory):0,0
FIELD:res_city:TYPE(STRING40):LIKE(invalid_mandatory):0,0
FIELD:res_state:TYPE(STRING2):LIKE(invalid_st):0,0
FIELD:res_zip:TYPE(STRING9):LIKE(invalid_mandatory):0,0
FIELD:schoolcode:TYPE(STRING5):LIKE(invalid_alphanum_empty):0,0
FIELD:source_voterid:TYPE(STRING12):LIKE(invalid_alphanum):0,0
FIELD:statehouse:TYPE(STRING3):LIKE(invalid_alphanum_empty):0,0
FIELD:statesenate:TYPE(STRING3):LIKE(invalid_alphanumquot_empty):0,0
FIELD:state_code:TYPE(STRING2):LIKE(invalid_source_state):0,0
FIELD:timezonetbl:TYPE(STRING3):LIKE(invalid_nums_empty):0,0
FIELD:ushouse:TYPE(STRING3):LIKE(invalid_alphanum_empty):0,0
FIELD:voter_status:TYPE(STRING2):LIKE(invalid_alphanum_empty):0,0
FIELD:work_phone:TYPE(STRING10):LIKE(invalid_phone):0,0
 
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
 
