// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT sentence_counties_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Crim';
  EXPORT spc_NAMESCOPE := 'sentence_counties';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'vendor';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'crim';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,recordid,statecode,caseid,sentencedate,sentencebegindate,sentenceenddate,sentencetype,sentencemaxyears,sentencemaxmonths,sentencemaxdays,sentenceminyears,sentenceminmonths,sentencemindays,scheduledreleasedate,actualreleasedate,sentencestatus,timeservedyears,timeservedmonths,timeserveddays,publicservicehours,sentenceadditionalinfo,communitysupervisioncounty,communitysupervisionyears,communitysupervisionmonths,communitysupervisiondays,parolebegindate,paroleenddate,paroleeligibilitydate,parolehearingdate,parolemaxyears,parolemaxmonths,parolemaxdays,paroleminyears,paroleminmonths,parolemindays,parolestatus,paroleofficer,paroleoffcerphone,probationbegindate,probationenddate,probationmaxyears,probationmaxmonths,probationmaxdays,probationminyears,probationminmonths,probationmindays,probationstatus,sourcename,vendor';
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
    + 'MODULE:Scrubs_Crim\n'
    + 'FILENAME:crim\n'
    + 'NAMESCOPE:sentence_counties\n'
    + 'SOURCEFIELD:vendor\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_)\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Non_Blank:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789.)\n'
    + 'FIELDTYPE:Invalid_Time:ALLOW(0123456789. DAYSMONTHYERLIF/)\n'
    + '\n'
    + 'FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0\n'
    + 'FIELD:statecode:LIKE(Invalid_Char):TYPE(STRING2):0,0\n'
    + 'FIELD:caseid:LIKE(Non_Blank):TYPE(STRING40):0,0\n'
    + 'FIELD:sentencedate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:sentencebegindate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:sentenceenddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:sentencetype:TYPE(STRING20):0,0\n'
    + 'FIELD:sentencemaxyears:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:sentencemaxmonths:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:sentencemaxdays:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:sentenceminyears:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:sentenceminmonths:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:sentencemindays:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:scheduledreleasedate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:actualreleasedate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:sentencestatus:TYPE(STRING100):0,0\n'
    + 'FIELD:timeservedyears:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:timeservedmonths:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:timeserveddays:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:publicservicehours:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:sentenceadditionalinfo:TYPE(STRING200):0,0\n'
    + 'FIELD:communitysupervisioncounty:TYPE(STRING50):0,0\n'
    + 'FIELD:communitysupervisionyears:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:communitysupervisionmonths:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:communitysupervisiondays:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:parolebegindate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:paroleenddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:paroleeligibilitydate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:parolehearingdate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:parolemaxyears:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:parolemaxmonths:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:parolemaxdays:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:paroleminyears:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:paroleminmonths:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:parolemindays:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:parolestatus:TYPE(STRING100):0,0\n'
    + 'FIELD:paroleofficer:TYPE(STRING50):0,0\n'
    + 'FIELD:paroleoffcerphone:TYPE(STRING20):0,0\n'
    + 'FIELD:probationbegindate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:probationenddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:probationmaxyears:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:probationmaxmonths:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:probationmaxdays:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:probationminyears:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:probationminmonths:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:probationmindays:LIKE(Invalid_Time):TYPE(STRING10):0,0\n'
    + 'FIELD:probationstatus:TYPE(STRING100):0,0\n'
    + 'FIELD:sourcename:LIKE(Non_Blank):TYPE(STRING100):0,0\n'
    + 'FIELD:vendor:TYPE(STRING10):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

