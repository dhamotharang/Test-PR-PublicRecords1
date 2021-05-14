// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Experian_Monthly';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'File';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,seq_rec_id,did,did_score_field,current_rec_flag,current_experian_pin,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,encrypted_experian_pin,social_security_number,date_of_birth,telephone,gender,additional_name_count,previous_address_count,nametype,orig_consumer_create_date,orig_fname,orig_mname,orig_lname,orig_suffix,title,fname,mname,lname,name_suffix,name_score,addressseq,orig_address_create_date,orig_address_update_date,orig_prim_range,orig_predir,orig_prim_name,orig_addr_suffix,orig_postdir,orig_unit_desig,orig_sec_range,orig_city,orig_state,orig_zipcode,orig_zipcode4,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,delete_flag,delete_file_date,suppression_code,deceased_ind';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;

  // The entire spec file
  EXPORT spcString :=
    '﻿OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Experian_Monthly\n'
    + 'FILENAME:File\n'
    + '\n'
    + '\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking\n'
    + '\n'
    + 'FIELDTYPE:seq_rec_id:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(9,8,7,6):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:did:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(10,9,12,11,8,0,7):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:did_score_field:SPACES( ):ALLOW(0189):LEFTTRIM:LENGTHS(3,0,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:current_rec_flag:SPACES( ):ALLOW(1):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:current_experian_pin:SPACES( ):ALLOW(1):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:date_first_seen:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:date_last_seen:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:date_vendor_first_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:date_vendor_last_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:encrypted_experian_pin:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(15):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:social_security_number:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(9,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:date_of_birth:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:telephone:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,10):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:gender:SPACES( ):ALLOW(ACFIMU):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:additional_name_count:SPACES( ):ALLOW(0123):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:previous_address_count:SPACES( ):ALLOW(01234567):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:nametype:SPACES( ):ALLOW(123COPS):LEFTTRIM:LENGTHS(3,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_consumer_create_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8,1,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fname:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWYZ):LEFTTRIM:LENGTHS(5,6,7,4,8,9,3,1,10,11,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mname:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(0,1,5,6,4,7,3,8,9,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_lname:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(6,7,5,8,4,9,10,3,11,12,2,13,14,15):WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_suffix:SPACES( ):ALLOW(234JS):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:title:SPACES( ):ALLOW(MRS):LEFTTRIM:LENGTHS(2,0):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:fname:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(5,6,7,4,8,9,3,1,10,11,2,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:mname:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(0,1,5,6,4,3,7,8,9,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:lname:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(6,7,5,8,4,9,10,3,11,12,13,2,14,15,1,16,17,0):WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_suffix:SPACES( ):ALLOW( ACDEGHIJLMNOPRSTUV):LEFTTRIM:LENGTHS(0,2,3):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_score:SPACES( ):ALLOW(012789):LEFTTRIM:LENGTHS(2,3):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:addressseq:SPACES( ):ALLOW(12345678):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address_create_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8,5):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address_update_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_prim_range:SPACES( ):ALLOW( -/0123456789ABNW):LEFTTRIM:LENGTHS(4,3,5,0,2,1,6,7,8):WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_predir:SPACES( ):ALLOW(ENSW):LEFTTRIM:LENGTHS(0,1,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_prim_name:SPACES( ):ALLOW( 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(6,7,8,4,5,10,9,11,12,3,13,14,15,16,1,17,2,18,19,20,21,22,23,24,25,26,27):WORDS(1,2,3,4,5,6):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_addr_suffix:SPACES( ):ALLOW(ABCDEGHIKLMNOPQRSTUVWXY):LEFTTRIM:LENGTHS(2,3,0,4):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_postdir:SPACES( ):ALLOW(ENSW):LEFTTRIM:LENGTHS(0,1,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_unit_desig:SPACES( ):ALLOW(#ABCDEFGILMNOPRSTU):LEFTTRIM:LENGTHS(0,3,1,4,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_sec_range:SPACES( ):ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVW):LEFTTRIM:LENGTHS(0,1,3,2,4,5,6):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_city:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(7,8,9,6,10,11,12,5,13,14,4,15,16,3,17,0,18,19,20,22):WORDS(1,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_state:SPACES( ):ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zipcode:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(5):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zipcode4:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(4,0):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:prim_range:SPACES( ):ALLOW( -/0123456789ABNW):LEFTTRIM:LENGTHS(4,3,5,0,2,1,6,7,8):WORDS(1,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:predir:SPACES( ):ALLOW(ENSW):LEFTTRIM:LENGTHS(0,1,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:prim_name:SPACES( ):ALLOW( 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(6,7,4,8,5,9,10,11,3,12,13,14,15,16,1,17,2,18,19,0,20,21,22,23,24):WORDS(1,2,3,4,5):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:addr_suffix:SPACES( ):ALLOW(ABCDEGHIKLMNOPQRSTUVWXY):LEFTTRIM:LENGTHS(2,3,0,4):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:postdir:SPACES( ):ALLOW(ENSW):LEFTTRIM:LENGTHS(0,1,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:unit_desig:SPACES( ):ALLOW(#ABCDEFGILMNOPRSTUX):LEFTTRIM:LENGTHS(0,3,4,1,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:sec_range:SPACES( ):ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVW):LEFTTRIM:LENGTHS(0,3,1,2,4,5,6):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:p_city_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(7,8,9,6,10,11,12,5,13,4,14,15,16,3,17,18,19,0,20):WORDS(1,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:v_city_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXY):LEFTTRIM:LENGTHS(7,8,9,6,10,11,12,5,13,14,4,16,15,3,17,18,19,20,0,22):WORDS(1,2,3,4):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:st:SPACES( ):ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:zip:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(5):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:zip4:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(4,0):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:cart:SPACES( ):ALLOW(0123456789BCHR):LEFTTRIM:LENGTHS(4,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:cr_sort_sz:SPACES( ):ALLOW(ABCD):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:lot:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(4,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:lot_order:SPACES( ):ALLOW(AD):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dbpc:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(2,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:chk_digit:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:rec_type:SPACES( ):ALLOW(DFGHMPRSU):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:county:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(5,0,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:geo_lat:SPACES( ):ALLOW(.0123456789):LEFTTRIM:LENGTHS(9,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:geo_long:SPACES( ):ALLOW(-.0123456789):LEFTTRIM:LENGTHS(10,11,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:msa:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(4,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:geo_blk:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(7,0):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:geo_match:SPACES( ):ALLOW(0145):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:err_stat:SPACES( ):ALLOW(01234589ABES):LEFTTRIM:LENGTHS(4):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:delete_flag:SPACES( ):ALLOW(1):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:delete_file_date:SPACES( ):ALLOW(0123567):LEFTTRIM:LENGTHS(0,7):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:suppression_code:SPACES( ):ALLOW(0459):LEFTTRIM:LENGTHS(0,2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:deceased_ind:SPACES( ):ALLOW(01):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELD:seq_rec_id:LIKE(seq_rec_id):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did:LIKE(did):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score_field:LIKE(did_score_field):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:current_rec_flag:LIKE(current_rec_flag):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:current_experian_pin:LIKE(current_experian_pin):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:date_first_seen:LIKE(date_first_seen):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:date_last_seen:LIKE(date_last_seen):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:date_vendor_first_reported:LIKE(date_vendor_first_reported):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:date_vendor_last_reported:LIKE(date_vendor_last_reported):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:encrypted_experian_pin:LIKE(encrypted_experian_pin):TYPE(STRING15):0,0\n'
    + 'FIELD:social_security_number:LIKE(social_security_number):TYPE(STRING9):0,0\n'
    + 'FIELD:date_of_birth:LIKE(date_of_birth):TYPE(STRING8):0,0\n'
    + 'FIELD:telephone:LIKE(telephone):TYPE(STRING10):0,0\n'
    + 'FIELD:gender:LIKE(gender):TYPE(STRING1):0,0\n'
    + 'FIELD:additional_name_count:LIKE(additional_name_count):TYPE(STRING2):0,0\n'
    + 'FIELD:previous_address_count:LIKE(previous_address_count):TYPE(STRING2):0,0\n'
    + 'FIELD:nametype:LIKE(nametype):TYPE(STRING3):0,0\n'
    + 'FIELD:orig_consumer_create_date:LIKE(orig_consumer_create_date):TYPE(STRING8):0,0\n'
    + 'FIELD:orig_fname:LIKE(orig_fname):TYPE(STRING32):0,0\n'
    + 'FIELD:orig_mname:LIKE(orig_mname):TYPE(STRING32):0,0\n'
    + 'FIELD:orig_lname:LIKE(orig_lname):TYPE(STRING32):0,0\n'
    + 'FIELD:orig_suffix:LIKE(orig_suffix):TYPE(STRING3):0,0\n'
    + 'FIELD:title:LIKE(title):TYPE(STRING5):0,0\n'
    + 'FIELD:fname:LIKE(fname):TYPE(STRING20):0,0\n'
    + 'FIELD:mname:LIKE(mname):TYPE(STRING20):0,0\n'
    + 'FIELD:lname:LIKE(lname):TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:LIKE(name_suffix):TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:LIKE(name_score):TYPE(STRING3):0,0\n'
    + 'FIELD:addressseq:LIKE(addressseq):TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:orig_address_create_date:LIKE(orig_address_create_date):TYPE(STRING8):0,0\n'
    + 'FIELD:orig_address_update_date:LIKE(orig_address_update_date):TYPE(STRING8):0,0\n'
    + 'FIELD:orig_prim_range:LIKE(orig_prim_range):TYPE(STRING10):0,0\n'
    + 'FIELD:orig_predir:LIKE(orig_predir):TYPE(STRING2):0,0\n'
    + 'FIELD:orig_prim_name:LIKE(orig_prim_name):TYPE(STRING32):0,0\n'
    + 'FIELD:orig_addr_suffix:LIKE(orig_addr_suffix):TYPE(STRING4):0,0\n'
    + 'FIELD:orig_postdir:LIKE(orig_postdir):TYPE(STRING2):0,0\n'
    + 'FIELD:orig_unit_desig:LIKE(orig_unit_desig):TYPE(STRING4):0,0\n'
    + 'FIELD:orig_sec_range:LIKE(orig_sec_range):TYPE(STRING8):0,0\n'
    + 'FIELD:orig_city:LIKE(orig_city):TYPE(STRING32):0,0\n'
    + 'FIELD:orig_state:LIKE(orig_state):TYPE(STRING6):0,0\n'
    + 'FIELD:orig_zipcode:LIKE(orig_zipcode):TYPE(STRING5):0,0\n'
    + 'FIELD:orig_zipcode4:LIKE(orig_zipcode4):TYPE(STRING5):0,0\n'
    + 'FIELD:prim_range:LIKE(prim_range):TYPE(STRING10):0,0\n'
    + 'FIELD:predir:LIKE(predir):TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:LIKE(prim_name):TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:LIKE(addr_suffix):TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:LIKE(postdir):TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:LIKE(unit_desig):TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:LIKE(sec_range):TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:LIKE(p_city_name):TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:LIKE(v_city_name):TYPE(STRING25):0,0\n'
    + 'FIELD:st:LIKE(st):TYPE(STRING2):0,0\n'
    + 'FIELD:zip:LIKE(zip):TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:LIKE(zip4):TYPE(STRING4):0,0\n'
    + 'FIELD:cart:LIKE(cart):TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:LIKE(cr_sort_sz):TYPE(STRING1):0,0\n'
    + 'FIELD:lot:LIKE(lot):TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:LIKE(lot_order):TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:LIKE(dbpc):TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:LIKE(chk_digit):TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:LIKE(rec_type):TYPE(STRING2):0,0\n'
    + 'FIELD:county:LIKE(county):TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:LIKE(geo_lat):TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:LIKE(geo_long):TYPE(STRING11):0,0\n'
    + 'FIELD:msa:LIKE(msa):TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:LIKE(geo_blk):TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:LIKE(geo_match):TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:LIKE(err_stat):TYPE(STRING4):0,0\n'
    + 'FIELD:delete_flag:LIKE(delete_flag):TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:delete_file_date:LIKE(delete_file_date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:suppression_code:LIKE(suppression_code):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:deceased_ind:LIKE(deceased_ind):TYPE(UNSIGNED1):0,0\n'
    + '\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
