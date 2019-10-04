// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_LT_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Thrive';
  EXPORT spc_NAMESCOPE := 'Input_LT';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Thrive';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_fname,orig_lname,orig_addr,orig_city,orig_zip4,orig_state,orig_zip5,email,phone,employer,dt';
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
    + 'MODULE:Scrubs_Thrive\n'
    + 'FILENAME:Thrive\n'
    + 'NAMESCOPE:Input_LT\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_fname:CUSTOM(Scrubs_Thrive.Functions.fn_chk_blank_names >0,orig_fname,,orig_lname)\n'
    + 'FIELDTYPE:invalid_lname:CUSTOM(Scrubs_Thrive.Functions.fn_chk_blank_names >0,orig_fname,,orig_lname)\n'
    + 'FIELDTYPE:invalid_addr:CUSTOM(Scrubs_Thrive.Functions.fn_invalid_addr >0)\n'
    + 'FIELDTYPE:invalid_city:CUSTOM(Scrubs_Thrive.Functions.fn_chk_city >0)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs.Functions.fn_Valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs.Functions.fn_valid_zip >0)\n'
    + 'FIELDTYPE:invalid_zip4:CUSTOM(Scrubs.Functions.fn_numeric_optional >0)\n'
    + 'FIELDTYPE:invalid_email:CUSTOM(Scrubs_Thrive.Functions.fn_chk_email >0)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs.Functions.fn_verify_phone>0,TRUE)\n'
    + 'FIELDTYPE:invalid_employer:CUSTOM(Scrubs_Thrive.Functions.fn_chk_employer>0)\n'
    + 'FIELDTYPE:invalid_date:CUSTOM(Scrubs_Thrive.Functions.fn_invalid_date>0)\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + 'FIELD:orig_fname:TYPE(STRING):LIKE(invalid_fname):0,0\n'
    + 'FIELD:orig_lname:TYPE(STRING):LIKE(invalid_lname):0,0\n'
    + 'FIELD:orig_addr:TYPE(STRING):LIKE(invalid_addr):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING):LIKE(invalid_city):0,0\n'
    + 'FIELD:orig_zip4:TYPE(STRING):LIKE(invalid_zip4):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING):LIKE(invalid_state):0,0\n'
    + 'FIELD:orig_zip5:TYPE(STRING):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:email:TYPE(STRING):LIKE(invalid_email):0,0\n'
    + 'FIELD:phone:TYPE(STRING):LIKE(invalid_phone):0,0\n'
    + '// FIELD:loantype:TYPE(STRING):0,0\n'
    + '// FIELD:besttime:TYPE(STRING):0,0\n'
    + '// FIELD:mortrate:TYPE(STRING):0,0\n'
    + '// FIELD:propertytype:TYPE(STRING):0,0\n'
    + '// FIELD:ratetype:TYPE(STRING):0,0\n'
    + '// FIELD:ltv:TYPE(STRING):0,0\n'
    + '// FIELD:yrsthere:TYPE(STRING):0,0\n'
    + 'FIELD:employer:TYPE(STRING):LIKE(invalid_employer):0,0\n'
    + '// FIELD:income:TYPE(STRING):0,0\n'
    + '// FIELD:credit:TYPE(STRING):0,0\n'
    + '// FIELD:loanamt:TYPE(STRING):0,0\n'
    + 'FIELD:dt:TYPE(STRING):LIKE(invalid_date):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

