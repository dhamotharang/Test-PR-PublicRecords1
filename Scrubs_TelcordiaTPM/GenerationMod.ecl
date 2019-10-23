// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.0';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_TelcordiaTPM';
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
  EXPORT spc_FILENAME := 'TelcordiaTPM';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,npa,nxx,tb,city,st,ocn,company_type,nxx_type,dial_ind,point_id,lf,zip';
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
    + 'MODULE:Scrubs_TelcordiaTPM\n'
    + 'FILENAME:TelcordiaTPM\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_TB:ALLOW(0123456789A)\n'
    + 'FIELDTYPE:Invalid_CompanyType:ENUM(0|7|5|1|8|4|6|9|3)\n'
    + 'FIELDTYPE:Invalid_dialind:ENUM(1|0)\n'
    + 'FIELDTYPE:Invalid_PointID:ENUM(0|2|4|6|3|C)\n'
    + '\n'
    + '\n'
    + 'FIELD:npa:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:nxx:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:tb:LIKE(Invalid_TB):TYPE(STRING1):0,0\n'
    + 'FIELD:city:TYPE(STRING50):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:ocn:TYPE(STRING30):0,0\n'
    + 'FIELD:company_type:LIKE(Invalid_CompanyType):TYPE(STRING1):0,0\n'
    + 'FIELD:nxx_type:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:dial_ind:LIKE(Invalid_dialind):TYPE(STRING1):0,0\n'
    + 'FIELD:point_id:LIKE(Invalid_PointID):TYPE(STRING1):0,0\n'
    + 'FIELD:lf:TYPE(STRING1):0,0\n'
    + 'FIELD:zip:LIKE(Invalid_Num):TYPE(STRING5):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

