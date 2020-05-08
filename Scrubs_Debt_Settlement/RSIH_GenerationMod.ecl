// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT RSIH_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Debt_Settlement';
  EXPORT spc_NAMESCOPE := 'RSIH';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,avdanumber,attorneyname,businessname,address1,address2,phone,email,primary_range_cln,primary_name_cln,sec_range_cln,zip_cln,did_header_addr_count,did_header_phone_count,did_phoneplus_gongphone_count';
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
    + 'NAMESCOPE:RSIH\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + 'FIELDTYPE:Invalid_avdanum:ALLOW(0123456789):LENGTHS(1..5)\n'
    + 'FIELDTYPE:Invalid_mandatory_alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0) \n'
    + 'FIELDTYPE:Invalid_numeric:CUSTOM(Scrubs.functions.fn_numeric>0)\n'
    + 'FIELDTYPE:Invalid_Phone:CUSTOM(Scrubs.functions.fn_verify_optional_phone>0)\n'
    + '          \n'
    + 'FIELD:avdanumber:LIKE(Invalid_avdanum):0,0\n'
    + 'FIELD:attorneyname:LIKE(Invalid_mandatory_alpha):0,0\n'
    + 'FIELD:businessname:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:address1:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:address2:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Phone):0,0  \n'
    + 'FIELD:email:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:primary_range_cln:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:primary_name_cln:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:sec_range_cln:LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:zip_cln:LIKE(Invalid_numeric):0,0\n'
    + 'FIELD:did_header_addr_count:LIKE(Invalid_numeric):0,0\n'
    + 'FIELD:did_header_phone_count:LIKE(Invalid_numeric):0,0\n'
    + 'FIELD:did_phoneplus_gongphone_count:0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

