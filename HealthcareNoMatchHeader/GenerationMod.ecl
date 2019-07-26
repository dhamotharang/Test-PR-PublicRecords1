// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'HealthcareNoMatchHeader';
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
  EXPORT spc_FILENAME := 'NoMatchHeader';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,nomatch_id,rid,lexid,lexid_score,guardian_lexid,guardian_lexid_score,crk,src,source_rid,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,member_id,customer_id,account_id,subscriber_id,group_id,relationship_code,title,fname,mname,lname,suffix,input_full_name,dob,gender,ssn,home_phone,alt_phone,primary_email_address,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,guardian_fname,guardian_mname,guardian_lname,guardian_dob,guardian_ssn,udf1,udf2,udf3,persistent_rid,global_sid,record_sid';
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
    + 'MODULE:HealthcareNoMatchHeader\n'
    + 'FILENAME:NoMatchHeader\n'
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
    + 'FIELD:nomatch_id:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:rid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:lexid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:lexid_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:guardian_lexid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:guardian_lexid_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:crk:TYPE(STRING50):0,0\n'
    + 'FIELD:src:TYPE(STRING10):0,0\n'
    + 'FIELD:source_rid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:member_id:TYPE(STRING50):0,0\n'
    + 'FIELD:customer_id:TYPE(STRING50):0,0\n'
    + 'FIELD:account_id:TYPE(STRING50):0,0\n'
    + 'FIELD:subscriber_id:TYPE(STRING50):0,0\n'
    + 'FIELD:group_id:TYPE(STRING50):0,0\n'
    + 'FIELD:relationship_code:TYPE(STRING2):0,0\n'
    + 'FIELD:title:TYPE(STRING10):0,0\n'
    + 'FIELD:fname:TYPE(STRING50):0,0\n'
    + 'FIELD:mname:TYPE(STRING50):0,0\n'
    + 'FIELD:lname:TYPE(STRING50):0,0\n'
    + 'FIELD:suffix:TYPE(STRING10):0,0\n'
    + 'FIELD:input_full_name:TYPE(STRING150):0,0\n'
    + 'FIELD:dob:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:gender:TYPE(STRING1):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:home_phone:TYPE(STRING10):0,0\n'
    + 'FIELD:alt_phone:TYPE(STRING10):0,0\n'
    + 'FIELD:primary_email_address:TYPE(STRING50):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:county:TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:guardian_fname:TYPE(STRING50):0,0\n'
    + 'FIELD:guardian_mname:TYPE(STRING50):0,0\n'
    + 'FIELD:guardian_lname:TYPE(STRING50):0,0\n'
    + 'FIELD:guardian_dob:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:guardian_ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:udf1:TYPE(STRING100):0,0\n'
    + 'FIELD:udf2:TYPE(STRING100):0,0\n'
    + 'FIELD:udf3:TYPE(STRING100):0,0\n'
    + 'FIELD:persistent_rid:TYPE(STRING50):0,0\n'
    + 'FIELD:global_sid:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:record_sid:TYPE(UNSIGNED8):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

