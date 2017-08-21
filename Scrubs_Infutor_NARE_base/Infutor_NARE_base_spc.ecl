MODULE:Scrubs_Infutor_NARE_base
FILENAME:Infutor_NARE_base
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking


FIELDTYPE:invalid_alnum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -/):LENGTHS(0..)
FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -,&\/.:;_+):LENGTHS(0..)
FIELDTYPE:invalid_numeric:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:invalid_address:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -&/\#.;,):LENGTHS(0..)
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_zip:ALLOW(0123456789):SPACES( -):LENGTHS(10,9,5,0)
FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( ):LENGTHS(8,1,0)
FIELDTYPE:invalid_dob:ALLOW(0123456789):SPACES( ):LENGTHS(8,4,6,0)
FIELDTYPE:invalid_gender:ENUM(M|F|U| ):LENGTHS(1,0)
FIELDTYPE:invalid_email:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -@&._!?/):LENGTHS(1..)
FIELDTYPE:invalid_ip:ALLOW(0123456789):SPACES( .):LENGTHS(0..)
FIELDTYPE:invalid_phone:ALLOW(0123456789):SPACES( ):LENGTHS(10,0)
FIELDTYPE:invalid_blank:LENGTHS(1..)

FIELD:idnum:LIKE(invalid_numeric):TYPE(STRING50):0,0
FIELD:firstname:LIKE(invalid_name):TYPE(STRING50):0,0
FIELD:middlename:LIKE(invalid_name):TYPE(STRING50):0,0
FIELD:lastname:LIKE(invalid_name):TYPE(STRING50):0,0
FIELD:suffix:LIKE(invalid_name):TYPE(STRING10):0,0
FIELD:rectype:TYPE(STRING1):0,0
FIELD:gender:LIKE(invalid_gender):TYPE(STRING1):0,0
FIELD:dob:LIKE(invalid_dob):TYPE(STRING8):0,0
FIELD:addrline1:TYPE(STRING64):0,0
FIELD:streetnum:TYPE(STRING10):0,0
FIELD:streetpredir:TYPE(STRING2):0,0
FIELD:streetname:TYPE(STRING28):0,0
FIELD:streetsuffix:TYPE(STRING4):0,0
FIELD:streetpostdir:TYPE(STRING2):0,0
FIELD:apttype:TYPE(STRING4):0,0
FIELD:aptnum:TYPE(STRING8):0,0
FIELD:city:TYPE(STRING28):0,0
FIELD:state:TYPE(STRING2):0,0
FIELD:zipcode:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:zipplus4:LIKE(invalid_numeric):TYPE(STRING4):0,0
FIELD:dpc:TYPE(STRING3):0,0
FIELD:z4type:TYPE(STRING1):0,0
FIELD:crte:TYPE(STRING4):0,0
FIELD:fipscounty:TYPE(STRING3):0,0
FIELD:dpv:TYPE(STRING3):0,0
FIELD:vacantflag:TYPE(STRING3):0,0
FIELD:phone:LIKE(invalid_phone):TYPE(STRING10):0,0
FIELD:phone2:LIKE(invalid_phone):TYPE(STRING10):0,0
FIELD:email:TYPE(STRING100):0,0
FIELD:url:TYPE(STRING100):0,0
FIELD:ipaddr:TYPE(STRING100):0,0
FIELD:wesitetype:TYPE(STRING100):0,0
FIELD:datefirstseen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:datelastseen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:filedate:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:confidencescore:TYPE(STRING1):0,0
FIELD:occurance:TYPE(STRING10):0,0
FIELD:persistid:TYPE(STRING10):0,0
FIELD:emailsuppressioncd:TYPE(STRING50):0,0
FIELD:age:LIKE(invalid_numeric):TYPE(STRING2):0,0
FIELD:persistent_record_id:TYPE(UNSIGNED8):0,0
FIELD:did:TYPE(UNSIGNED8):0,0
FIELD:did_score:TYPE(UNSIGNED8):0,0
FIELD:clean_title:LIKE(invalid_alnum):TYPE(STRING5):0,0
FIELD:clean_fname:LIKE(invalid_alnum):TYPE(STRING20):0,0
FIELD:clean_mname:LIKE(invalid_alnum):TYPE(STRING20):0,0
FIELD:clean_lname:LIKE(invalid_alnum):TYPE(STRING20):0,0
FIELD:clean_name_suffix:LIKE(invalid_alnum):TYPE(STRING5):0,0
FIELD:clean_name_score:TYPE(STRING3):0,0
FIELD:rawaid:TYPE(UNSIGNED8):0,0
FIELD:append_prep_address_situs:TYPE(STRING77):0,0
FIELD:append_prep_address_last_situs:TYPE(STRING54):0,0
FIELD:clean_prim_range:LIKE(invalid_alnum):TYPE(STRING10):0,0
FIELD:clean_predir:LIKE(invalid_alnum):TYPE(STRING2):0,0
FIELD:clean_prim_name:LIKE(invalid_alnum):TYPE(STRING28):0,0
FIELD:clean_addr_suffix:LIKE(invalid_alnum):TYPE(STRING4):0,0
FIELD:clean_postdir:LIKE(invalid_alnum):TYPE(STRING2):0,0
FIELD:clean_unit_desig:TYPE(STRING10):0,0
FIELD:clean_sec_range:TYPE(STRING8):0,0
FIELD:clean_p_city_name:LIKE(invalid_alnum):TYPE(STRING25):0,0
FIELD:clean_v_city_name:LIKE(invalid_alnum):TYPE(STRING25):0,0
FIELD:clean_st:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:clean_zip:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:clean_zip4:LIKE(invalid_numeric):TYPE(STRING4):0,0
FIELD:clean_cart:TYPE(STRING4):0,0
FIELD:clean_cr_sort_sz:TYPE(STRING1):0,0
FIELD:clean_lot:TYPE(STRING4):0,0
FIELD:clean_lot_order:TYPE(STRING1):0,0
FIELD:clean_dbpc:TYPE(STRING2):0,0
FIELD:clean_chk_digit:TYPE(STRING1):0,0
FIELD:clean_rec_type:TYPE(STRING2):0,0
FIELD:clean_county:TYPE(STRING5):0,0
FIELD:clean_geo_lat:TYPE(STRING10):0,0
FIELD:clean_geo_long:TYPE(STRING11):0,0
FIELD:clean_msa:TYPE(STRING4):0,0
FIELD:clean_geo_blk:TYPE(STRING7):0,0
FIELD:clean_geo_match:TYPE(STRING1):0,0
FIELD:clean_err_stat:TYPE(STRING4):0,0
FIELD:process_date:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_first_seen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_last_seen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_vendor_first_reported:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_vendor_last_reported:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:current_rec_flag:TYPE(STRING1):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
