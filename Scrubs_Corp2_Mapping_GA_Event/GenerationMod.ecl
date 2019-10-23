// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Corp2_Mapping_GA_Event';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Corp2_Mapping_GA_Event\n'
    + 'FILENAME:in_file\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0..8):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_corp_key:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(4..)\n'
    + 'FIELDTYPE:invalid_charter:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_corp_vendor:ENUM(13)\n'
    + 'FIELDTYPE:invalid_state_origin:ENUM(GA)\n'
    + 'FIELDTYPE:invalid_reference_nbr:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- )\n'
    + '\n'
    + 'FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0\n'
    + 'FIELD:corp_supp_key:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0\n'
    + 'FIELD:corp_vendor_county:TYPE(STRING3):0,0\n'
    + 'FIELD:corp_vendor_subcode:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0\n'
    + 'DATEFIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter):0,0\n'
    + 'FIELD:event_filing_reference_nbr:TYPE(STRING30):LIKE(invalid_reference_nbr):0,0\n'
    + 'FIELD:event_amendment_nbr:TYPE(STRING3):0,0\n'
    + 'FIELD:event_filing_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:event_date_type_cd:TYPE(STRING3):0,0\n'
    + 'FIELD:event_date_type_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:event_filing_cd:TYPE(STRING8):0,0\n'
    + 'FIELD:event_filing_desc:TYPE(STRING60):0,0\n'
    + 'FIELD:event_corp_nbr:TYPE(STRING32):0,0\n'
    + 'FIELD:event_corp_nbr_cd:TYPE(STRING1):0,0\n'
    + 'FIELD:event_corp_nbr_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:event_roll:TYPE(STRING10):0,0\n'
    + 'FIELD:event_frame:TYPE(STRING10):0,0\n'
    + 'FIELD:event_start:TYPE(STRING8):0,0\n'
    + 'FIELD:event_end:TYPE(STRING8):0,0\n'
    + 'FIELD:event_microfilm_nbr:TYPE(STRING10):0,0\n'
    + 'FIELD:event_desc:TYPE(STRING500):0,0\n'
    + 'FIELD:event_revocation_comment1:TYPE(STRING250):0,0\n'
    + 'FIELD:event_revocation_comment2:TYPE(STRING250):0,0\n'
    + 'FIELD:event_book_nbr:TYPE(STRING9):0,0\n'
    + 'FIELD:event_page_nbr:TYPE(STRING9):0,0\n'
    + 'FIELD:event_certification_nbr:TYPE(STRING9):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
