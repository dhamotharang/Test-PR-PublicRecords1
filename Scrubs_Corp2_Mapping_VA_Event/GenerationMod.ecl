// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Corp2_Mapping_VA_Event';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'In_VA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,corp_key,corp_supp_key,corp_vendor,corp_vendor_county,corp_vendor_subcode,corp_state_origin,corp_process_date,corp_sos_charter_nbr,event_filing_reference_nbr,event_amendment_nbr,event_filing_date,event_date_type_cd,event_date_type_desc,event_filing_cd,event_filing_desc,event_corp_nbr,event_corp_nbr_cd,event_corp_nbr_desc,event_roll,event_frame,event_start,event_end,event_microfilm_nbr,event_desc,event_revocation_comment1,event_revocation_comment2,event_book_nbr,event_page_nbr,event_certification_nbr';
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
    'OPTIONS:-gh \n'
    + 'MODULE:Scrubs_Corp2_Mapping_VA_Event\n'
    + 'FILENAME:In_VA\n'
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
    + '\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_corp_key:ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(4..)\n'
    + 'FIELDTYPE:invalid_charter_nbr:ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_corp_vendor:ENUM(51)\n'
    + 'FIELDTYPE:invalid_state_origin:ENUM(VA)\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + 'FIELDTYPE:invalid_future_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_GeneralDate>0)\n'
    + 'FIELDTYPE:invalid_date_type_cd:ENUM(FIL|MERG)\n'
    + 'FIELDTYPE:invalid_date_type_desc:ENUM(FILING|MERGER)\n'
    + 'FIELDTYPE:invalid_filing_type_cd:CUSTOM(Scrubs_Corp2_Mapping_VA_Event.Functions.ValidEventFilingTypeCD>0)\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0\n'
    + 'FIELD:corp_supp_key:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0\n'
    + 'FIELD:corp_vendor_county:TYPE(STRING3):0,0\n'
    + 'FIELD:corp_vendor_subcode:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0\n'
    + 'FIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter_nbr):0,0\n'
    + 'FIELD:event_filing_reference_nbr:TYPE(STRING30):0,0\n'
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

