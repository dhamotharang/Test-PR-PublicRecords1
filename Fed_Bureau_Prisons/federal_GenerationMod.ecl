// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT federal_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.3';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Fed_Bureau_Prisons';
  EXPORT spc_NAMESCOPE := 'federal';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'rcid'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'federal_bureau_base';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:rcid';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,persistent_record_id,offender_key,src,process_date,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,record_upload_date,category,source,orig_name,orig_lastname,orig_firstname,orig_middlename,orig_suffix,dob,sex,race,age,registery_number,defendant_status,offense_description,disposition,scheduled_release_date,nametype,nid,title,fname,mname,lname,suffix,name_ind,global_sid,record_sid';
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
    '\n'
    + '\n'
    + '\n'
    + 'OPTIONS:-gn\n'
    + 'MODULE:Fed_Bureau_Prisons\n'
    + 'FILENAME:federal_bureau_base\n'
    + 'NAMESCOPE:federal\n'
    + 'RIDFIELD:rcid\n'
    + 'INGESTFILE:Fed_Bureau_Prisons_Update:NAMED(Fed_Bureau_Prisons.file_federal_bureau_base)\n'
    + '\n'
    + 'FIELD:persistent_record_id:DERIVED:TYPE(string100):0,0\n'
    + 'FIELD:offender_key:DERIVED:TYPE(STRING80):0,0\n'
    + 'FIELD:src:DERIVED:TYPE(string2):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0   //data tracking\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0   //data tracking\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0   //data tracking\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0   //data tracking\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0   //data tracking\n'
    + 'FIELD:record_upload_date:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:category:DERIVED:TYPE(STRING40):0,0\n'
    + 'FIELD:source:DERIVED:TYPE(STRING100):0,0\n'
    + 'FIELD:orig_name:TYPE(STRING115):0,0    //used for upsert      \n'
    + 'FIELD:orig_lastname:DERIVED:TYPE(STRING50):0,0\n'
    + 'FIELD:orig_firstname:DERIVED:TYPE(STRING50):0,0\n'
    + 'FIELD:orig_middlename:DERIVED:TYPE(STRING40):0,0\n'
    + 'FIELD:orig_suffix:DERIVED:TYPE(STRING15):0,0\n'
    + 'FIELD:dob:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:sex:TYPE(STRING10):0,0    //used for upsert \n'
    + 'FIELD:race:TYPE(STRING50):0,0    //used for upsert\n'
    + 'FIELD:age:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:registery_number:TYPE(STRING20):0,0    //used for upsert\n'
    + 'FIELD:defendant_status:DERIVED:TYPE(STRING100):0,0\n'
    + 'FIELD:offense_description:TYPE(STRING100):0,0    //used for upsert\n'
    + 'FIELD:disposition:TYPE(STRING150):0,0    //used for upsert\n'
    + 'FIELD:scheduled_release_date:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:nametype:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:nid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:title:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:DERIVED:TYPE(STRING50):0,0\n'
    + 'FIELD:mname:DERIVED:TYPE(STRING50):0,0\n'
    + 'FIELD:lname:DERIVED:TYPE(STRING50):0,0\n'
    + 'FIELD:suffix:DERIVED:TYPE(STRING50):0,0\n'
    + 'FIELD:name_ind:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:global_sid:DERIVED:TYPE(unsigned4):0,0\n'
    + 'FIELD:record_sid:DERIVED:TYPE(unsigned8):0,0\n'
    + '\n'
    + '//'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

