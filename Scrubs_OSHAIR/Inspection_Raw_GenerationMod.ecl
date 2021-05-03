// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Inspection_Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OSHAIR';
  EXPORT spc_NAMESCOPE := 'Inspection_Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Inspection_Raw_In_OSHAIR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,activity_nr,reporting_id,state_flag,site_state,site_zip,owner_type,owner_code,adv_notice,safety_hlth,sic_code,naics_code,insp_type,insp_scope,why_no_insp,union_status,safety_manuf,safety_const,safety_marit,health_manuf,health_const,health_marit,migrant,mail_state,mail_zip,host_est_key,nr_in_estab,open_date,case_mod_date,close_conf_date,close_case_date,open_year,case_mod_year,close_conf_year,close_case_year,estab_name';
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
    + 'MODULE:Scrubs_OSHAIR\n'
    + 'FILENAME:Inspection_Raw_In_OSHAIR\n'
    + 'NAMESCOPE:Inspection_Raw\n'
    + '\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_numeric_blank:CUSTOM(Scrubs_Oshair.Functions.fn_numeric_or_blank > 0)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_Oshair.Functions.fn_verify_state > 0)\n'
    + 'FIELDTYPE:invalid_state_flag:CUSTOM(Scrubs_Oshair.Functions.fn_state_flag > 0)\n'
    + 'FIELDTYPE:invalid_owner_type:CUSTOM(Scrubs_Oshair.Functions.fn_owner_type > 0)\n'
    + 'FIELDTYPE:invalid_adv_notice:CUSTOM(Scrubs_Oshair.Functions.fn_adv_notice > 0)\n'
    + 'FIELDTYPE:invalid_safety_hlth:CUSTOM(Scrubs_Oshair.Functions.fn_safety_hlth > 0)\n'
    + 'FIELDTYPE:invalid_insp_type:CUSTOM(Scrubs_Oshair.Functions.fn_insp_type > 0)\n'
    + 'FIELDTYPE:invalid_insp_scope:CUSTOM(Scrubs_Oshair.Functions.fn_insp_scope > 0)\n'
    + 'FIELDTYPE:invalid_why_no_insp:CUSTOM(Scrubs_Oshair.Functions.fn_why_no_insp > 0)\n'
    + 'FIELDTYPE:invalid_union_status:CUSTOM(Scrubs_Oshair.Functions.fn_union_status > 0)\n'
    + 'FIELDTYPE:invalid_X_blank:CUSTOM(Scrubs_Oshair.Functions.fn_X_blank > 0)\n'
    + 'FIELDTYPE:invalid_host_est_key:CUSTOM(Scrubs_Oshair.Functions.fn_host_est_key > 0)\n'
    + 'FIELDTYPE:invalid_date_dashes:CUSTOM(Scrubs_Oshair.Functions.fn_date_time > 0, \'FUTURE\')\n'
    + 'FIELDTYPE:invalid_year:CUSTOM(Scrubs_Oshair.Functions.fn_dt_yy > 0)\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs.Functions.fn_populated_strings>0)\n'
    + 'FIELDTYPE:invalid_sic:CUSTOM(Scrubs.Functions.fn_valid_SicCode>0)\n'
    + 'FIELDTYPE:invalid_naics:CUSTOM(Scrubs.Functions.fn_validate_NAICSCode>0)\n'
    + '\n'
    + 'FIELD:activity_nr:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:reporting_id:TYPE(STRING7):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:state_flag:TYPE(STRING1):LIKE(invalid_state_flag):0,0\n'
    + 'FIELD:site_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:site_zip:TYPE(STRING5):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:owner_type:TYPE(STRING1):LIKE(invalid_owner_type):0,0\n'
    + 'FIELD:owner_code:TYPE(STRING4):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:adv_notice:TYPE(STRING1):LIKE(invalid_adv_notice):0,0\n'
    + 'FIELD:safety_hlth:TYPE(STRING1):LIKE(invalid_safety_hlth):0,0\n'
    + 'FIELD:sic_code:TYPE(STRING4):LIKE(invalid_sic):0,0\n'
    + 'FIELD:naics_code:TYPE(STRING6):LIKE(invalid_naics):0,0\n'
    + 'FIELD:insp_type:TYPE(STRING1):LIKE(invalid_insp_type):0,0\n'
    + 'FIELD:insp_scope:TYPE(STRING1):LIKE(invalid_insp_scope):0,0\n'
    + 'FIELD:why_no_insp:TYPE(STRING1):LIKE(invalid_why_no_insp):0,0\n'
    + 'FIELD:union_status:TYPE(STRING1):LIKE(invalid_union_status):0,0\n'
    + 'FIELD:safety_manuf:TYPE(STRING1):LIKE(invalid_X_blank):0,0\n'
    + 'FIELD:safety_const:TYPE(STRING1):LIKE(invalid_X_blank):0,0\n'
    + 'FIELD:safety_marit:TYPE(STRING1):LIKE(invalid_X_blank):0,0\n'
    + 'FIELD:health_manuf:TYPE(STRING1):LIKE(invalid_X_blank):0,0\n'
    + 'FIELD:health_const:TYPE(STRING1):LIKE(invalid_X_blank):0,0\n'
    + 'FIELD:health_marit:TYPE(STRING1):LIKE(invalid_X_blank):0,0\n'
    + 'FIELD:migrant:TYPE(STRING1):LIKE(invalid_X_blank):0,0\n'
    + 'FIELD:mail_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:mail_zip:TYPE(STRING5):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:host_est_key:TYPE(STRING17):LIKE(invalid_host_est_key):0,0\n'
    + 'FIELD:nr_in_estab:TYPE(STRING5):LIKE(invalid_numeric_blank):0,0 \n'
    + 'FIELD:open_date:TYPE(STRING10):LIKE(invalid_date_dashes):0,0\n'
    + 'FIELD:case_mod_date:TYPE(STRING10):LIKE(invalid_date_dashes):0,0\n'
    + 'FIELD:close_conf_date:TYPE(STRING10):LIKE(invalid_date_dashes):0,0\n'
    + 'FIELD:close_case_date:TYPE(STRING10):LIKE(invalid_date_dashes):0,0\n'
    + 'FIELD:open_year:TYPE(STRING4):LIKE(invalid_year):0,0\n'
    + 'FIELD:case_mod_year:TYPE(STRING4):LIKE(invalid_year):0,0\n'
    + 'FIELD:close_conf_year:TYPE(STRING4):LIKE(invalid_year):0,0\n'
    + 'FIELD:close_case_year:TYPE(STRING4):LIKE(invalid_year):0,0\n'
    + 'FIELD:estab_name:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

