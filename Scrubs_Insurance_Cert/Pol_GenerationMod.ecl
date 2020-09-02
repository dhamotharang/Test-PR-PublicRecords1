// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Pol_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Insurance_Cert';
  EXPORT spc_NAMESCOPE := 'Pol';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Insurance_Cert';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,date_firstseen,date_lastseen,bdid,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,lninscertrecordid,dartid,insuranceprovider,policynumber,coveragestartdate,coverageexpirationdate,coveragewrapup,policystatus,insuranceprovideraddressline,insuranceprovideraddressline2,insuranceprovidercity,insuranceproviderstate,insuranceproviderzip,insuranceproviderzip4,insuranceproviderphone,insuranceproviderfax,coveragereinstatedate,coveragecancellationdate,coveragewrapupdate,businessnameduringcoverage,addresslineduringcoverage,addressline2duringcoverage,cityduringcoverage,stateduringcoverage,zipduringcoverage,zip4duringcoverage,numberofemployeesduringcoverage,insuranceprovidercontactdept,insurancetype,coverageposteddate,coverageamountfrom,coverageamountto,unique_id,append_mailaddress1,append_mailaddresslast,append_mailrawaid,append_mailaceaid';
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
    + 'MODULE:Scrubs_Insurance_Cert\n'
    + 'FILENAME:Insurance_Cert\n'
    + 'NAMESCOPE:Pol\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.Fn_Valid_Date > 0)\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789NA)\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789,.-/NA)\n'
    + 'FIELDTYPE:Invalid_Alpha:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'Alpha\')\n'
    + 'FIELDTYPE:Invalid_AlphaNum:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNum\')\'\n'
    + 'FIELDTYPE:Invalid_AlphaChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaChar\')\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNumChar\')\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9)\n'
    + 'FIELDTYPE:Invalid_Phone:LIKE(Invalid_No):LENGTHS(0,9,10)\n'
    + '\n'
    + 'FIELD:date_firstseen:TYPE(UNSIGNED8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:date_lastseen:TYPE(UNSIGNED8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:lninscertrecordid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dartid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:insuranceprovider:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:policynumber:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:coveragestartdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:coverageexpirationdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:coveragewrapup:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:policystatus:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:insuranceprovideraddressline:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:insuranceprovideraddressline2:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:insuranceprovidercity:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:insuranceproviderstate:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:insuranceproviderzip:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:insuranceproviderzip4:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:insuranceproviderphone:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:insuranceproviderfax:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:coveragereinstatedate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:coveragecancellationdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:coveragewrapupdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:businessnameduringcoverage:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:addresslineduringcoverage:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:addressline2duringcoverage:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:cityduringcoverage:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:stateduringcoverage:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zipduringcoverage:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:zip4duringcoverage:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:numberofemployeesduringcoverage:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:insuranceprovidercontactdept:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:insurancetype:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:coverageposteddate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:coverageamountfrom:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:coverageamountto:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:unique_id:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:append_mailaddress1:TYPE(STRING100):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:append_mailaddresslast:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:append_mailrawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:append_mailaceaid:TYPE(UNSIGNED8):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

