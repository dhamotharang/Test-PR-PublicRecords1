Generated by SALT V3.5.3
Command line options: -MScrubs_DL_OH -eC:\Users\wolfkg\AppData\Local\Temp\TFR283C.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_DL_OH
FILENAME:In_OH
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
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_alpha_num_specials:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-)
FIELDTYPE:invalid_numeric:ALLOW(0123456789)
FIELDTYPE:invalid_numeric_blank:ALLOW(0123456789 )
FIELDTYPE:invalid_alpha_num:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ )
FIELDTYPE:invalid_empty:LENGTHS(0)
FIELDTYPE:invalid_boolean_yn_empty:ENUM(N|Y|)
FIELDTYPE:invalid_wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]()-^=:!+&,./#*'\|_"%)
FIELDTYPE:invalid_8pastdate:LENGTHS(8):CUSTOM(Scrubs.fn_valid_pastDate>0)
FIELDTYPE:invalid_08pastdate:LENGTHS(0,8):CUSTOM(Scrubs.fn_valid_pastDate>0)
FIELDTYPE:invalid_8generaldate:LENGTHS(8):CUSTOM(Scrubs.fn_valid_GeneralDate>0)
FIELDTYPE:invalid_08generaldate:LENGTHS(0,8):CUSTOM(Scrubs.fn_valid_GeneralDate>0)
 
FIELDTYPE:invalid_dbkoln:ALLOW(0123456789ABCDEFGHI{):LENGTHS(9)
FIELDTYPE:invalid_pinss4:ALLOW(0{):LENGTHS(9)
FIELDTYPE:invalid_dvnlic:CUSTOM(Scrubs_DL_OH.Functions.fn_check_dl_number>0)
FIELDTYPE:invalid_dvccls:CUSTOM(Scrubs_DL_OH.Functions.fn_class>0)
FIELDTYPE:invalid_dvctyp:CUSTOM(Scrubs_DL_OH.Functions.fn_check_license_type>0)
FIELDTYPE:invalid_pifdon:CUSTOM(Scrubs_DL_OH.Functions.fn_check_donor>0)
FIELDTYPE:invalid_pichcl:CUSTOM(Scrubs_DL_OH.Functions.fn_check_hair_color>0)
FIELDTYPE:invalid_picecl:CUSTOM(Scrubs_DL_OH.Functions.fn_check_eye_color>0)
FIELDTYPE:invalid_piqwgt:CUSTOM(Scrubs_DL_OH.Functions.fn_verify_weight>0)
FIELDTYPE:invalid_height:CUSTOM(Scrubs_DL_OH.Functions.fn_verify_height>0,pinhin)
FIELDTYPE:invalid_picsex:ENUM(F|M|U|)
FIELDTYPE:invalid_drnagy:LENGTHS(0,4):LIKE(invalid_numeric)
FIELDTYPE:invalid_dvfocd:ENUM(C|N|T|Y|)
FIELDTYPE:invalid_dvcatt:LENGTHS(0,3):CUSTOM(Scrubs_DL_OH.Functions.fn_check_trans_type>0)
FIELDTYPE:invalid_dvcded:ENUM(0|1|2|3|)
FIELDTYPE:invalid_dvcgen:ALLOW(HMNPRSTX)
FIELDTYPE:invalid_dvqdup:ENUM(0|1|2|3|4|)
FIELDTYPE:invalid_dbkmtk:LENGTHS(9):LIKE(invalid_alpha_num_specials)
FIELDTYPE:invalid_dvnwbi:LENGTHS(2):LIKE(invalid_alpha_num_specials)
FIELDTYPE:invalid_sycpgm:CUSTOM(Scrubs_DL_OH.Functions.fn_check_sycpgm>0)
FIELDTYPE:invalid_sytda1:LENGTHS(16):LIKE(invalid_numeric):CUSTOM(Scrubs_DL_OH.Functions.fn_yyyymmddHHMMsss0>0)
FIELDTYPE:invalid_dvctsa:ENUM(E|N|Y|0|1|2|3|)
FIELDTYPE:invalid_dvcsce:ENUM(0|1|2|3|4|)
FIELDTYPE:invalid_dvdmce:LENGTHS(0,3,8):LIKE(invalid_alpha_num_specials)
FIELDTYPE:invalid_pigsta:CUSTOM(Scrubs_DL_OH.Functions.fn_verify_state>0)
FIELDTYPE:invalid_pigzip:LENGTHS(0,5,9,11):LIKE(invalid_numeric_blank)
FIELDTYPE:invalid_name:LIKE(invalid_wordbag):CUSTOM(Scrubs_DL_OH.Functions.fn_valid_name>0,fname,mname)
 
//FIELD DEFINITIONS
FIELD:process_date:TYPE(STRING8):LIKE(invalid_8pastdate):0,0
FIELD:dbkoln:TYPE(STRING9):LIKE(invalid_dbkoln):0,0
FIELD:pinss4:TYPE(STRING9):LIKE(invalid_pinss4):0,0
FIELD:dvnlic:TYPE(STRING8):LIKE(invalid_dvnlic):0,0
FIELD:dvccls:TYPE(STRING2):LIKE(invalid_dvccls):0,0
FIELD:dvctyp:TYPE(STRING2):LIKE(invalid_dvctyp):0,0
FIELD:pifdon:TYPE(STRING1):LIKE(invalid_pifdon):0,0
FIELD:pichcl:TYPE(STRING3):LIKE(invalid_pichcl):0,0
FIELD:picecl:TYPE(STRING3):LIKE(invalid_picecl):0,0
FIELD:piqwgt:TYPE(STRING3):LIKE(invalid_piqwgt):0,0
FIELD:pinhft:TYPE(STRING1):LIKE(invalid_height):0,0
FIELD:pinhin:TYPE(STRING2):LIKE(invalid_numeric):0,0
FIELD:picsex:TYPE(STRING1):LIKE(invalid_picsex):0,0
FIELD:dvddoi:TYPE(STRING8):LIKE(invalid_8pastdate):0,0
FIELD:dvc2pl:TYPE(STRING1):LIKE(invalid_boolean_yn_empty):0,0
FIELD:dvdexp:TYPE(STRING8):LIKE(invalid_8generaldate):0,0
FIELD:drnagy:TYPE(STRING4):LIKE(invalid_drnagy):0,0
FIELD:dvfocd:TYPE(STRING1):LIKE(invalid_dvfocd):0,0
FIELD:dvfopd:TYPE(STRING1):LIKE(invalid_boolean_yn_empty):0,0
FIELD:dvnapp:TYPE(STRING8):LIKE(invalid_dvnlic):0,0
FIELD:dvcatt:TYPE(STRING3):LIKE(invalid_dvcatt):0,0
FIELD:dvdnov:TYPE(STRING8):LIKE(invalid_08generaldate):0,0
FIELD:dvcded:TYPE(STRING1):LIKE(invalid_dvcded):0,0
FIELD:dvcgrs:TYPE(STRING42):LIKE(invalid_alpha_num):0,0
FIELD:dvfdup:TYPE(STRING1):LIKE(invalid_boolean_yn_empty):0,0
FIELD:dvcgen:TYPE(STRING10):LIKE(invalid_dvcgen):0,0
FIELD:dvflsd:TYPE(STRING1):LIKE(invalid_boolean_yn_empty):0,0
FIELD:dvqdup:TYPE(STRING1):LIKE(invalid_dvqdup):0,0
FIELD:dvfohr:TYPE(STRING1):LIKE(invalid_boolean_yn_empty):0,0
FIELD:dbkmtk:TYPE(STRING9):LIKE(invalid_dbkmtk):0,0
FIELD:dvfrcs:TYPE(STRING1):LIKE(invalid_boolean_yn_empty):0,0
FIELD:dvnwbi:TYPE(STRING2):LIKE(invalid_dvnwbi):0,0
FIELD:sycpgm:TYPE(STRING4):LIKE(invalid_sycpgm):0,0
FIELD:sytda1:TYPE(STRING16):LIKE(invalid_sytda1):0,0
FIELD:sycuid:TYPE(STRING6):LIKE(invalid_alpha_num):0,0
FIELD:dvffrd:TYPE(STRING1):LIKE(invalid_boolean_yn_empty):0,0
FIELD:dvctsa:TYPE(STRING1):LIKE(invalid_dvctsa):0,0
FIELD:dvdtsa:TYPE(STRING8):0,0
FIELD:dvdtex:TYPE(STRING8):0,0
FIELD:dvcsce:TYPE(STRING1):LIKE(invalid_dvcsce):0,0
FIELD:dvdmce:TYPE(STRING8):LIKE(invalid_dvdmce):0,0
FIELD:filler:TYPE(STRING73):0,0
FIELD:pimnam:TYPE(STRING35):0,0
FIELD:pigstr:TYPE(STRING30):0,0
FIELD:pigcty:TYPE(STRING15):LIKE(invalid_alpha_num_specials):0,0
FIELD:pigsta:TYPE(STRING2):LIKE(invalid_pigsta):0,0
FIELD:pigzip:TYPE(STRING11):LIKE(invalid_pigzip):0,0
FIELD:pincnt:TYPE(STRING2):LIKE(invalid_alpha_num_specials):0,0
FIELD:pidd01:TYPE(STRING8):LIKE(invalid_8pastdate):0,0
FIELD:piddod:TYPE(STRING8):LIKE(invalid_08pastdate):0,0
FIELD:pidaup:TYPE(STRING8):LIKE(invalid_08pastdate):0,0
FIELD:crlf:TYPE(STRING2):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:TYPE(STRING20):0,0
FIELD:mname:TYPE(STRING20):0,0
FIELD:lname:TYPE(STRING20):LIKE(invalid_name):0,0
FIELD:name_suffix:TYPE(STRING5):0,0
FIELD:cleaning_score:TYPE(STRING3):LIKE(invalid_numeric):0,0
FIELD:prim_range:TYPE(STRING10):0,0
FIELD:predir:TYPE(STRING2):0,0
FIELD:prim_name:TYPE(STRING28):0,0
FIELD:suffix:TYPE(STRING4):0,0
FIELD:postdir:TYPE(STRING2):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:TYPE(STRING25):0,0
FIELD:v_city_name:TYPE(STRING25):0,0
FIELD:state:TYPE(STRING2):0,0
FIELD:zip:TYPE(STRING5):0,0
FIELD:zip4:TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dbpc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:ace_fips_st:TYPE(STRING2):0,0
FIELD:county:TYPE(STRING3):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
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
 
