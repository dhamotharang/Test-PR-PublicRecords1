// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_CA_Ventura_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FBNV2';
  EXPORT spc_NAMESCOPE := 'Input_CA_Ventura';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'FBNV2';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,recorded_date,business_name,owner_name,start_date,abandondate,file_number,prep_bus_addr_line1,prep_bus_addr_line_last,prep_owner_addr_line1,prep_owner_addr_line_last';
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
    + 'MODULE:Scrubs_FBNV2\n'
    + 'FILENAME:FBNV2\n'
    + 'NAMESCOPE:Input_CA_Ventura\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_past_date:CUSTOM(Scrubs.fn_valid_pastDate > 0)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + '// FIELD:process_date:TYPE(STRING):0,0\n'
    + '// FIELD:instrument_id:TYPE(STRING):0,0\n'
    + 'FIELD:recorded_date:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + '// FIELD:recorded_time:TYPE(STRING):0,0\n'
    + 'FIELD:business_name:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:business_street:TYPE(STRING):0,0\n'
    + '// FIELD:business_city:TYPE(STRING):0,0\n'
    + '// FIELD:business_state:TYPE(STRING):0,0\n'
    + '// FIELD:business_zip5:TYPE(STRING):0,0\n'
    + '// FIELD:business_zip4:TYPE(STRING):0,0\n'
    + '// FIELD:mail_street:TYPE(STRING):0,0\n'
    + '// FIELD:mail_city:TYPE(STRING):0,0\n'
    + '// FIELD:mail_state:TYPE(STRING):0,0\n'
    + '// FIELD:mail_zip5:TYPE(STRING):0,0\n'
    + '// FIELD:mail_zip4:TYPE(STRING):0,0\n'
    + 'FIELD:owner_name:TYPE(STRING55):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:owner_firstname:TYPE(STRING):0,0\n'
    + '// FIELD:owner_address:TYPE(STRING):0,0\n'
    + '// FIELD:owner_city:TYPE(STRING):0,0\n'
    + '// FIELD:owner_state:TYPE(STRING):0,0\n'
    + '// FIELD:owner_zipcode5:TYPE(STRING):0,0\n'
    + '// FIELD:owner_zipcode4:TYPE(STRING):0,0\n'
    + '// FIELD:short_legal:TYPE(STRING):0,0\n'
    + 'FIELD:start_date:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:abandondate:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:file_number:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:file_year:TYPE(STRING):0,0\n'
    + '// FIELD:file_seq:TYPE(STRING):0,0\n'
    + '// FIELD:pname:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_cln_title:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_cln_fname:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_cln_mname:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_cln_lname:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_cln_name_suffix:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_cln_name_score:TYPE(STRING):0,0\n'
    + '// FIELD:cname:TYPE(STRING):0,0\t\n'
    + 'FIELD:prep_bus_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_bus_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:prep_mail_addr_line1:TYPE(STRING):0,0\n'
    + '// FIELD:prep_mail_addr_line_last:TYPE(STRING):0,0\n'
    + 'FIELD:prep_owner_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_owner_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

