// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_5610_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_EBR';
  EXPORT spc_NAMESCOPE := 'Base_5610';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'EBR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,powid,proxid,seleid,orgid,ultid,bdid,date_first_seen,date_last_seen,process_date_first_seen,process_date_last_seen,record_type,did,ssn,process_date,file_number,segment_code,sequence_number,officer_title,officer_first_name,officer_m_i,officer_last_name,clean_officer_name_title,clean_officer_name_fname,clean_officer_name_mname,clean_officer_name_lname,clean_officer_name_name_suffix';
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
    + 'MODULE:Scrubs_EBR\n'
    + 'FILENAME:EBR\n'
    + 'NAMESCOPE:Base_5610\n'
    + '//--------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//--------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_EBR.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_numeric_or_allzeros:CUSTOM(Scrubs_EBR.Functions.fn_numeric_or_allzeros>0)\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_EBR.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_dt_first_seen:CUSTOM(Scrubs_EBR.Functions.fn_dt_first_seen>0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(H|C)\n'
    + 'FIELDTYPE:invalid_segment:ENUM(5610|5610)\n'
    + 'FIELDTYPE:invalid_file_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(9)\n'
    + '\n'
    + '//------------------------------------------------------\n'
    + '//FIELDS:  Commented out fields are not being scrubbed\n'
    + '//------------------------------------------------------\n'
    + '// FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + '// FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + '// FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):LIKE(invalid_dt_first_seen):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:process_date_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:process_date_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + '// FIELD:did_score:TYPE(UNSIGNED1):0,0\n'
    + 'FIELD:ssn:TYPE(UNSIGNED4):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:file_number:TYPE(STRING10):LIKE(invalid_file_number):0,0\n'
    + 'FIELD:segment_code:TYPE(STRING4):LIKE(invalid_segment):0,0\n'
    + 'FIELD:sequence_number:TYPE(STRING5):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + '// FIELD:fiscal_yr_end_mm:TYPE(STRING2):0,0\n'
    + '// FIELD:profit_range_code:TYPE(STRING1):0,0\n'
    + '// FIELD:profit_range_desc:TYPE(STRING25):0,0\n'
    + '// FIELD:profit_range_actual:TYPE(STRING7):0,0\n'
    + '// FIELD:net_worth_code:TYPE(STRING1):0,0\n'
    + '// FIELD:net_worth_desc:TYPE(STRING25):0,0\n'
    + '// FIELD:net_worth_actual:TYPE(STRING7):0,0\n'
    + '// FIELD:in_bldng_since_yy:TYPE(STRING4):0,0\n'
    + '// FIELD:own_or_rent_code:TYPE(STRING1):0,0\n'
    + '// FIELD:bldng_square_feet:TYPE(STRING7):0,0\n'
    + '// FIELD:active_cust_count:TYPE(STRING7):0,0\n'
    + '// FIELD:ownership_code:TYPE(STRING1):0,0\n'
    + '// FIELD:ownership_desc:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_name:TYPE(STRING31):0,0\n'
    + '// FIELD:corp_city:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_state_code:TYPE(STRING2):0,0\n'
    + '// FIELD:corp_state_desc:TYPE(STRING20):0,0\n'
    + '// FIELD:corp_phone:TYPE(STRING10):0,0\n'
    + 'FIELD:officer_title:TYPE(STRING10):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:officer_first_name:TYPE(STRING10):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:officer_m_i:TYPE(STRING1):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:officer_last_name:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:clean_officer_name_title:TYPE(STRING5):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:clean_officer_name_fname:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:clean_officer_name_mname:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:clean_officer_name_lname:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:clean_officer_name_name_suffix:TYPE(STRING5):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:clean_officer_name_name_score:TYPE(STRING3):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

