// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Email_DataV2';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'email_src';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Email_DataV2';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,clean_email,append_email_username,append_domain,append_domain_type,append_domain_root,append_domain_ext,append_is_tld_state,append_is_tld_generic,append_is_tld_country,append_is_valid_domain_ext,email_rec_key,email_src,orig_pmghousehold_id,orig_pmgindividual_id,orig_first_name,orig_last_name,orig_middle_name,orig_name_suffix,orig_address,orig_city,orig_state,orig_zip,orig_zip4,orig_email,orig_ip,orig_login_date,orig_site,orig_e360_id,orig_teramedia_id,orig_phone,orig_ssn,orig_dob,did,did_score,did_type,hhid,title,fname,mname,lname,name_suffix,name_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,append_rawaid,clean_phone,clean_ssn,clean_dob,process_date,activecode,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,current_rec,orig_companyname,cln_companyname,companytitle,rules,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,global_sid,record_sid';
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
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Email_DataV2\n'
    + 'FILENAME:Email_DataV2\n'
    + '\n'
    + 'SOURCEFIELD:email_src\n'
    + '\n'
    + 'FIELD:clean_email:TYPE(STRING200):0,0\n'
    + 'FIELD:append_email_username:TYPE(STRING100):0,0\n'
    + 'FIELD:append_domain:TYPE(STRING120):0,0\n'
    + 'FIELD:append_domain_type:TYPE(STRING12):0,0\n'
    + 'FIELD:append_domain_root:TYPE(STRING100):0,0\n'
    + 'FIELD:append_domain_ext:TYPE(STRING20):0,0\n'
    + 'FIELD:append_is_tld_state:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:append_is_tld_generic:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:append_is_tld_country:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:append_is_valid_domain_ext:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:email_rec_key:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:email_src:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_pmghousehold_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_pmgindividual_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_first_name:TYPE(STRING):0,0\n'
    + 'FIELD:orig_last_name:TYPE(STRING):0,0\n'
    + 'FIELD:orig_middle_name:TYPE(STRING):0,0\n'
    + 'FIELD:orig_name_suffix:TYPE(STRING):0,0\n'
    + 'FIELD:orig_address:TYPE(STRING):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING):0,0\n'
    + 'FIELD:orig_zip:TYPE(STRING):0,0\n'
    + 'FIELD:orig_zip4:TYPE(STRING):0,0\n'
    + 'FIELD:orig_email:TYPE(STRING):0,0\n'
    + 'FIELD:orig_ip:TYPE(STRING):0,0\n'
    + 'FIELD:orig_login_date:TYPE(STRING):0,0\n'
    + 'FIELD:orig_site:TYPE(STRING):0,0\n'
    + 'FIELD:orig_e360_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_teramedia_id:TYPE(STRING):0,0\n'
    + 'FIELD:orig_phone:TYPE(STRING):0,0\n'
    + 'FIELD:orig_ssn:TYPE(STRING):0,0\n'
    + 'FIELD:orig_dob:TYPE(STRING):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did_type:TYPE(STRING10):0,0\n'
    + 'FIELD:hhid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:county:TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:append_rawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:clean_phone:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:clean_dob:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):0,0\n'
    + 'FIELD:activecode:TYPE(STRING1):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):0,0\n'
    + 'FIELD:current_rec:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:orig_companyname:TYPE(STRING):0,0\n'
    + 'FIELD:cln_companyname:TYPE(STRING):0,0\n'
    + 'FIELD:companytitle:TYPE(STRING):0,0\n'
    + 'FIELD:rules:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:global_sid:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:TYPE(UNSIGNED8):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

