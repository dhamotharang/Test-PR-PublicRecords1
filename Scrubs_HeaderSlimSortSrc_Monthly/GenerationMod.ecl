// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_HeaderSlimSortSrc_Monthly';
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
  EXPORT spc_FILENAME := 'File';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,src,did,fname,lname,prim_range,prim_name,zip,mname,sec_range,name_suffix,ssn,dob,dids_with_this_nm_addr,suffix_cnt_with_this_nm_addr,sec_range_cnt_with_this_nm_addr,ssn_cnt_with_this_nm_addr,dob_cnt_with_this_nm_addr,mname_cnt_with_this_nm_addr,dids_with_this_nm_ssn,dob_cnt_with_this_nm_ssn,dids_with_this_nm_dob,zip_cnt_with_this_nm_dob';
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
    + 'MODULE:Scrubs_HeaderSlimSortSrc_Monthly\n'
    + 'FILENAME:File\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + '\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + '\n'
    + 'FIELDTYPE:src:SPACES( ):LIKE(Invalid_AlphaNum):LENGTHS(2):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:did:SPACES( ):LIKE(Invalid_Num):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:fname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:lname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:prim_range:SPACES( ):ALLOW(-/0123456789ABNW):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:prim_name:SPACES( ):LIKE(Invalid_AlphaNum):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:zip:SPACES( ):LIKE(Invalid_Num):LENGTHS(5,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:mname:SPACES( ):LIKE(Invalid_Alpha):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:sec_range:SPACES( ):ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVW):LENGTHS(0,3,1,2,4,5,6):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:name_suffix:SPACES( ):ALLOW(12345JRS):LENGTHS(0,2,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:ssn:SPACES( ):LIKE(Invalid_Num):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dob:SPACES( ):LIKE(Invalid_Num):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dids_with_this_nm_addr:SPACES( ):ALLOW(123):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:suffix_cnt_with_this_nm_addr:SPACES( ):ALLOW(123):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:sec_range_cnt_with_this_nm_addr:SPACES( ):ALLOW(12345):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:ssn_cnt_with_this_nm_addr:SPACES( ):ALLOW(123):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dob_cnt_with_this_nm_addr:SPACES( ):ALLOW(1234):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:mname_cnt_with_this_nm_addr:SPACES( ):ALLOW(123):LENGTHS(1,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dids_with_this_nm_ssn:SPACES( ):ALLOW(1):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dob_cnt_with_this_nm_ssn:SPACES( ):ALLOW(12):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:dids_with_this_nm_dob:SPACES( ):ALLOW(123):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:zip_cnt_with_this_nm_dob:SPACES( ):ALLOW(123):LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELD:src:TYPE(STRING2):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:mname:TYPE(STRING1):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:dob:TYPE(UNSIGNED4):0,0\n'
    + 'FIELD:dids_with_this_nm_addr:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:suffix_cnt_with_this_nm_addr:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:sec_range_cnt_with_this_nm_addr:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ssn_cnt_with_this_nm_addr:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dob_cnt_with_this_nm_addr:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:mname_cnt_with_this_nm_addr:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dids_with_this_nm_ssn:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dob_cnt_with_this_nm_ssn:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dids_with_this_nm_dob:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:zip_cnt_with_this_nm_dob:TYPE(UNSIGNED2):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

