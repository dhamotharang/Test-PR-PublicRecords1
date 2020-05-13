// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT defendant_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Crim';
  EXPORT spc_NAMESCOPE := 'defendant';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,recordid,sourcename,sourcetype,statecode,recordtype,recorduploaddate,docnumber,fbinumber,stateidnumber,inmatenumber,aliennumber,orig_ssn,nametype,name,lastname,firstname,middlename,suffix,defendantstatus,defendantadditionalinfo,dob,birthcity,birthplace,age,gender,height,weight,haircolor,eyecolor,race,ethnicity,skincolor,bodymarks,physicalbuild,photoname,dlnumber,dlstate,phone,phonetype,uscitizenflag,addresstype,street,unit,city,orig_state,orig_zip,county,institutionname,institutiondetails,institutionreceiptdate,releasetolocation,releasetodetails,deceasedflag,deceaseddate,healthflag,healthdesc,bloodtype,sexoffenderregistrydate,sexoffenderregexpirationdate,sexoffenderregistrynumber,sourceid,vendor';
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
    + 'NAMESCOPE:defendant\n'
    + 'SOURCEFIELD:vendor\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_)\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Current_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Invalid_Source_ID:ALLOW(0123456789C)\n'
    + 'FIELDTYPE:Invalid_Inmate_Num:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-*,#@)\n'
    + 'FIELDTYPE:Invalid_Gender:ENUM(MALE|FEMALE|Female|Male|female|male|f|m|F|M|Unknown|UNKNOWN|U|u|)\n'
    + 'FIELDTYPE:Invalid_Zip:ALLOW(0123456789-)\n'
    + 'FIELDTYPE:Invalid_Race:CUSTOM(Scrubs_Crim.fn_StandardizeRace>0)\n'
    + 'FIELDTYPE:Invalid_Height:ALLOW(0123456789,"\')\n'
    + 'FIELDTYPE:Invalid_City:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.-,? )\n'
    + '\n'
    + 'FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0\n'
    + 'FIELD:sourcename:TYPE(STRING100):0,0\n'
    + 'FIELD:sourcetype:TYPE(STRING20):0,0\n'
    + 'FIELD:statecode:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:recordtype:TYPE(STRING20):0,0\n'
    + 'FIELD:recorduploaddate:TYPE(STRING8):0,0\n'
    + 'FIELD:docnumber:TYPE(STRING20):0,0\n'
    + 'FIELD:fbinumber:TYPE(STRING20):0,0\n'
    + 'FIELD:stateidnumber:TYPE(STRING20):0,0\n'
    + 'FIELD:inmatenumber:LIKE(Invalid_Inmate_Num):TYPE(STRING20):0,0\n'
    + 'FIELD:aliennumber:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:nametype:TYPE(STRING1):0,0\n'
    + 'FIELD:name:TYPE(STRING115):0,0\n'
    + 'FIELD:lastname:TYPE(STRING50):0,0\n'
    + 'FIELD:firstname:TYPE(STRING50):0,0\n'
    + 'FIELD:middlename:TYPE(STRING40):0,0\n'
    + 'FIELD:suffix:TYPE(STRING15):0,0\n'
    + 'FIELD:defendantstatus:TYPE(STRING100):0,0\n'
    + 'FIELD:defendantadditionalinfo:TYPE(STRING200):0,0\n'
    + 'FIELD:dob:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:birthcity:LIKE(Invalid_City):TYPE(STRING50):0,0\n'
    + 'FIELD:birthplace:TYPE(STRING100):0,0\n'
    + 'FIELD:age:TYPE(STRING3):0,0\n'
    + 'FIELD:gender:LIKE(Invalid_Gender):TYPE(STRING10):0,0\n'
    + 'FIELD:height:TYPE(STRING10):0,0\n'
    + 'FIELD:weight:TYPE(STRING10):0,0\n'
    + 'FIELD:haircolor:TYPE(STRING10):0,0\n'
    + 'FIELD:eyecolor:TYPE(STRING10):0,0\n'
    + 'FIELD:race:LIKE(Invalid_Race):TYPE(STRING50):0,0\n'
    + 'FIELD:ethnicity:TYPE(STRING20):0,0\n'
    + 'FIELD:skincolor:TYPE(STRING10):0,0\n'
    + 'FIELD:bodymarks:TYPE(STRING100):0,0\n'
    + 'FIELD:physicalbuild:TYPE(STRING20):0,0\n'
    + 'FIELD:photoname:TYPE(STRING50):0,0\n'
    + 'FIELD:dlnumber:TYPE(STRING20):0,0\n'
    + 'FIELD:dlstate:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:phone:TYPE(STRING20):0,0\n'
    + 'FIELD:phonetype:TYPE(STRING10):0,0\n'
    + 'FIELD:uscitizenflag:TYPE(STRING1):0,0\n'
    + 'FIELD:addresstype:TYPE(STRING20):0,0\n'
    + 'FIELD:street:TYPE(STRING150):0,0\n'
    + 'FIELD:unit:TYPE(STRING20):0,0\n'
    + 'FIELD:city:LIKE(Invalid_City):TYPE(STRING50):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_zip:LIKE(Invalid_Zip):TYPE(STRING9):0,0\n'
    + 'FIELD:county:TYPE(STRING50):0,0\n'
    + 'FIELD:institutionname:TYPE(STRING100):0,0\n'
    + 'FIELD:institutiondetails:TYPE(STRING200):0,0\n'
    + 'FIELD:institutionreceiptdate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:releasetolocation:TYPE(STRING100):0,0\n'
    + 'FIELD:releasetodetails:TYPE(STRING200):0,0\n'
    + 'FIELD:deceasedflag:TYPE(STRING1):0,0\n'
    + 'FIELD:deceaseddate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:healthflag:TYPE(STRING1):0,0\n'
    + 'FIELD:healthdesc:TYPE(STRING100):0,0\n'
    + 'FIELD:bloodtype:TYPE(STRING10):0,0\n'
    + 'FIELD:sexoffenderregistrydate:LIKE(Invalid_Current_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:sexoffenderregexpirationdate:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:sexoffenderregistrynumber:TYPE(STRING100):0,0\n'
    + 'FIELD:sourceid:TYPE(STRING20):0,0\n'
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

