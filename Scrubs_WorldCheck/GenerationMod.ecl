// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_WorldCheck';
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
  EXPORT spc_FILENAME := 'WorldCheck';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,uid,key,name_orig,name_type,last_name,first_name,category,title,sub_category,position,age,date_of_birth,places_of_birth,date_of_death,passports,social_security_number,location,countries,e_i_ind,keywords,entered,updated,editor,age_as_of_date';
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
    + 'MODULE:Scrubs_WorldCheck\n'
    + 'FILENAME:WorldCheck\n'
    + '\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz )\n'
    + 'FIELDTYPE:Invalid_AlphaCaps:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:Invalid_AlphaChar:CUSTOM(Scrubs_WorldCheck.Fn_Valid.Chars > 0, \'AlphaChar\')\n'
    + 'FIELDTYPE:Invalid_Keywords:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -~0123456789)\n'
    + 'FIELDTYPE:Invalid_Ind:ENUM(I|E|)\n'
    + 'FIELDTYPE:Invalid_SSN:ALLOW(0123456789-):LENGTHS(0,9,11)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_WorldCheck.Fn_Valid.Date > 0)\n'
    + '\n'
    + '\n'
    + 'FIELD:uid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:key:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:name_orig:TYPE(STRING255):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:name_type:TYPE(STRING1):LIKE(Invalid_No):0,0\n'
    + 'FIELD:last_name:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:first_name:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:category:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:title:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:sub_category:TYPE(STRING):LIKE(Invalid_AlphaCaps):0,0\n'
    + 'FIELD:position:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:age:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:date_of_birth:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:places_of_birth:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:date_of_death:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:passports:TYPE(STRING):0,0\n'
    + 'FIELD:social_security_number:TYPE(STRING):LIKE(Invalid_SSN):0,0\n'
    + 'FIELD:location:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:countries:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + '//FIELD:companies:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:e_i_ind:TYPE(STRING):LIKE(Invalid_Ind):0,0\n'
    + '//FIELD:linked_tos:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:keywords:TYPE(STRING):LIKE(Invalid_Keywords):0,0\n'
    + 'FIELD:entered:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:updated:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:editor:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:age_as_of_date:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

