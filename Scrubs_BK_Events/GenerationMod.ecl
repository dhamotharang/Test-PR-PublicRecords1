// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_BK_Events';
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
  EXPORT spc_FILENAME := 'BK_Events';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dractivitytypecode,docketentryid,courtid,casekey,casetype,bkcasenumber,bkcasenumberurl,proceedingscasenumber,proceedingscasenumberurl,caseid,pacercaseid,attachmenturl,entrynumber,entereddate,pacer_entereddate,fileddate,score,drcategoryeventid,court_code,district,boca_court,catevent_description,catevent_category';
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
    + 'MODULE:Scrubs_BK_Events\n'
    + 'FILENAME:BK_Events\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Int:ALLOW(0123456789- )\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789., )\n'
    + 'FIELDTYPE:Invalid_CaseNo:ALLOW(0123456789-: ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_URL:ALLOW(0123456789:;-_=&./? abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Alpha:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'Alpha\')\n'
    + 'FIELDTYPE:Invalid_AlphaNum:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNum\', true)\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNumChar\', true)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_BK_Events.Functions.Fn_Valid_Date > 0)\n'
    + '\n'
    + 'FIELD:dractivitytypecode:TYPE(QSTRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:docketentryid:TYPE(STRING100):LIKE(Invalid_No):0,0\n'
    + 'FIELD:courtid:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:casekey:TYPE(STRING7):LIKE(Invalid_No):0,0\n'
    + 'FIELD:casetype:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:bkcasenumber:TYPE(STRING24):LIKE(Invalid_CaseNo):0,0\n'
    + 'FIELD:bkcasenumberurl:TYPE(STRING200):LIKE(Invalid_URL):0,0\n'
    + 'FIELD:proceedingscasenumber:TYPE(STRING24):LIKE(Invalid_CaseNo):0,0\n'
    + 'FIELD:proceedingscasenumberurl:TYPE(STRING200):LIKE(Invalid_URL):0,0\n'
    + 'FIELD:caseid:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:pacercaseid:TYPE(STRING10):LIKE(Invalid_Int):0,0\n'
    + 'FIELD:attachmenturl:TYPE(STRING200):LIKE(Invalid_URL):0,0\n'
    + 'FIELD:entrynumber:TYPE(STRING10):LIKE(Invalid_Int):0,0\n'
    + 'FIELD:entereddate:TYPE(STRING24):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:pacer_entereddate:TYPE(STRING24):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:fileddate:TYPE(STRING24):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:score:TYPE(STRING5):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:drcategoryeventid:TYPE(STRING5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:court_code:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:district:TYPE(STRING40):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:boca_court:TYPE(STRING5):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:catevent_description:TYPE(STRING200):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:catevent_category:TYPE(STRING200):LIKE(Invalid_AlphaNumChar):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

