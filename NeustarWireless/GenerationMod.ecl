// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'NeustarWireless';
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
  EXPORT spc_FILENAME := 'MAIN';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,phone,fname,mname,lname,salutation,suffix,gender,dob,house,pre_dir,street,street_type,post_dir,apt_type,apt_nbr,zip,plus4,dpc,z4_type,crte,city,state,dpvcmra,dpvconf,fips_state,fips_county,census_tract,census_block_group,cbsa,match_code,latitude,longitude,email,verified,activity_status,prepaid,cord_cutter,raw_file_name,rcid,source,persistent_record_id,did,did_score,xadl2_weight,xadl2_score,xadl2_keys_used,xadl2_distance,xadl2_matches,append_prep_address_1,append_prep_address_2,rawaid,aceaid,clean_address.prim_range,clean_address.predir,clean_address.prim_name,clean_address.addr_suffix,clean_address.postdir,clean_address.unit_desig,clean_address.sec_range,clean_address.p_city_name,clean_address.v_city_name,clean_address.st,clean_address.zip,clean_address.zip4,clean_address.cart,clean_address.cr_sort_sz,clean_address.lot,clean_address.lot_order,clean_address.dbpc,clean_address.chk_digit,clean_address.rec_type,clean_address.county,clean_address.geo_lat,clean_address.geo_long,clean_address.msa,clean_address.geo_blk,clean_address.geo_match,clean_address.err_stat,append_prep_name,nid,name_ind,nametype,cln_title,cln_fname,cln_mname,cln_lname,cln_suffix,cln_fullname,process_date,process_time,date_vendor_first_reported,date_vendor_last_reported,current_rec,ingest_tpe';
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
    + 'MODULE:NeustarWireless\n'
    + 'FILENAME:MAIN\n'
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
    + 'FIELD:phone:TYPE(STRING10):0,0\n'
    + 'FIELD:fname:TYPE(STRING15):0,0\n'
    + 'FIELD:mname:TYPE(STRING1):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:salutation:TYPE(STRING5):0,0\n'
    + 'FIELD:suffix:TYPE(STRING3):0,0\n'
    + 'FIELD:gender:TYPE(STRING1):0,0\n'
    + 'FIELD:dob:TYPE(STRING8):0,0\n'
    + 'FIELD:house:TYPE(STRING10):0,0\n'
    + 'FIELD:pre_dir:TYPE(STRING2):0,0\n'
    + 'FIELD:street:TYPE(STRING28):0,0\n'
    + 'FIELD:street_type:TYPE(STRING4):0,0\n'
    + 'FIELD:post_dir:TYPE(STRING2):0,0\n'
    + 'FIELD:apt_type:TYPE(STRING4):0,0\n'
    + 'FIELD:apt_nbr:TYPE(STRING8):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:plus4:TYPE(STRING4):0,0\n'
    + 'FIELD:dpc:TYPE(STRING1):0,0\n'
    + 'FIELD:z4_type:TYPE(STRING1):0,0\n'
    + 'FIELD:crte:TYPE(STRING4):0,0\n'
    + 'FIELD:city:TYPE(STRING28):0,0\n'
    + 'FIELD:state:TYPE(STRING2):0,0\n'
    + 'FIELD:dpvcmra:TYPE(STRING1):0,0\n'
    + 'FIELD:dpvconf:TYPE(STRING1):0,0\n'
    + 'FIELD:fips_state:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:census_tract:TYPE(STRING6):0,0\n'
    + 'FIELD:census_block_group:TYPE(STRING1):0,0\n'
    + 'FIELD:cbsa:TYPE(STRING5):0,0\n'
    + 'FIELD:match_code:TYPE(STRING3):0,0\n'
    + 'FIELD:latitude:TYPE(REAL8):0,0\n'
    + 'FIELD:longitude:TYPE(REAL8):0,0\n'
    + 'FIELD:email:TYPE(STRING100):0,0\n'
    + 'FIELD:verified:TYPE(STRING1):0,0\n'
    + 'FIELD:activity_status:TYPE(STRING2):0,0\n'
    + 'FIELD:prepaid:TYPE(STRING1):0,0\n'
    + 'FIELD:cord_cutter:TYPE(STRING1):0,0\n'
    + 'FIELD:raw_file_name:TYPE(STRING75):0,0\n'
    + 'FIELD:rcid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:source:TYPE(STRING2):0,0\n'
    + 'FIELD:persistent_record_id:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:xadl2_weight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:xadl2_score:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:xadl2_keys_used:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:xadl2_distance:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:xadl2_matches:TYPE(STRING20):0,0\n'
    + 'FIELD:append_prep_address_1:TYPE(STRING):0,0\n'
    + 'FIELD:append_prep_address_2:TYPE(STRING):0,0\n'
    + 'FIELD:rawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:aceaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:clean_address.prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_address.predir:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address.prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:clean_address.addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address.postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address.unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_address.sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:clean_address.p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:clean_address.v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:clean_address.st:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address.zip:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_address.zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address.cart:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address.cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_address.lot:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address.lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_address.dbpc:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address.chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_address.rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:clean_address.county:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_address.geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:clean_address.geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:clean_address.msa:TYPE(STRING4):0,0\n'
    + 'FIELD:clean_address.geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:clean_address.geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:clean_address.err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:append_prep_name:TYPE(STRING):0,0\n'
    + 'FIELD:nid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:name_ind:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:nametype:TYPE(STRING1):0,0\n'
    + 'FIELD:cln_title:TYPE(STRING5):0,0\n'
    + 'FIELD:cln_fname:TYPE(STRING20):0,0\n'
    + 'FIELD:cln_mname:TYPE(STRING20):0,0\n'
    + 'FIELD:cln_lname:TYPE(STRING20):0,0\n'
    + 'FIELD:cln_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:cln_fullname:TYPE(STRING150):0,0\n'
    + 'FIELD:process_date:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:process_time:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:current_rec:TYPE(BOOLEAN1):0,0\n'
    + 'FIELD:ingest_tpe:TYPE(UNSIGNED1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

