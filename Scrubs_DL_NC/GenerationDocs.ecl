Generated by SALT V3.5.3
Command line options: -MScrubs_DL_NC -eC:\Users\wolfkg\AppData\Local\Temp\TFRB3FA.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_DL_NC
FILENAME:In_NC
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
 
// FIELDTYPE DEFINITIONS
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_alpha_num_specials:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ /'@-.,#)
FIELDTYPE:invalid_numeric:ALLOW(0123456789)
FIELDTYPE:invalid_numeric_blank:ALLOW(0123456789 )
FIELDTYPE:invalid_alpha_num:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_empty:LENGTHS(0)
FIELDTYPE:invalid_wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]()-^=:!+&,./#*'\|_")
FIELDTYPE:invalid_8pastdate:LENGTHS(8):CUSTOM(Scrubs.fn_valid_pastDate>0)
FIELDTYPE:invalid_8generaldate:LENGTHS(8):CUSTOM(Scrubs.fn_valid_GeneralDate>0)
 
FIELDTYPE:invalid_license_number:LENGTHS(12):LIKE(invalid_numeric)
FIELDTYPE:invalid_name:LIKE(invalid_wordbag):CUSTOM(Scrubs_DL_NC.Functions.fn_valid_name>0,firstname,middlename)
FIELDTYPE:invalid_state:LENGTHS(0,2):LIKE(invalid_alpha)
FIELDTYPE:invalid_zip:LENGTHS(0,5,9):LIKE(invalid_numeric)
FIELDTYPE:invalid_licensetype:CUSTOM(Scrubs_DL_NC.Functions.fn_check_license_type>0)
FIELDTYPE:invalid_status:CUSTOM(Scrubs_DL_NC.Functions.fn_check_status>0)
FIELDTYPE:invalid_clean_name:LIKE(invalid_wordbag):CUSTOM(Scrubs_DL_NC.Functions.fn_valid_name>0,fname,mname)
FIELDTYPE:invalid_direction:ALLOW(ENSW)
FIELDTYPE:invalid_zip5:LENGTHS(0,5):LIKE(invalid_numeric)
FIELDTYPE:invalid_zip4:LENGTHS(0,4):LIKE(invalid_numeric)
FIELDTYPE:invalid_cart:LENGTHS(0,4):LIKE(invalid_alpha_num)
FIELDTYPE:invalid_cr_sort_sz:ENUM(A|B|C|D|)
FIELDTYPE:invalid_lot:LENGTHS(0,4):LIKE(invalid_numeric_blank)
FIELDTYPE:invalid_lot_order:LENGTHS(0,1):ALLOW(AD)
FIELDTYPE:invalid_dpbc:LENGTHS(0,2):LIKE(invalid_numeric)
FIELDTYPE:invalid_chk_digit:LENGTHS(0,1):LIKE(invalid_numeric)
FIELDTYPE:invalid_record_type:LENGTHS(0,1,2):CUSTOM(Scrubs_DL_NC.Functions.fn_addr_rec_type>0)
FIELDTYPE:invalid_ace_fips_st:LENGTHS(0,2):LIKE(invalid_numeric)
FIELDTYPE:invalid_fipscounty:LENGTHS(0,3):LIKE(invalid_numeric)
FIELDTYPE:invalid_geo:ALLOW(-.0123456789)
FIELDTYPE:invalid_msa:LENGTHS(0,4):LIKE(invalid_numeric)
FIELDTYPE:invalid_geo_blk:LENGTHS(0,7):LIKE(invalid_numeric)
FIELDTYPE:invalid_geo_match:LENGTHS(0,1):LIKE(invalid_numeric)
FIELDTYPE:invalid_err_stat:LENGTHS(0,4):LIKE(invalid_alpha_num)
 
// FIELD DEFINITIONS
FIELD:process_date:TYPE(STRING8):LIKE(invalid_8pastdate):0,0
FIELD:customer_id:TYPE(STRING):LIKE(invalid_wordbag):0,0
FIELD:license_number:TYPE(STRING):LIKE(invalid_license_number):0,0
FIELD:firstname:TYPE(STRING):0,0
FIELD:middlename:TYPE(STRING):0,0
FIELD:lastname:TYPE(STRING):LIKE(invalid_name):0,0
FIELD:suffix:TYPE(STRING):0,0
FIELD:address1:TYPE(STRING):0,0
FIELD:address2:TYPE(STRING):0,0
FIELD:city:TYPE(STRING):LIKE(invalid_alpha_num_specials):0,0
FIELD:state:TYPE(STRING):LIKE(invalid_state):0,0
FIELD:zip:TYPE(STRING):LIKE(invalid_zip):0,0
FIELD:dob:TYPE(STRING):LIKE(invalid_8pastdate):0,0
FIELD:licensetype:TYPE(STRING):LIKE(invalid_licensetype):0,0
FIELD:issuedate:TYPE(STRING):LIKE(invalid_8pastdate):0,0
FIELD:expiration:TYPE(STRING):LIKE(invalid_8generaldate):0,0
FIELD:restriction1:TYPE(STRING):0,0
FIELD:restriction2:TYPE(STRING):0,0
FIELD:restriction3:TYPE(STRING):0,0
FIELD:restriction4:TYPE(STRING):0,0
FIELD:restriction5:TYPE(STRING):0,0
FIELD:status:TYPE(STRING):LIKE(invalid_status):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:TYPE(STRING20):0,0
FIELD:mname:TYPE(STRING20):0,0
FIELD:lname:TYPE(STRING20):LIKE(invalid_clean_name):0,0
FIELD:name_suffix:TYPE(STRING5):0,0
FIELD:cleaning_score:TYPE(STRING3):LIKE(invalid_numeric):0,0
FIELD:prim_range:TYPE(STRING10):LIKE(invalid_alpha_num_specials):0,0
FIELD:predir:TYPE(STRING2):LIKE(invalid_direction):0,0
FIELD:prim_name:TYPE(STRING28):0,0
FIELD:addr_suffix:TYPE(STRING4):0,0
FIELD:postdir:TYPE(STRING2):LIKE(invalid_direction):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_alpha_num_specials):0,0
FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_alpha_num_specials):0,0
FIELD:st:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:zip5:TYPE(STRING5):LIKE(invalid_zip5):0,0
FIELD:zip4:TYPE(STRING4):LIKE(invalid_zip4):0,0
FIELD:cart:TYPE(STRING4):LIKE(invalid_cart):0,0
FIELD:cr_sort_sz:TYPE(STRING1):LIKE(invalid_cr_sort_sz):0,0
FIELD:lot:TYPE(STRING4):LIKE(invalid_lot):0,0
FIELD:lot_order:TYPE(STRING1):LIKE(invalid_lot_order):0,0
FIELD:dpbc:TYPE(STRING2):LIKE(invalid_dpbc):0,0
FIELD:chk_digit:TYPE(STRING1):LIKE(invalid_chk_digit):0,0
FIELD:rec_type:TYPE(STRING2):LIKE(invalid_record_type):0,0
FIELD:ace_fips_st:TYPE(STRING2):LIKE(invalid_ace_fips_st):0,0
FIELD:county:TYPE(STRING3):LIKE(invalid_fipscounty):0,0
FIELD:geo_lat:TYPE(STRING10):LIKE(invalid_geo):0,0
FIELD:geo_long:TYPE(STRING11):LIKE(invalid_geo):0,0
FIELD:msa:TYPE(STRING4):LIKE(invalid_msa):0,0
FIELD:geo_blk:TYPE(STRING7):LIKE(invalid_geo_blk):0,0
FIELD:geo_match:TYPE(STRING1):LIKE(invalid_geo_match):0,0
FIELD:err_stat:TYPE(STRING4):LIKE(invalid_err_stat):0,0
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
 
