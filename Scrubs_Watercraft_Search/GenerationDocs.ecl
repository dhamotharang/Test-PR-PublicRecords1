Generated by SALT V3.0 A21
File being processed :-
MODULE:Scrubs_Watercraft_Search
FILENAME:Watercraft_Search
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9, 2 = 99 1.780595e+260tc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking
SOURCEFIELD:source_code
FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( -):LENGTHS(0..)
FIELDTYPE:invalid_name:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -,&\/.:;_):LENGTHS(0..)
FIELDTYPE:invalid_company:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -,&\/.:#;()"):LENGTHS(0..)
FIELDTYPE:invalid_numeric:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:invalid_address:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -&/\#.;,):LENGTHS(0..)
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_zip:ALLOW(0123456789X):SPACES( -):LENGTHS(10,9,6,5,0)
FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES(?)
FIELDTYPE:invalid_dppa_flag:ENUM(Y|N):LENGTHS(1,0)
FIELDTYPE:invalid_history_flag:ENUM(H|U|E| ):LENGTHS(1,0)
FIELDTYPE:invalid_owner_type:ENUM(O|R|B| ):LENGTHS(1,0)
FIELDTYPE:invalid_fips:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:invalid_ssn_fein:ALLOW(0123456789):LENGTHS(9,0)
FIELDTYPE:invalid_phone:ALLOW(0123456789):SPACES( ):LENGTHS(10,0)
FIELDTYPE:invalid_blank:LENGTHS(1..)
FIELDTYPE:invalid_source_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2)
FIELD:date_first_seen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_last_seen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_vendor_first_reported:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_vendor_last_reported:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:watercraft_key:LIKE(invalid_blank):TYPE(STRING30):0,0
FIELD:sequence_key:TYPE(STRING30):0,0
FIELD:state_origin:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:source_code:LIKE(invalid_source_code):TYPE(STRING2):0,0
FIELD:dppa_flag:LIKE(invalid_dppa_flag):TYPE(STRING1):0,0
FIELD:orig_name:TYPE(STRING100):0,0
FIELD:orig_name_type_code:LIKE(invalid_owner_type):TYPE(STRING1):0,0
FIELD:orig_name_type_description:TYPE(STRING20):0,0
FIELD:orig_name_first:TYPE(STRING25):0,0
FIELD:orig_name_middle:TYPE(STRING25):0,0
FIELD:orig_name_last:TYPE(STRING25):0,0
FIELD:orig_name_suffix:TYPE(STRING10):0,0
FIELD:orig_address_1:TYPE(STRING60):0,0
FIELD:orig_address_2:TYPE(STRING60):0,0
FIELD:orig_city:TYPE(STRING25):0,0
FIELD:orig_state:TYPE(STRING2):0,0
FIELD:orig_zip:TYPE(STRING10):0,0
FIELD:orig_fips:TYPE(STRING5):0,0
FIELD:orig_province:TYPE(STRING30):0,0
FIELD:orig_country:TYPE(STRING30):0,0
FIELD:dob:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:orig_ssn:TYPE(STRING9):0,0
FIELD:orig_fein:TYPE(STRING9):0,0
FIELD:gender:TYPE(STRING1):0,0
FIELD:phone_1:LIKE(invalid_phone):TYPE(STRING10):0,0
FIELD:phone_2:LIKE(invalid_phone):TYPE(STRING10):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:mname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:lname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:name_suffix:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:name_cleaning_score:TYPE(STRING3):0,0
FIELD:company_name:LIKE(invalid_company):TYPE(STRING60):0,0
FIELD:prim_range:LIKE(invalid_address):TYPE(STRING10):0,0
FIELD:predir:LIKE(invalid_address):TYPE(STRING2):0,0
FIELD:prim_name:LIKE(invalid_address):TYPE(STRING28):0,0
FIELD:suffix:LIKE(invalid_address):TYPE(STRING4):0,0
FIELD:postdir:LIKE(invalid_address):TYPE(STRING2):0,0
FIELD:unit_desig:LIKE(invalid_address):TYPE(STRING10):0,0
FIELD:sec_range:LIKE(invalid_address):TYPE(STRING8):0,0
FIELD:p_city_name:LIKE(invalid_alpha):TYPE(STRING25):0,0
FIELD:v_city_name:LIKE(invalid_alpha):TYPE(STRING25):0,0
FIELD:st:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:zip5:LIKE(invalid_numeric):TYPE(STRING5):0,0
FIELD:zip4:LIKE(invalid_numeric):TYPE(STRING4):0,0
FIELD:county:TYPE(STRING3):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dpbc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:ace_fips_st:LIKE(invalid_fips):TYPE(STRING2):0,0
FIELD:ace_fips_county:TYPE(STRING3):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
FIELD:bdid:LIKE(invalid_numeric):TYPE(STRING12):0,0
FIELD:fein:LIKE(invalid_ssn_fein):TYPE(STRING9):0,0
FIELD:did:LIKE(invalid_numeric):TYPE(STRING12):0,0
FIELD:did_score:TYPE(STRING3):0,0
FIELD:ssn:LIKE(invalid_ssn_fein):TYPE(STRING9):0,0
FIELD:history_flag:LIKE(invalid_history_flag):TYPE(STRING1):0,0
FIELD:rawaid:LIKE(invalid_numeric):TYPE(UNSIGNED8):0,0
FIELD:reg_owner_name_2:TYPE(STRING100):0,0
FIELD:persistent_record_id:LIKE(invalid_numeric):TYPE(UNSIGNED8):0,0
FIELD:source_rec_id:LIKE(invalid_numeric):TYPE(UNSIGNED8):0,0
/*FIELD:dotid:TYPE(UNSIGNED6):0,0
FIELD:dotscore:TYPE(UNSIGNED2):0,0
FIELD:dotweight:TYPE(UNSIGNED2):0,0
FIELD:empid:TYPE(UNSIGNED6):0,0
FIELD:empscore:TYPE(UNSIGNED2):0,0
FIELD:empweight:TYPE(UNSIGNED2):0,0
FIELD:powid:TYPE(UNSIGNED6):0,0
FIELD:powscore:TYPE(UNSIGNED2):0,0
FIELD:powweight:TYPE(UNSIGNED2):0,0
FIELD:proxid:TYPE(UNSIGNED6):0,0
FIELD:proxscore:TYPE(UNSIGNED2):0,0
FIELD:proxweight:TYPE(UNSIGNED2):0,0
FIELD:seleid:TYPE(UNSIGNED6):0,0
FIELD:selescore:TYPE(UNSIGNED2):0,0
FIELD:seleweight:TYPE(UNSIGNED2):0,0
FIELD:orgid:TYPE(UNSIGNED6):0,0
FIELD:orgscore:TYPE(UNSIGNED2):0,0
FIELD:orgweight:TYPE(UNSIGNED2):0,0
FIELD:ultid:TYPE(UNSIGNED6):0,0
FIELD:ultscore:TYPE(UNSIGNED2):0,0
FIELD:ultweight:TYPE(UNSIGNED2):0,0*/
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
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
