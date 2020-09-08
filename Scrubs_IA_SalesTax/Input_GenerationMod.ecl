// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_IA_SalesTax';
  EXPORT spc_NAMESCOPE := 'Input';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'IA_SalesTax';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,permit_nbr,issue_date,owner_name,business_name,city_mailing_address,mailing_address,state_mailing_address,mailing_zip_code,location_address,city_of_location,state_of_location,location_zip_code';
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
    + 'MODULE:Scrubs_IA_SalesTax\n'
    + 'FILENAME:IA_SalesTax\n'
    + 'NAMESCOPE:Input\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_permit_nbr:CUSTOM(Scrubs.Functions.fn_numeric>0,9)\n'
    + 'FIELDTYPE:invalid_issue_date:CUSTOM(Scrubs_IA_SalesTax.Functions.fn_valid_Date>0)\n'
    + 'FIELDTYPE:invalid_owner_name:CUSTOM(Scrubs_IA_SalesTax.Functions.fn_valid_name>0)\n'
    + 'FIELDTYPE:invalid_business_name:CUSTOM(Scrubs_IA_SalesTax.Functions.fn_valid_name>0)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip:CUSTOM(Scrubs.Functions.fn_verify_zip59 >0)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB \n'
    + '//---------------------------------------------------------------\n'
    + 'FIELD:permit_nbr:TYPE(STRING9):LIKE(invalid_permit_nbr):0,0\n'
    + 'FIELD:issue_date:TYPE(STRING10):LIKE(invalid_issue_date):0,0\n'
    + 'FIELD:owner_name:TYPE(STRING40):LIKE(invalid_owner_name):0,0\n'
    + 'FIELD:business_name:TYPE(STRING40):LIKE(invalid_business_name):0,0\n'
    + 'FIELD:city_mailing_address:TYPE(STRING20):0,0\n'
    + 'FIELD:mailing_address:TYPE(STRING50):0,0\n'
    + 'FIELD:state_mailing_address:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:mailing_zip_code:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + 'FIELD:location_address:TYPE(STRING50):0,0\n'
    + 'FIELD:city_of_location:TYPE(STRING20):0,0\n'
    + 'FIELD:state_of_location:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:location_zip_code:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

