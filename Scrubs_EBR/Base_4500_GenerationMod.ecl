// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_4500_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_EBR';
  EXPORT spc_NAMESCOPE := 'Base_4500';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,powid,proxid,seleid,orgid,ultid,bdid,date_first_seen,date_last_seen,process_date_first_seen,process_date_last_seen,record_type,process_date,file_number,segment_code,sequence_number,total_ucc_filed,coll_count_ucc,coll_code1,coll_desc1,coll_code2,coll_desc2,coll_code3,coll_desc3,coll_code4,coll_desc4,coll_code5,coll_desc5,coll_code6,coll_desc6,coll_code7,coll_desc7,coll_code8,coll_desc8,coll_code9,coll_desc9,coll_code10,coll_desc10,coll_code11,coll_desc11,coll_code12,coll_desc12,addtnl_coll_codes';
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
    + 'NAMESCOPE:Base_4500\n'
    + '//--------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//--------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_EBR.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_numeric_or_allzeros:CUSTOM(Scrubs_EBR.Functions.fn_numeric_or_allzeros>0)\n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_EBR.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_dt_first_seen:CUSTOM(Scrubs_EBR.Functions.fn_dt_first_seen>0)\n'
    + 'FIELDTYPE:invalid_dt_yymmdd:CUSTOM(Scrubs_EBR.Functions.fn_dt_yymmdd>0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(H|C)\n'
    + 'FIELDTYPE:invalid_segment:ENUM(4500|4500)\n'
    + 'FIELDTYPE:invalid_file_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(9)\n'
    + 'FIELDTYPE:invalid_coll_code:CUSTOM(Scrubs_EBR.Functions.fn_valid_coll_code>0)\n'
    + 'FIELDTYPE:invalid_coll_desc::CUSTOM(Scrubs_EBR.Functions.fn_valid_coll_desc>0)\n'
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
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:file_number:TYPE(STRING10):LIKE(invalid_file_number):0,0\n'
    + 'FIELD:segment_code:TYPE(STRING4):LIKE(invalid_segment):0,0\n'
    + 'FIELD:sequence_number:TYPE(STRING5):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:total_ucc_filed:TYPE(STRING3):LIKE(invalid_numeric_or_allzeros):0,0\n'
    + 'FIELD:coll_count_ucc:TYPE(STRING3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:coll_code1:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc1:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code2:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc2:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code3:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc3:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code4:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc4:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code5:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc5:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code6:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc6:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code7:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc7:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code8:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc8:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code9:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc9:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code10:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc10:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code11:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc11:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:coll_code12:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + 'FIELD:coll_desc12:TYPE(STRING36):LIKE(invalid_coll_desc):0,0\n'
    + 'FIELD:addtnl_coll_codes:TYPE(STRING1):LIKE(invalid_coll_code):0,0\n'
    + '// FIELD:lf:TYPE(STRING1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

