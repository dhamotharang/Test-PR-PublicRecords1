// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT CC_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Debt_Settlement';
  EXPORT spc_NAMESCOPE := 'CC';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Debt_Settlement';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,idnum,businessname,dba,orgid,address1,address2,city,state,zip,zip4,phone,fax,email,url,status,licensedatefrom,licensedateto,orgtype,source';
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
    + 'MODULE:Scrubs_Debt_Settlement\n'
    + 'FILENAME:Debt_Settlement\n'
    + 'NAMESCOPE:CC \n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '\n'
    + 'FIELDTYPE:Invalid_id:CUSTOM(Scrubs.functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:Invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_mandatory_alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0) \n'
    + 'FIELDTYPE:Invalid_St:CUSTOM(Scrubs.functions.fn_valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:Invalid_zip:CUSTOM(Scrubs.functions.fn_numeric_optional>0,5)\n'
    + 'FIELDTYPE:Invalid_zip4:CUSTOM(Scrubs.functions.fn_numeric_optional>0,4)\n'
    + 'FIELDTYPE:Invalid_Phone:CUSTOM(Scrubs.functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:Invalid_Status:CUSTOM(Scrubs_Debt_Settlement.functions.fn_valid_status>0)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.functions.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.functions.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Invalid_OrgType:CUSTOM(Scrubs_Debt_Settlement.functions.fn_valid_orgtype>0)\n'
    + '\n'
    + 'FIELD:idnum:LIKE(Invalid_id):0,0            \n'
    + 'FIELD:businessname:LIKE(Invalid_mandatory_alpha):0,0\n'
    + 'FIELD:dba:LIKE(Invalid_alpha):0,0          \n'
    + 'FIELD:orgid:LIKE(Invalid_alpha):0,0          \n'
    + 'FIELD:address1:LIKE(Invalid_alpha):0,0       \n'
    + 'FIELD:address2:LIKE(Invalid_alpha):0,0       \n'
    + 'FIELD:city:LIKE(Invalid_alpha):0,0           \n'
    + 'FIELD:state:LIKE(Invalid_St):0,0          \n'
    + 'FIELD:zip:LIKE(Invalid_zip):0,0            \n'
    + 'FIELD:zip4:LIKE(Invalid_zip4):0,0           \n'
    + 'FIELD:phone:LIKE(Invalid_Phone):0,0          \n'
    + 'FIELD:fax:0,0            \n'
    + 'FIELD:email:0,0          \n'
    + 'FIELD:url:LIKE(Invalid_alpha):0,0              \n'
    + 'FIELD:status:LIKE(Invalid_Status):0,0         \n'
    + 'FIELD:licensedatefrom:LIKE(Invalid_Date):0,0\n'
    + 'FIELD:licensedateto:LIKE(Invalid_Future_Date):0,0  \n'
    + 'FIELD:orgtype:LIKE(Invalid_OrgType):0,0        \n'
    + 'FIELD:source:LIKE(Invalid_mandatory):0,0    \n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

