// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_CA_Santa_Clara_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FBNV2';
  EXPORT spc_NAMESCOPE := 'Input_CA_Santa_Clara';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,status,process_date,FIlED_DATE,FBN_TYPE,FILING_TYPE,BUSINESS_NAME,BUSINESS_TYPE,ORIG_FILED_DATE,ORIG_FBN_NUM,RECORD_CODE1,FBN_NUM,BUSINESS_ADDR1,RECORD_CODE2,BUSINESS_ADDR2,RECORD_CODE3,BUS_CITY,BUS_ST,BUS_ZIP,RECORD_CODE4,ADDTL_BUSINESS,RECORD_CODE5,owner_name,OWNER_TYPE,RECORD_CODE6,OWNER_ADDR1,OWNER_CITY,OWNER_ST,OWNER_ZIP,Owner_title,Owner_fname,Owner_mname,Owner_lname,Owner_name_suffix,Owner_name_score,prep_addr_line1,prep_addr_line_last,prep_owner_addr_line1,prep_owner_addr_line_last';
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
    + 'NAMESCOPE:Input_CA_Santa_Clara\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_past_date:CUSTOM(Scrubs.fn_valid_pastDate > 0)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + '\n'
    + 'FIELD:status:TYPE(STRING):0,0\n'
    + 'FIELD:process_date:TYPE(STRING):0,0\n'
    + 'FIELD:FIlED_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:FBN_TYPE:TYPE(STRING):0,0\t\n'
    + 'FIELD:FILING_TYPE:TYPE(STRING48):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:BUSINESS_NAME:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:BUSINESS_TYPE:TYPE(STRING):0,0\t\t\n'
    + 'FIELD:ORIG_FILED_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:ORIG_FBN_NUM:TYPE(STRING):0,0\t\t\n'
    + 'FIELD:RECORD_CODE1:TYPE(STRING):0,0\t\n'
    + 'FIELD:FBN_NUM:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:BUSINESS_ADDR1:TYPE(STRING):0,0\t \t\n'
    + 'FIELD:RECORD_CODE2:TYPE(STRING):0,0\t \t\n'
    + 'FIELD:BUSINESS_ADDR2:TYPE(STRING):0,0\t \t\n'
    + 'FIELD:RECORD_CODE3:TYPE(STRING):0,0\t \t\n'
    + 'FIELD:BUS_CITY:TYPE(STRING):0,0\n'
    + 'FIELD:BUS_ST:TYPE(STRING):0,0\n'
    + 'FIELD:BUS_ZIP:TYPE(STRING):0,0\t \t\n'
    + 'FIELD:RECORD_CODE4:TYPE(STRING):0,0\t\t\n'
    + 'FIELD:ADDTL_BUSINESS:TYPE(STRING):0,0\t\t\n'
    + 'FIELD:RECORD_CODE5:TYPE(STRING):0,0\n'
    + 'FIELD:owner_name:TYPE(STRING55):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:OWNER_TYPE:TYPE(STRING):0,0\t\n'
    + 'FIELD:RECORD_CODE6:TYPE(STRING):0,0\t\n'
    + 'FIELD:OWNER_ADDR1:TYPE(STRING):0,0\n'
    + 'FIELD:OWNER_CITY:TYPE(STRING):0,0\n'
    + 'FIELD:OWNER_ST:TYPE(STRING):0,0\n'
    + 'FIELD:OWNER_ZIP:TYPE(STRING):0,0\n'
    + 'FIELD:Owner_title:TYPE(STRING):0,0\n'
    + 'FIELD:Owner_fname:TYPE(STRING):0,0\n'
    + 'FIELD:Owner_mname:TYPE(STRING):0,0\n'
    + 'FIELD:Owner_lname:TYPE(STRING):0,0\n'
    + 'FIELD:Owner_name_suffix:TYPE(STRING):0,0\n'
    + 'FIELD:Owner_name_score:TYPE(STRING):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_owner_addr_line1:TYPE(STRING):0,0\n'
    + 'FIELD:prep_owner_addr_line_last:TYPE(STRING):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

