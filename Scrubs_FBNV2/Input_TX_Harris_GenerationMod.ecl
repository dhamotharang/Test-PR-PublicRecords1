// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_TX_Harris_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FBNV2';
  EXPORT spc_NAMESCOPE := 'Input_TX_Harris';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,FILE_NUMBER,DATE_FILED,NAME1,NAME2,prep_addr1_line1,prep_addr1_line_last,prep_addr2_line1,prep_addr2_line_last';
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
    + 'NAMESCOPE:Input_TX_Harris\n'
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
    + 'FIELD:FILE_NUMBER:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:DATE_FILED:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + '// FIELD:RECORD_TYPE:TYPE(STRING):0,0\n'
    + 'FIELD:NAME1:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:STREET_ADD1:TYPE(STRING):0,0\t\n'
    + '// FIELD:CITY1:TYPE(STRING):0,0\t\n'
    + '// FIELD:STATE1:TYPE(STRING):0,0\t\n'
    + '// FIELD:ZIP1:TYPE(STRING):0,0\t\n'
    + '// FIELD:TERM:TYPE(STRING):0,0\t\n'
    + 'FIELD:NAME2:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:STREET_ADD2:TYPE(STRING):0,0\t\n'
    + '// FIELD:CITY2:TYPE(STRING):0,0\t\n'
    + '// FIELD:STATE2:TYPE(STRING):0,0\t\n'
    + '// FIELD:ZIP2:TYPE(STRING):0,0\t\n'
    + '// FIELD:FILM_CODE:TYPE(STRING):0,0\t\n'
    + '// FIELD:BUS_TYPE:TYPE(STRING):0,0\t\n'
    + '// FIELD:ANNEX_CODE:TYPE(STRING):0,0\t\n'
    + '// FIELD:NUM_PAGES:TYPE(STRING):0,0 //NEW\n'
    + '// FIELD:EXPIRED_TERM:TYPE(STRING):0,0 //NEW\n'
    + '// FIELD:INCORPORATED:TYPE(STRING):0,0 //NEW\n'
    + '// FIELD:ASSUMED_NAME:TYPE(STRING):0,0 //NEW\n'
    + 'FIELD:prep_addr1_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr1_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr2_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr2_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:name1_title:TYPE(STRING):0,0\n'
    + '// FIELD:name1_fname:TYPE(STRING):0,0\n'
    + '// FIELD:name1_mname:TYPE(STRING):0,0\n'
    + '// FIELD:name1_lname:TYPE(STRING):0,0\n'
    + '// FIELD:name1_name_suffix:TYPE(STRING):0,0\n'
    + '// FIELD:name1_name_score:TYPE(STRING):0,0\n'
    + '// FIELD:name2_title:TYPE(STRING):0,0\n'
    + '// FIELD:name2_fname:TYPE(STRING):0,0\n'
    + '// FIELD:name2_mname:TYPE(STRING):0,0\n'
    + '// FIELD:name2_lname:TYPE(STRING):0,0\n'
    + '// FIELD:name2_name_suffix:TYPE(STRING):0,0\n'
    + '// FIELD:name2_name_score:TYPE(STRING):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

