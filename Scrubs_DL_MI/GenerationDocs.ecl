﻿Generated by SALT V3.11.7
Command line options: -MScrubs_DL_MI -eC:\Users\myanasx\AppData\Local\Temp\TFRDD8C.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_DL_MI
FILENAME:In_MI
 
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
 
FIELDTYPE:invalid_past_date:LENGTHS(8):CUSTOM(Scrubs.fn_valid_pastDate>0)
FIELDTYPE:invalid_code:ENUM(A|C|)
FIELDTYPE:invalid_numeric:ALLOW(0123456789)
FIELDTYPE:invalid_dl_number_check:CUSTOM(Scrubs_DL_MI.Functions.fn_check_dl_number>0)
FIELDTYPE:invalid_gender:ENUM(F|M|U|)
FIELDTYPE:invalid_dln_pid_indi:ENUM(D|P|)
FIELDTYPE:invalid_name:CUSTOM(scrubs.functions.fn_populated_strings>0,middle_name,last_name)
FIELDTYPE:invalid_city:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )
FIELDTYPE:invalid_street:ALLOW(/#-,.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )
FIELDTYPE:invalid_state:CUSTOM(Scrubs_DL_MI.Functions.fn_verify_state>0)
FIELDTYPE:invalid_zip:CUSTOM(Scrubs.Functions.fn_verify_zip59>0)
FIELDTYPE:invalid_clean_name:CUSTOM(scrubs.functions.fn_populated_strings>0,clean_mname,clean_lname)
 
FIELD:process_date:TYPE(STRING8):LIKE(invalid_past_date):0,0
FIELD:code:TYPE(STRING1):LIKE(invalid_code):0,0
FIELD:customer_dln_pid:TYPE(STRING13):LIKE(invalid_dl_number_check):0,0
FIELD:last_name:TYPE(STRING50):0,0
FIELD:first_name:TYPE(STRING50):LIKE(invalid_name):0,0
FIELD:middle_name:TYPE(STRING50):0,0
FIELD:name_suffix:TYPE(STRING6):0,0
FIELD:street_address:TYPE(STRING36):LIKE(invalid_street):0,0
FIELD:city:TYPE(STRING19):LIKE(invalid_city):0,0
FIELD:state:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:zipcode:TYPE(STRING5):LIKE(invalid_zip):0,0
FIELD:date_of_birth:TYPE(STRING8):LIKE(invalid_past_date):0,0
FIELD:gender:TYPE(STRING1):LIKE(invalid_gender):0,0
FIELD:county:TYPE(STRING2):LIKE(invalid_numeric):0,0
FIELD:dln_pid_indicator:TYPE(STRING1):LIKE(invalid_dln_pid_indi):0,0
FIELD:mailing_street_address:TYPE(STRING36):LIKE(invalid_street):0,0
FIELD:mailing_city:TYPE(STRING19):LIKE(invalid_city):0,0
FIELD:mailing_state:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:mailing_zipcode:TYPE(STRING5):LIKE(invalid_zip):0,0
FIELD:blob:TYPE(STRING5):0,0
FIELD:clean_name_prefix:TYPE(STRING5):0,0
FIELD:clean_fname:TYPE(STRING20):LIKE(invalid_clean_name):0,0
FIELD:clean_mname:TYPE(STRING20):0,0
FIELD:clean_lname:TYPE(STRING20):0,0
FIELD:clean_name_suffix:TYPE(STRING5):0,0
FIELD:clean_name_score:TYPE(STRING3):0,0
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
 
