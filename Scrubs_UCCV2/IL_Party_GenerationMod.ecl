// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT IL_Party_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_UCCV2';
  EXPORT spc_NAMESCOPE := 'IL_Party';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'UCCV2';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,tmsid,rmsid,orig_name,orig_lname,orig_fname,orig_mname,orig_suffix,duns_number,hq_duns_number,ssn,fein,incorp_state,corp_number,corp_type,orig_address1,orig_address2,orig_city,orig_state,orig_zip5,orig_zip4,orig_country,orig_province,orig_postal_code,foreign_indc,party_type,dt_first_seen,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported,process_date,title,fname,mname,lname,name_suffix,name_score,company_name,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip5,zip4,county,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_st,ace_fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,bdid,did,did_score,bdid_score,source_rec_id,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,prep_addr_line1,prep_addr_last_line,rawaid,aceaid,persistent_record_id';
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
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_UCCV2\n'
    + 'FILENAME:UCCV2\n'
    + 'NAMESCOPE:IL_Party\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + '\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0)\n'
    + 'FIELDTYPE:invalid_empty:LENGTHS(0)\n'
    + 'FIELDTYPE:invalid_zero_integer:ENUM(0|)\n'
    + 'FIELDTYPE:invalid_boolean_yn:ENUM(N|Y)\n'
    + 'FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_UCCV2.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_pastdate6:CUSTOM(Scrubs_UCCV2.Functions.fn_past_yyyymm>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_tmsid:CUSTOM(Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid>0,\'IL\')\n'
    + 'FIELDTYPE:invalid_rmsid:CUSTOM(Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid>0,\'IL\')\n'
    + 'FIELDTYPE:invalid_orig_name:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,orig_lname,orig_fname)\n'
    + 'FIELDTYPE:invalid_orig_lname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,orig_name,orig_fname)\n'
    + 'FIELDTYPE:invalid_orig_fname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,orig_name,orig_lname)\n'
    + 'FIELDTYPE:invalid_orig_address1:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,orig_city,orig_state)\n'
    + 'FIELDTYPE:invalid_orig_state:CUSTOM(Scrubs_UCCV2.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_orig_zip5:CUSTOM(Scrubs_UCCV2.Functions.fn_verify_zip5_country>0,orig_country)\n'
    + 'FIELDTYPE:invalid_party_type:ENUM(D|S)\n'
    + 'FIELDTYPE:invalid_fname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,mname,lname,company_name)\n'
    + 'FIELDTYPE:invalid_mname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,fname,lname,company_name)\n'
    + 'FIELDTYPE:invalid_lname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,fname,mname,company_name)\n'
    + 'FIELDTYPE:invalid_company_name:CUSTOM(Scrubs_UCCV2.Functions.fn_company_xor_person>0,fname,mname,lname)\n'
    + '\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:tmsid:TYPE(STRING31):LIKE(invalid_tmsid):0,0\n'
    + 'FIELD:rmsid:TYPE(STRING23):LIKE(invalid_rmsid):0,0\n'
    + 'FIELD:orig_name:TYPE(STRING120):LIKE(invalid_orig_name):0,0\n'
    + 'FIELD:orig_lname:TYPE(STRING25):LIKE(invalid_orig_lname):0,0\n'
    + 'FIELD:orig_fname:TYPE(STRING25):LIKE(invalid_orig_fname):0,0\n'
    + 'FIELD:orig_mname:TYPE(STRING35):0,0\n'
    + 'FIELD:orig_suffix:TYPE(STRING10):0,0\n'
    + 'FIELD:duns_number:TYPE(STRING9):LIKE(invalid_empty):0,0\n'
    + 'FIELD:hq_duns_number:TYPE(STRING9):LIKE(invalid_empty):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):LIKE(invalid_empty):0,0\n'
    + 'FIELD:fein:TYPE(STRING10):LIKE(invalid_empty):0,0\n'
    + 'FIELD:incorp_state:TYPE(STRING45):LIKE(invalid_empty):0,0\n'
    + 'FIELD:corp_number:TYPE(STRING30):LIKE(invalid_empty):0,0\n'
    + 'FIELD:corp_type:TYPE(STRING30):LIKE(invalid_empty):0,0\n'
    + 'FIELD:orig_address1:TYPE(STRING60):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:orig_address2:TYPE(STRING60):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING30):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING2):LIKE(invalid_orig_state):0,0\n'
    + 'FIELD:orig_zip5:TYPE(STRING5):LIKE(invalid_orig_zip5):0,0\n'
    + 'FIELD:orig_zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_country:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_province:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_postal_code:TYPE(STRING9):0,0\n'
    + 'FIELD:foreign_indc:TYPE(STRING1):LIKE(invalid_boolean_yn):0,0\n'
    + 'FIELD:party_type:TYPE(STRING1):LIKE(invalid_party_type):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED6):LIKE(invalid_pastdate6):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED6):LIKE(invalid_pastdate6):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED6):LIKE(invalid_pastdate6):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED6):LIKE(invalid_pastdate6):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):LIKE(invalid_fname):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):LIKE(invalid_mname):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):LIKE(invalid_lname):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:company_name:TYPE(STRING60):LIKE(invalid_company_name):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):LIKE(invalid_empty):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(invalid_empty):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(invalid_empty):0,0\n'
    + 'FIELD:suffix:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(invalid_empty):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):LIKE(invalid_empty):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):LIKE(invalid_empty):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_empty):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_empty):0,0\n'
    + 'FIELD:st:TYPE(STRING2):LIKE(invalid_empty):0,0\n'
    + 'FIELD:zip5:TYPE(STRING5):LIKE(invalid_empty):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:county:TYPE(STRING3):LIKE(invalid_empty):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):LIKE(invalid_empty):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):LIKE(invalid_empty):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):LIKE(invalid_empty):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):LIKE(invalid_empty):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):LIKE(invalid_empty):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):LIKE(invalid_empty):0,0\n'
    + 'FIELD:ace_fips_county:TYPE(STRING3):LIKE(invalid_empty):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):LIKE(invalid_empty):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):LIKE(invalid_empty):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):LIKE(invalid_empty):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):LIKE(invalid_empty):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:bdid_score:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_last_line:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:rawaid:TYPE(UNSIGNED8):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:aceaid:TYPE(UNSIGNED8):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:persistent_record_id:TYPE(UNSIGNED8):LIKE(invalid_zero_integer):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

