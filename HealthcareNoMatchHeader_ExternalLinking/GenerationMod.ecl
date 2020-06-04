// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'HealthcareNoMatchHeader_ExternalLinking';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := 'XNOMATCH';
  EXPORT spc_PROCLAYOUTS := 'Process_XNOMATCH_Layouts';
  EXPORT spc_IDNAME := 'nomatch_id'; // cluster id (input)
  EXPORT spc_IDFIELD := 'nomatch_id'; // cluster id (output)
  EXPORT spc_RIDFIELD := 'RID'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'SRC';
  EXPORT spc_FILEPREFIX := 'File_';
  EXPORT spc_FILENAME := 'HEADER';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:RID';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_nomatch_id */,SRC,SSN,DOB,LEXID,SUFFIX,FNAME,MNAME,LNAME,GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY_NAME,ST,ZIP,DT_FIRST_SEEN,DT_LAST_SEEN,MAINNAME,ADDR1,LOCALE,ADDRESS,FULLNAME';
  EXPORT spc_HAS_TWOSTEP := TRUE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := TRUE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-ma -gs2\n'
    + 'THRESHOLD:45\n'
    + 'MODULE:HealthcareNoMatchHeader_ExternalLinking\n'
    + 'IDNAME:nomatch_id\n'
    + 'RIDFIELD:RID\n'
    + 'FILENAME:HEADER\n'
    + 'IDFIELD:EXISTS:nomatch_id\n'
    + 'RECORDS:285873\n'
    + 'POPULATION:300000\n'
    + 'NINES:3\n'
    + 'PROCESS:XNOMATCH\n'
    + '// HACK:SLICEDISTANCE:18\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\'):ONFAIL(CLEAN):\n'
    + 'FIELDTYPE:NUMBER:LIKE():ALLOW(0123456789):NOQUOTES("\'):ONFAIL(CLEAN):\n'
    + '// Source Field - CARRY option ignores it for linking\n'
    + 'FIELD:SRC:CARRY\n'
    + 'SOURCEFIELD:SRC\n'
    + '// FUZZY\n'
    + 'FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)\n'
    + 'FUZZY:TrimLeadingZero:RST:CUSTOM(fn_TrimLeadingZero):TYPE(STRING20)\n'
    + 'FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)\n'
    + '// SSN-DOB\n'
    + 'FIELD:SSN:LIKE(NUMBER):EDIT1:0,0\n'
    + 'DATEFIELD:DOB:PROP:SOFT1(4.0):MDDM:YEARSHIFT12(4.0):FORCE(GENERATION,--3):0,0\n'
    + '// LexID\n'
    + 'FIELD:LEXID:PROP:LIKE(NUMBER):18,0\n'
    + '// Name\n'
    + 'FIELD:SUFFIX:PROP:10,0\n'
    + 'FIELD:FNAME:PROP:EDITX(8):INITIAL:PreferredName:FORCE(--):8,0\n'
    + 'FIELD:MNAME:PROP:INITIAL:EDITX(6):14,0\n'
    + 'FIELD:LNAME:PROP:INITIAL:HYPHEN2:EDITX(6):10,0\n'
    + 'FIELD:GENDER:1,0\n'
    + '// Address\n'
    + 'FIELD:PRIM_NAME:10,0\n'
    + 'FIELD:PRIM_RANGE:13,0\n'
    + 'FIELD:SEC_RANGE:HYPHEN2:8,0\n'
    + 'FIELD:CITY_NAME:6,0\n'
    + 'FIELD:ST:0,0\n'
    + 'FIELD:ZIP:6,0\n'
    + '// Date\n'
    + 'FIELD:DT_FIRST_SEEN:RECORDDATE(FIRST,YYYYMM):0,0\n'
    + 'FIELD:DT_LAST_SEEN:RECORDDATE(LAST,YYYYMM):0,0\n'
    + '// Concept\n'
    + 'CONCEPT:MAINNAME:FNAME:MNAME:LNAME:BAGOFWORDS:18,0\n'
    + 'CONCEPT:ADDR1:PRIM_RANGE:SEC_RANGE:PRIM_NAME:16,0\n'
    + 'CONCEPT:LOCALE:CITY_NAME:ST:ZIP:6,0\n'
    + 'CONCEPT:ADDRESS:ADDR1:LOCALE:16,0\n'
    + 'CONCEPT:FULLNAME:MAINNAME:SUFFIX:18,0\n'
    + '\n'
    + 'LINKPATH:NOMATCH:DOB:FNAME:?:LNAME:CITY_NAME:+:ZIP:ST:GENDER:PRIM_NAME:PRIM_RANGE:MNAME:SSN:LEXID:SEC_RANGE:SUFFIX\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    {'NOMATCH','DOB,FNAME','LNAME,CITY_NAME','ZIP,ST,GENDER,PRIM_NAME,PRIM_RANGE,MNAME,SSN,LEXID,SEC_RANGE,SUFFIX','',''}
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

