// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_FL_Event_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FBNV2';
  EXPORT spc_NAMESCOPE := 'Input_FL_Event';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,EVENT_DOC_NUMBER,EVENT_ORIG_DOC_NUMBER,EVENT_DATE,ACTION_OWN_NAME,prep_old_addr_line1,prep_old_addr_line_last,prep_new_addr_line1,prep_new_addr_line_last,prep_owner_addr_line1,prep_owner_addr_line_last';
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
    + 'NAMESCOPE:Input_FL_Event\n'
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
    + '// FIELD:process_date:TYPE(STRING):0,0\n'
    + 'FIELD:EVENT_DOC_NUMBER:TYPE(STRING20):LIKE(invalid_mandatory):0,00\n'
    + 'FIELD:EVENT_ORIG_DOC_NUMBER:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:EVENT_FIC_NAME:TYPE(STRING):0,0\n'
    + '// FIELD:EVENT_ACTION_CTR:TYPE(STRING):0,0 \n'
    + '// FIELD:EVENT_SEQ_NUMBER:TYPE(STRING):0,0\n'
    + '// FIELD:EVENT_PAGES:TYPE(STRING):0,0\n'
    + 'FIELD:EVENT_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + '// FIELD:ACTION_SEQ_NUMBER:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_CODE:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_VERBAGE:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_FEI:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_COUNTY:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_ADDR1:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_ADDR2:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_CITY:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_STATE:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_ZIP5:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_ZIP4:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_COUNTRY:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_COUNTRY_DESC:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_FEI:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_COUNTY:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_ADDR1:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_ADDR2:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_CITY:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_STATE:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_ZIP5:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_ZIP4:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_COUNTRY:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_COUNTRY_DESC:TYPE(STRING):0,0\n'
    + 'FIELD:ACTION_OWN_NAME:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:ACTION_OWN_ADDRESS:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OWN_CITY:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OWN_STATE:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OWN_ZIP5:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OWN_FEI:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OWN_CHARTER_NUMBER:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_OLD_NAME_SEQ:TYPE(STRING):0,0\n'
    + '// FIELD:ACTION_NEW_NAME_SEQ:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_title:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_fname:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_mname:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_lname:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_name_suffix:TYPE(STRING):0,0\n'
    + '// FIELD:Owner_name_score:TYPE(STRING):0,0\n'
    + '// FIELD:cname:TYPE(STRING):0,0\n'
    + 'FIELD:prep_old_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_old_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_new_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_new_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_owner_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_owner_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

