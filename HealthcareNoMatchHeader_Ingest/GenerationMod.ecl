// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'HealthCareNoMatchHeader_Ingest';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := 'nomatch_id'; // cluster id (input)
  EXPORT spc_IDFIELD := 'nomatch_id'; // cluster id (output)
  EXPORT spc_RIDFIELD := 'RID'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'src';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Base';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:RID';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_nomatch_id */,src,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,source_rid,ssn,dob,title,fname,mname,lname,suffix,home_phone,gender,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,lexid';
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
    'OPTIONS:-gn -gh\n'
    + 'MODULE:HealthCareNoMatchHeader_Ingest\n'
    + '\n'
    + 'FILENAME:Base\n'
    + 'IDFIELD:EXISTS:nomatch_id\n'
    + 'RIDFIELD:RID:GENERATE\n'
    + 'SOURCEFIELD:src\n'
    + 'INGESTFILE:RAW_ALL:NAMED(HealthCareNoMatchHeader_Ingest.In_Ingest)\n'
    + '\n'
    + '// Source fields may seem special, but still need to be FIELDs to be used in the comparison\n'
    + '\n'
    + 'FIELD:src:0,0\n'
    + '\n'
    + '// RECORDDATE fields are not considered for matching, and will be rolled up\n'
    + '\n'
    + 'FIELD:dt_first_seen:RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dt_last_seen:RECORDDATE(LAST):0,0\n'
    + 'FIELD:dt_vendor_first_reported:RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dt_vendor_last_reported:RECORDDATE(LAST):0,0\n'
    + '\n'
    + '// Fields DERIVED are not considered for matching, and will receive their "new" value \n'
    + '// Record defining fields will be considered in dedup all other fileds gets existing base value  \n'
    + '\n'
    + 'FIELD:source_rid:0,0\n'
    + 'FIELD:ssn:0,0\n'
    + 'FIELD:dob:0,0\n'
    + 'FIELD:title:DERIVED:0,0\n'
    + 'FIELD:fname:0,0\n'
    + 'FIELD:mname:DERIVED:0,0\n'
    + 'FIELD:lname:DERIVED:0,0\n'
    + 'FIELD:suffix:DERIVED:0,0\n'
    + 'FIELD:home_phone:DERIVED:0,0\n'
    + 'FIELD:gender:DERIVED:0,0\n'
    + '\n'
    + 'FIELD:prim_range:DERIVED:0,0\n'
    + 'FIELD:predir:DERIVED:0,0\n'
    + 'FIELD:prim_name:DERIVED:0,0\n'
    + 'FIELD:addr_suffix:DERIVED:0,0 \n'
    + 'FIELD:postdir:DERIVED:0,0\n'
    + 'FIELD:unit_desig:DERIVED:DERIVED:0,0  \n'
    + 'FIELD:sec_range:DERIVED:0,0\n'
    + 'FIELD:city_name:DERIVED:0,0\n'
    + 'FIELD:st:DERIVED:0,0\n'
    + 'FIELD:zip:DERIVED:0,0\n'
    + 'FIELD:zip4:DERIVED:0,0\n'
    + '\n'
    + 'FIELD:lexid:DERIVED:0,0\n'
    + '\n'
    + '// FIELD:member_id:DERIVED:0,0\n'
    + '// FIELD:customer_id:DERIVED:0,0\n'
    + '// FIELD:account_id:DERIVED:0,0\n'
    + '// FIELD:subscriber_id:DERIVED:0,0\n'
    + '// FIELD:group_id:DERIVED:0,0\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

