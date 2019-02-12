// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT PCR_PII_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Overrides';
  EXPORT spc_NAMESCOPE := 'PCR_PII';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Overrides';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,uid,date_created,dt_first_seen,dt_last_seen,did,fname,mname,lname,name_suffix,ssn,dob,predir,prim_name,prim_range,suffix,postdir,unit_desig,sec_range,zip4,address,city_name,st,zip,phone,dl_number,dl_state,dispute_flag,security_freeze,security_freeze_pin,security_alert,negative_alert,id_theft_flag,insuff_inqry_data,consumer_statement_flag';
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
    + 'MODULE:Scrubs_Overrides\n'
    + 'FILENAME:Overrides\n'
    + 'NAMESCOPE:PCR_PII\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'.-,#)\n'
    + 'FIELDTYPE:Invalid_SSN:ALLOW(0123456789):LENGTHS(0,9)\n'
    + 'FIELDTYPE:Invalid_DOB:ALLOW(0123456789):LENGTHS(0,8)\n'
    + 'FIELDTYPE:Invalid_DLNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789)\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2)\n'
    + '\n'
    + '\n'
    + 'FIELD:uid:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:date_created:LIKE(Invalid_Date):TYPE(STRING):0,0\n'
    + 'FIELD:dt_first_seen:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:dt_last_seen:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:did:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:fname:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:mname:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:lname:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:name_suffix:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:ssn:LIKE(Invalid_SSN):TYPE(STRING):0,0\n'
    + 'FIELD:dob:LIKE(Invalid_DOB):TYPE(STRING):0,0\n'
    + 'FIELD:predir:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:prim_name:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:prim_range:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:suffix:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:postdir:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:unit_desig:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:sec_range:LIKE(Invalid_Char):TYPE(STRING):0,0\n'
    + 'FIELD:zip4:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:address:TYPE(STRING):0,0\n'
    + 'FIELD:city_name:TYPE(STRING):0,0\n'
    + 'FIELD:st:LIKE(Invalid_State):TYPE(STRING):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:dl_number:LIKE(Invalid_DLNum):TYPE(STRING):0,0\n'
    + 'FIELD:dl_state:LIKE(Invalid_State):TYPE(STRING):0,0\n'
    + 'FIELD:dispute_flag:TYPE(STRING):0,0\n'
    + 'FIELD:security_freeze:TYPE(STRING):0,0\n'
    + 'FIELD:security_freeze_pin:TYPE(STRING):0,0\n'
    + 'FIELD:security_alert:TYPE(STRING):0,0\n'
    + 'FIELD:negative_alert:TYPE(STRING):0,0\n'
    + 'FIELD:id_theft_flag:TYPE(STRING):0,0\n'
    + 'FIELD:insuff_inqry_data:TYPE(STRING):0,0\n'
    + 'FIELD:consumer_statement_flag:TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

