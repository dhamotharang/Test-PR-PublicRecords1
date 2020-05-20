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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,lnpolicyid,lninscertrecordid,dartid,insuranceprovider,policynumber,coveragestartdate,coverageexpirationdate,coveragewrapup,policystatus,insuranceprovideraddressline,insuranceprovideraddressline2,insuranceprovidercity,insuranceproviderstate,insuranceproviderzip,insuranceproviderzip4,insuranceproviderphone,insuranceproviderfax,coveragereinstatedate,coveragecancellationdate,coveragewrapupdate,businessnameduringcoverage,addresslineduringcoverage,addressline2duringcoverage,cityduringcoverage,stateduringcoverage,zipduringcoverage,zip4duringcoverage,numberofemployeesduringcoverage,insuranceprovidercontactdept,insurancetype,coverageposteddate,coverageamountfrom,coverageamountto';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    + '\n'
    + '\n'
    + 'FIELD:lnpolicyid:TYPE(STRING):0,0\n'
    + 'FIELD:lninscertrecordid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dartid:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceprovider:TYPE(STRING):0,0\n'
    + 'FIELD:policynumber:TYPE(STRING):0,0\n'
    + 'FIELD:coveragestartdate:TYPE(STRING):0,0\n'
    + 'FIELD:coverageexpirationdate:TYPE(STRING):0,0\n'
    + 'FIELD:coveragewrapup:TYPE(STRING):0,0\n'
    + 'FIELD:policystatus:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceprovideraddressline:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceprovideraddressline2:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceprovidercity:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceproviderstate:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceproviderzip:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceproviderzip4:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceproviderphone:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceproviderfax:TYPE(STRING):0,0\n'
    + 'FIELD:coveragereinstatedate:TYPE(STRING):0,0\n'
    + 'FIELD:coveragecancellationdate:TYPE(STRING):0,0\n'
    + 'FIELD:coveragewrapupdate:TYPE(STRING):0,0\n'
    + 'FIELD:businessnameduringcoverage:TYPE(STRING):0,0\n'
    + 'FIELD:addresslineduringcoverage:TYPE(STRING):0,0\n'
    + 'FIELD:addressline2duringcoverage:TYPE(STRING):0,0\n'
    + 'FIELD:cityduringcoverage:TYPE(STRING):0,0\n'
    + 'FIELD:stateduringcoverage:TYPE(STRING):0,0\n'
    + 'FIELD:zipduringcoverage:TYPE(STRING):0,0\n'
    + 'FIELD:zip4duringcoverage:TYPE(STRING):0,0\n'
    + 'FIELD:numberofemployeesduringcoverage:TYPE(STRING):0,0\n'
    + 'FIELD:insuranceprovidercontactdept:TYPE(STRING):0,0\n'
    + 'FIELD:insurancetype:TYPE(STRING):0,0\n'
    + 'FIELD:coverageposteddate:TYPE(STRING):0,0\n'
    + 'FIELD:coverageamountfrom:TYPE(STRING):0,0\n'
    + 'FIELD:coverageamountto:TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

