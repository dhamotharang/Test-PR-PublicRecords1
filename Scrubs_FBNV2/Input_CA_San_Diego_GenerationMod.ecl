// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_CA_San_Diego_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FBNV2';
  EXPORT spc_NAMESCOPE := 'Input_CA_San_Diego';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,FILE_NUMBER,FILE_DATE,PREV_FILE_NUMBER,PREV_FILE_DATE,FILING_TYPE,BUSINESS_NAME,prep_addr_line1,prep_addr_line_last';
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
    + 'NAMESCOPE:Input_CA_San_Diego\n'
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
    + '// FIELD:TYPE_OF_RECORD:TYPE(STRING):0,0\t       //exists only in old layout\n'
    + '// FIELD:OWNER_NAME:TYPE(STRING):0,0\t           //exists only in old layout\n'
    + '// FIELD:fbn_type:TYPE(STRING):0,0\t             //exists only in old layout\n'
    + '// FIELD:PNAME:TYPE(STRING):0,0                 //exists only in old layout\n'
    + 'FIELD:FILE_NUMBER:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:FILE_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + '// FIELD:EXPIRATION_DATE:TYPE(STRING):0,0\n'
    + 'FIELD:PREV_FILE_NUMBER:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:PREV_FILE_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:FILING_TYPE:TYPE(STRING48):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:BUSINESS_START_DATE:TYPE(STRING):0,0\n'
    + '// FIELD:OWNERSHIP_TYPE:TYPE(STRING):0,0\n'
    + 'FIELD:BUSINESS_NAME:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:TYPE_OF_NAME:TYPE(STRING):0,0\n'
    + '// FIELD:TYPE_OF_NAME_SEQ_NUM:TYPE(STRING):0,0\n'
    + '// FIELD:STREET_ADDRESS1:TYPE(STRING):0,0\n'
    + '// FIELD:STREET_ADDRESS2:TYPE(STRING):0,0\n'
    + '// FIELD:CITY:TYPE(STRING):0,0\n'
    + '// FIELD:STATE:TYPE(STRING):0,0\n'
    + '// FIELD:ZIP_CODE:TYPE(STRING):0,0\n'
    + '// FIELD:COUNTRY:TYPE(STRING):0,0\n'
    + '// FIELD:MAILING_ADDRESS1:TYPE(STRING):0,0\n'
    + '// FIELD:MAILING_ADDRESS2:TYPE(STRING):0,0\n'
    + '// FIELD:MAILING_CITY:TYPE(STRING):0,0\n'
    + '// FIELD:MAILING_STATE:TYPE(STRING):0,0\n'
    + '// FIELD:MAILING_ZIP_CODE:TYPE(STRING):0,0\n'
    + '// FIELD:MAILING_COUNTRY:TYPE(STRING):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:prep_mail_addr_line1:TYPE(STRING):0,0\n'
    + '// FIELD:prep_mail_addr_line_last:TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

