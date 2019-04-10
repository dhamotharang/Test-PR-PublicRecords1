// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'DunnData_email';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'RCID'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'DunnData_email';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:RCID';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dtmatch,email,name_full,address1,address2,city,state,zip5,zip_ext,ipaddr,datestamp,url,lastdate,em_src_cnt,num_emails,num_indiv,persistent_record_id,did,did_score,clean_title,clean_fname,clean_mname,clean_lname,clean_name_suffix,clean_name_score,rawaid,append_prep_address_situs,append_prep_address_last_situs,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,process_date,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,clean_cname,current_rec,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    'OPTIONS:-gn\n'
    + 'MODULE:DunnData_email\n'
    + 'FILENAME:DunnData_email\n'
    + '\n'
    + 'RIDFIELD:RCID:GENERATE\n'
    + 'INGESTFILE:DunnData_update:NAMED(DunnData_email.prep_ingest_file)\n'
    + '\n'
    + '\n'
    + 'FIELD:dtmatch:TYPE(STRING32):0,0\n'
    + 'FIELD:email:TYPE(STRING60):0,0\n'
    + 'FIELD:name_full:TYPE(STRING50):0,0\n'
    + 'FIELD:address1:TYPE(STRING50):0,0\n'
    + 'FIELD:address2:TYPE(STRING50):0,0\n'
    + 'FIELD:city:TYPE(STRING20):0,0\n'
    + 'FIELD:state:TYPE(STRING2):0,0\n'
    + 'FIELD:zip5:TYPE(STRING5):0,0\n'
    + 'FIELD:zip_ext:TYPE(STRING4):0,0\n'
    + 'FIELD:ipaddr:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:datestamp:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:url:TYPE(STRING100):0,0\n'
    + 'FIELD:lastdate:TYPE(STRING10):0,0\n'
    + 'FIELD:em_src_cnt:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:num_emails:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:num_indiv:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:persistent_record_id:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did_score:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:clean_title:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_fname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_mname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_lname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_suffix:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_score:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:rawaid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:append_prep_address_situs:DERIVED:TYPE(STRING77):0,0\n'
    + 'FIELD:append_prep_address_last_situs:DERIVED:TYPE(STRING54):0,0\n'
    + 'FIELD:prim_range:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:st:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:county:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:DERIVED:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:clean_cname:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:current_rec:DERIVED:TYPE(BOOLEAN1):0,0\n'
    + '\n'
    + '//BIP addition\n'
    + 'FIELD:dotid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

