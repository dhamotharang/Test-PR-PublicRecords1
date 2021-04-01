Generated by SALT V3.11.11
Command line options: -DC:\\Users\\granjo01\\code\\gitlab\\PublicRecords 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_IDA
FILENAME:IDA
NAMESCOPE:Base

FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Rec_ID:ALLOW(0123456789_):LENGTHS(15)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_IDA.Functions.Fn_Valid_Date > 0)
FIELDTYPE:Invalid_FName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ-):LENGTHS(2..15):WORDS(0,1)
FIELDTYPE:Invalid_MName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.):LENGTHS(0..2):WORDS(0,1)
FIELDTYPE:Invalid_LName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.-):LENGTHS(2..20):WORDS(0..2)
FIELDTYPE:Invalid_Suffix:SPACES( ):ALLOW(SRJr.IVXPHMD):LENGTHS(0,1,2,3):WORDS(0,1)
FIELDTYPE:Invalid_Title:SPACES( ):ALLOW(DMRS):LENGTHS(0,1,2,3):WORDS(0,1)
FIELDTYPE:Invalid_Address1:SPACES( .):LIKE(Invalid_AlphaNum):WORDS(0..7)
FIELDTYPE:Invalid_Address2:SPACES( #):LIKE(Invalid_AlphaNum):WORDS(0..2)
FIELDTYPE:Invalid_City:SPACES( ):LIKE(Invalid_Alpha):WORDS(0..4)
FIELDTYPE:Invalid_State:CUSTOM(Scrubs.Functions.fn_verify_state > 0)
FIELDTYPE:Invalid_Zip:LIKE(Invalid_Num):LENGTHS(0,5)
FIELDTYPE:Invalid_Zip4:LIKE(Invalid_Num):LENGTHS(0,4)
FIELDTYPE:Invalid_SSN:LIKE(Invalid_Num):LENGTHS(0,9)
FIELDTYPE:Invalid_DL:CUSTOM(Scrubs_IDA.Functions.Fn_Valid_DL > 0)
FIELDTYPE:Invalid_Phone:ALLOW(0123456789):LENGTHS(0,10)
FIELDTYPE:Invalid_Clientassigneduniquerecordid:ALLOW(nfr0123456789):LENGTHS(18)
FIELDTYPE:Invalid_Emailaddress:CUSTOM(Scrubs.Functions.fn_valid_email > 0)
FIELDTYPE:Invalid_Ipaddress:CUSTOM(Scrubs.Functions.fn_valid_IP > 0)
FIELDTYPE:Invalid_NID:LIKE(Invalid_Num):LENGTHS(0,18,19,20)
FIELDTYPE:Invalid_Dir:ALLOW(NESW):LENGTHS(0..2)
FIELDTYPE:Invalid_Add:SPACES( ):LIKE(Invalid_AlphaNum):WORDS(0..3)
FIELDTYPE:Invalid_Add_Suff:LIKE(Invalid_AlphaNum):LENGTHS(0,2..4)
FIELDTYPE:Invalid_Coor:CUSTOM(Scrubs.Functions.fn_geo_coord > 0)
FIELDTYPE:Invalid_Err:LIKE(Invalid_AlphaNum):LENGTHS(4)
FIELDTYPE:Invalid_AID:LIKE(Invalid_Num):LENGTHS(12)

FIELD:persistent_record_id:TYPE(STRING19):LIKE(Invalid_Rec_ID):0,0
FIELD:src:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:dt_first_seen:TYPE(UNSIGNED6):LIKE(Invalid_Date):0,0
FIELD:dt_last_seen:TYPE(UNSIGNED6):LIKE(Invalid_Date):0,0
FIELD:dt_vendor_first_reported:TYPE(UNSIGNED6):LIKE(Invalid_Date):0,0
FIELD:dt_vendor_last_reported:TYPE(UNSIGNED6):LIKE(Invalid_Date):0,0
FIELD:did:TYPE(UNSIGNED6):LIKE(Invalid_Num):0,0
FIELD:did_score:TYPE(UNSIGNED1):LIKE(Invalid_Num):0,0
FIELD:orig_first_name:TYPE(STRING):LIKE(Invalid_FName):0,0
FIELD:orig_middle_name:TYPE(STRING):LIKE(Invalid_MName):0,0
FIELD:orig_last_name:TYPE(STRING):LIKE(Invalid_LName):0,0
FIELD:orig_suffix:TYPE(STRING3):LIKE(Invalid_Suffix):0,0
FIELD:orig_address1:TYPE(STRING):LIKE(Invalid_Address1):0,0
FIELD:orig_address2:TYPE(STRING):LIKE(Invalid_Address2):0,0
FIELD:orig_city:TYPE(STRING):LIKE(Invalid_City):0,0
FIELD:orig_state_province:TYPE(STRING):LIKE(Invalid_State):0,0
FIELD:orig_zip4:TYPE(STRING):LIKE(Invalid_Zip):0,0
FIELD:orig_zip5:TYPE(STRING):LIKE(Invalid_Zip):0,0
FIELD:orig_dob:TYPE(UNSIGNED4):LIKE(Invalid_Date):0,0
FIELD:orig_ssn:TYPE(STRING12):LIKE(Invalid_SSN):0,0
FIELD:orig_dl:TYPE(STRING12):LIKE(Invalid_DL):0,0
FIELD:orig_dlstate:TYPE(STRING5):LIKE(Invalid_State):0,0
FIELD:orig_phone:TYPE(STRING):LIKE(Invalid_Phone):0,0
FIELD:clientassigneduniquerecordid:TYPE(STRING):LIKE(Invalid_Clientassigneduniquerecordid):0,0
FIELD:adl_ind:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:orig_email:TYPE(STRING):LIKE(Invalid_Emailaddress):0,0
FIELD:orig_ipaddress:TYPE(STRING15):LIKE(Invalid_Ipaddress):0,0
FIELD:orig_filecategory:TYPE(STRING):0,0
FIELD:title:TYPE(STRING5):LIKE(Invalid_Title):0,0
FIELD:fname:TYPE(STRING20):LIKE(Invalid_FName):0,0
FIELD:mname:TYPE(STRING20):LIKE(Invalid_MName):0,0
FIELD:lname:TYPE(STRING20):LIKE(Invalid_LName):0,0
FIELD:name_suffix:TYPE(STRING5):LIKE(Invalid_Suffix):0,0
FIELD:nid:TYPE(UNSIGNED8):LIKE(Invalid_NID):0,0
FIELD:prim_range:TYPE(STRING10):LIKE(Invalid_Num):0,0
FIELD:predir:TYPE(STRING2):LIKE(Invalid_Dir):0,0
FIELD:prim_name:TYPE(STRING28):LIKE(Invalid_Add):0,0
FIELD:addr_suffix:TYPE(STRING4):LIKE(Invalid_Add_Suff):0,0
FIELD:postdir:TYPE(STRING2):LIKE(Invalid_Dir):0,0
FIELD:unit_desig:TYPE(STRING10):LIKE(Invalid_Add_Suff):0,0
FIELD:sec_range:TYPE(STRING8):LIKE(Invalid_Num):0,0
FIELD:p_city_name:TYPE(STRING25):LIKE(Invalid_City):0,0
FIELD:v_city_name:TYPE(STRING25):LIKE(Invalid_City):0,0
FIELD:st:TYPE(STRING2):LIKE(Invalid_State):0,0
FIELD:zip:TYPE(STRING5):LIKE(Invalid_Zip):0,0
FIELD:zip4:TYPE(STRING4):LIKE(Invalid_Zip4):0,0
FIELD:cart:TYPE(STRING4):LIKE(Invalid_AlphaNum):0,0
FIELD:cr_sort_sz:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:lot:TYPE(STRING4):LIKE(Invalid_Num):0,0
FIELD:lot_order:TYPE(STRING1):LIKE(Invalid_Alpha):0,0
FIELD:dbpc:TYPE(STRING2):LIKE(Invalid_Num):0,0
FIELD:chk_digit:TYPE(STRING1):LIKE(Invalid_Num):0,0
FIELD:rec_type:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:fips_st:TYPE(STRING2):LIKE(Invalid_Num):0,0
FIELD:fips_county:TYPE(STRING3):LIKE(Invalid_Num):0,0
FIELD:geo_lat:TYPE(STRING10):LIKE(Invalid_Coor):0,0
FIELD:geo_long:TYPE(STRING11):LIKE(Invalid_Coor):0,0
FIELD:msa:TYPE(STRING4):LIKE(Invalid_Num):0,0
FIELD:geo_blk:TYPE(STRING7):LIKE(Invalid_Num):0,0
FIELD:geo_match:TYPE(STRING1):LIKE(Invalid_Num):0,0
FIELD:err_stat:TYPE(STRING4):LIKE(Invalid_Err):0,0
FIELD:rawaid:TYPE(UNSIGNED8):LIKE(Invalid_AID):0,0
FIELD:aceaid:TYPE(UNSIGNED8):LIKE(Invalid_AID):0,0
FIELD:clean_phone:TYPE(STRING10):LIKE(Invalid_Phone):0,0
FIELD:clean_dob:TYPE(STRING8):LIKE(Invalid_Date):0,0

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


