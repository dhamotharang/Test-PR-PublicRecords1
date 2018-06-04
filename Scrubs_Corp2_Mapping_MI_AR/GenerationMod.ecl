// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.1';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Corp2_Mapping_MI_AR';
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
  EXPORT spc_FILENAME := 'In_MI';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,corp_key,corp_vendor,corp_vendor_county,corp_vendor_subcode,corp_state_origin,corp_process_date,corp_sos_charter_nbr,ar_year,ar_mailed_dt,ar_due_dt,ar_filed_dt,ar_report_dt,ar_report_nbr,ar_franchise_tax_paid_dt,ar_delinquent_dt,ar_tax_factor,ar_tax_amount_paid,ar_annual_report_cap,ar_illinois_capital,ar_roll,ar_frame,ar_extension,ar_microfilm_nbr,ar_comment,ar_type,ar_exempt,ar_license_tax_amount,ar_status,ar_paid_date,ar_prev_paid_date,ar_prev_tax_factor,ar_extension_date,ar_report_mail_date,ar_deliquent_report_mail_date,ar_report_filed_date,ar_year_and_month_due';
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
    + 'MODULE:Scrubs_Corp2_Mapping_MI_AR\n'
    + 'FILENAME:In_MI\n'
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
    + 'FIELDTYPE:invalid_corp_vendor:ENUM(26)\n'
    + 'FIELDTYPE:invalid_state_origin:ENUM(MI)\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_pastdate>0)\n'
    + 'FIELDTYPE:invalid_future_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_generaldate>0)\n'
    + 'FIELDTYPE:invalid_charter_nbr:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789 )\n'
    + '\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0\n'
    + 'FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0\n'
    + 'FIELD:corp_vendor_county:TYPE(STRING3):0,0\n'
    + 'FIELD:corp_vendor_subcode:TYPE(STRING5):0,0\n'
    + 'FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0\n'
    + 'FIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:corp_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter_nbr):0,0\n'
    + 'FIELD:ar_year:TYPE(STRING4):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:ar_mailed_dt:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_due_dt:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_filed_dt:TYPE(STRING8):LIKE(invalid_date):0,0\n'
    + 'FIELD:ar_report_dt:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_report_nbr:TYPE(STRING30):0,0\n'
    + 'FIELD:ar_franchise_tax_paid_dt:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_delinquent_dt:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_tax_factor:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_tax_amount_paid:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_annual_report_cap:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_illinois_capital:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_roll:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_frame:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_extension:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_microfilm_nbr:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_comment:TYPE(STRING350):0,0\n'
    + 'FIELD:ar_type:TYPE(STRING60):0,0\n'
    + 'FIELD:ar_exempt:TYPE(STRING1):0,0\n'
    + 'FIELD:ar_license_tax_amount:TYPE(STRING20):0,0\n'
    + 'FIELD:ar_status:TYPE(STRING50):0,0\n'
    + 'FIELD:ar_paid_date:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_prev_paid_date:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_prev_tax_factor:TYPE(STRING10):0,0\n'
    + 'FIELD:ar_extension_date:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_report_mail_date:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_deliquent_report_mail_date:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_report_filed_date:TYPE(STRING8):0,0\n'
    + 'FIELD:ar_year_and_month_due:TYPE(STRING8):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

