// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_FL_Filing_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FBNV2';
  EXPORT spc_NAMESCOPE := 'Input_FL_Filing';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,FIC_FIL_DOC_NUM,FIC_FIL_NAME,FIC_FIL_DATE,FIC_OWNER_DOC_NUM,FIC_OWNER_NAME,p_owner_name,c_owner_name,prep_addr_line1,prep_addr_line_last,prep_owner_addr_line1,prep_owner_addr_line_last,seq';
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
    + 'NAMESCOPE:Input_FL_Filing\n'
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
    + 'FIELD:FIC_FIL_DOC_NUM:TYPE(STRING20):LIKE(invalid_mandatory):0,00\n'
    + 'FIELD:FIC_FIL_NAME:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:FIC_FIL_COUNTY:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_ADDR1:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_ADDR2:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_CITY:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_STATE:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_ZIP5:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_ZIP4:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_COUNTRY:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_COUNTRY_DEC:TYPE(STRING):0,0\n'
    + 'FIELD:FIC_FIL_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + '// FIELD:FIC_FIL_PAGES:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_STATUS:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_STATUS_DEC:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_CANCELLATION_DATE:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_EXPIRATION_DATE:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_TOTAL_OWN_CUR_CTR:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_FIL_FEI_NUM:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_GREATER_THAN__OWNERS:TYPE(STRING):0,0\n'
    + 'FIELD:FIC_OWNER_DOC_NUM:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:FIC_OWNER_NAME:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:FIC_OWNER_NAME_FORMAT:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_ADDR:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_CITY:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_STATE:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_ZIP5:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_ZIP4:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_COUNTRY:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_COUNTRY_DEC:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_FEI_NUM:TYPE(STRING):0,0\n'
    + '// FIELD:FIC_OWNER_CHARTER_NUM:TYPE(STRING):0,0\n'
    + 'FIELD:p_owner_name:TYPE(STRING73):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:c_owner_name:TYPE(STRING70):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_owner_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_owner_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:seq:TYPE(STRING):LIKE(invalid_mandatory):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

