// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Party_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Official_Records';
  EXPORT spc_NAMESCOPE := 'Party';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Official_Records';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,process_date,vendor,state_origin,county_name,official_record_key,doc_instrument_or_clerk_filing_num,doc_filed_dt,doc_type_desc,entity_sequence,entity_type_cd,entity_type_desc,entity_nm,entity_nm_format,entity_dob,entity_ssn,title1,fname1,mname1,lname1,suffix1,pname1_score,cname1,title2,fname2,mname2,lname2,suffix2,pname2_score,cname2,title3,fname3,mname3,lname3,suffix3,pname3_score,cname3,title4,fname4,mname4,lname4,suffix4,pname4_score,cname4,title5,fname5,mname5,lname5,suffix5,pname5_score,cname5,master_party_type_cd';
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
    + 'MODULE:Scrubs_Official_Records\n'
    + 'FILENAME:Official_Records\n'
    + 'NAMESCOPE:Party\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_State:ENUM(FL|CA)\n'
    + 'FIELDTYPE:Invalid_County:CUSTOM(Scrubs_Official_Records.fnValidCounty>0)\n'
    + 'FIELDTYPE:Invalid_NonBlank:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -\')\n'
    + '\n'
    + 'FIELD:process_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:vendor:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:state_origin:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:county_name:LIKE(Invalid_County):TYPE(STRING30):0,0\n'
    + 'FIELD:official_record_key:LIKE(Invalid_NonBlank):TYPE(STRING60):0,0\n'
    + 'FIELD:doc_instrument_or_clerk_filing_num:TYPE(STRING25):0,0\n'
    + 'FIELD:doc_filed_dt:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:doc_type_desc:LIKE(Invalid_NonBlank):TYPE(STRING60):0,0\n'
    + 'FIELD:entity_sequence:TYPE(STRING5):0,0\n'
    + 'FIELD:entity_type_cd:LIKE(Invalid_NonBlank):TYPE(STRING15):0,0\n'
    + 'FIELD:entity_type_desc:TYPE(STRING50):0,0\n'
    + 'FIELD:entity_nm:TYPE(STRING80):0,0\n'
    + 'FIELD:entity_nm_format:TYPE(STRING1):0,0\n'
    + 'FIELD:entity_dob:TYPE(STRING8):0,0\n'
    + 'FIELD:entity_ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:title1:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:fname1:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:mname1:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:lname1:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:suffix1:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:pname1_score:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:cname1:LIKE(Invalid_Char):TYPE(STRING70):0,0\n'
    + 'FIELD:title2:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:fname2:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:mname2:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:lname2:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:suffix2:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:pname2_score:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:cname2:LIKE(Invalid_Char):TYPE(STRING70):0,0\n'
    + 'FIELD:title3:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:fname3:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:mname3:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:lname3:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:suffix3:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:pname3_score:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:cname3:LIKE(Invalid_Char):TYPE(STRING70):0,0\n'
    + 'FIELD:title4:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:fname4:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:mname4:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:lname4:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:suffix4:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:pname4_score:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:cname4:LIKE(Invalid_Char):TYPE(STRING70):0,0\n'
    + 'FIELD:title5:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:fname5:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:mname5:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:lname5:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:suffix5:LIKE(Invalid_Char):TYPE(STRING5):0,0\n'
    + 'FIELD:pname5_score:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:cname5:LIKE(Invalid_Char):TYPE(STRING70):0,0\n'
    + 'FIELD:master_party_type_cd:TYPE(STRING1):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

