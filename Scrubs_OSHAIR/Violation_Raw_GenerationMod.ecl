// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Violation_Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OSHAIR';
  EXPORT spc_NAMESCOPE := 'Violation_Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Violation_Raw_In_OSHAIR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,activity_nr,citation_id,delete_flag,viol_type,issuance_date,abate_date,current_penalty,initial_penalty,contest_date,final_order_date,nr_instances,nr_exposed,rec,gravity,emphasis,hazcat,fta_insp_nr,fta_issuance_date,fta_penalty,fta_contest_date,fta_final_order_date,hazsub1,hazsub2,hazsub3,hazsub4,hazsub5';
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
    + 'FILENAME:Violation_Raw_In_OSHAIR\n'
    + 'NAMESCOPE:Violation_Raw\n'
    + '\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_numeric_blank:CUSTOM(Scrubs_Oshair.Functions.fn_numeric_or_blank  > 0)\n'
    + 'FIELDTYPE:Invalid_rec:ENUM(1|A|C|I|F|V|D|B|R|S| )\n'
    + 'FIELDTYPE:Invalid_viol_type:ENUM(P|H|O|R|S|W|U|F| )\n'
    + 'FIELDTYPE:Invalid_X:ENUM(X| |x)\n'
    + 'FIELDTYPE:invalid_alpha_numeric:CUSTOM(Scrubs.Functions.fn_alphanum > 0)\n'
    + 'FIELDTYPE:Invalid_alpha_Numeric_blank:CUSTOM(Scrubs.Functions.fn_alphaNum_or_blank >0)\n'
    + 'FIELDTYPE:invalid_numeric_or_period:CUSTOM(Scrubs_Oshair.Functions.fn_numeric_or_period > 0)\n'
    + 'FIELDTYPE:invalid_alpha_blank:CUSTOM(Scrubs_Oshair.Functions.fn_alpha_blank > 0)\n'
    + 'FIELDTYPE:invalid_date_future:CUSTOM(Scrubs_Oshair.Functions.fn_date_time > 0, \'FUTURE\')\n'
    + 'FIELDTYPE:invalid_date_ccyymm:CUSTOM(Scrubs_Oshair.Functions.fn_date_ccyymm > 0)\n'
    + '\n'
    + 'FIELD:activity_nr:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:citation_id:TYPE(STRING7):LIKE(invalid_alpha_numeric):0,0\n'
    + 'FIELD:delete_flag:TYPE(STRING1):LIKE(Invalid_X):0,0\n'
    + 'FIELD:viol_type:TYPE(STRING1):LIKE(Invalid_viol_type):0,0\n'
    + 'FIELD:issuance_date:TYPE(STRING10):LIKE(invalid_date_ccyymm):0,0\n'
    + 'FIELD:abate_date:TYPE(STRING10):LIKE(invalid_date_future):0,0\n'
    + 'FIELD:current_penalty:TYPE(STRING10):LIKE(invalid_numeric_or_period):0,0\n'
    + 'FIELD:initial_penalty:TYPE(STRING10):LIKE(invalid_numeric_or_period):0,0\n'
    + 'FIELD:contest_date:TYPE(STRING10):LIKE(invalid_date_ccyymm):0,0\n'
    + 'FIELD:final_order_date:TYPE(STRING10):LIKE(invalid_date_future):0,0\n'
    + 'FIELD:nr_instances:TYPE(STRING5):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:nr_exposed:TYPE(STRING5):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:rec:TYPE(STRING1):LIKE(Invalid_rec):0,0\n'
    + 'FIELD:gravity:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:emphasis:TYPE(STRING1):LIKE(Invalid_X):0,0\n'
    + 'FIELD:hazcat:TYPE(STRING10):LIKE(invalid_alpha_blank):0,0\n'
    + 'FIELD:fta_insp_nr:TYPE(STRING9):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:fta_issuance_date:TYPE(STRING8):LIKE(invalid_date_ccyymm):0,0\n'
    + 'FIELD:fta_penalty:TYPE(STRING10):LIKE(invalid_numeric_or_period):0,0\n'
    + 'FIELD:fta_contest_date:TYPE(STRING8):LIKE(invalid_date_ccyymm):0,0\n'
    + 'FIELD:fta_final_order_date:TYPE(STRING8):LIKE(invalid_date_ccyymm):0,0\n'
    + 'FIELD:hazsub1:TYPE(STRING4):LIKE(Invalid_alpha_Numeric_blank):0,0\n'
    + 'FIELD:hazsub2:TYPE(STRING4):LIKE(Invalid_alpha_Numeric_blank):0,0\n'
    + 'FIELD:hazsub3:TYPE(STRING4):LIKE(Invalid_alpha_Numeric_blank):0,0\n'
    + 'FIELD:hazsub4:TYPE(STRING4):LIKE(Invalid_alpha_Numeric_blank):0,0\n'
    + 'FIELD:hazsub5:TYPE(STRING4):LIKE(Invalid_alpha_Numeric_blank):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

