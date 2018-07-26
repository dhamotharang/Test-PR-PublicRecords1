// Machine-readable versions of the spec file and subsets thereof
EXPORT Airmen_Cert_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FAA';
  EXPORT spc_NAMESCOPE := 'Airmen_Cert';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_FAA\n'
    + 'FILENAME:FAA\n'
    + 'NAMESCOPE:Airmen_Cert\n'
    + 'OPTIONS:-gh\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:Invalid_CerLevel:ENUM(P|S|C|A|Y|Z|W|T|U|V|)\n'
    + 'FIELDTYPE:Invalid_CerType:ENUM(P|F|M|Y|G|R|T|E|U|D|I|W|L|Z|N|H|A|X|J|)\n'
    + 'FIELDTYPE:Invalid_RecType:ENUM(01|02|03|04|05|06|07|)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Flag:ENUM(H|I|A)\n'
    + 'FIELDTYPE:Invalid_LetterCode:ENUM(A|C)\n'
    + '\n'
    + 'FIELD:date_first_seen:Like(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:date_last_seen:Like(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:current_flag:Like(Invalid_Flag):TYPE(STRING1):0,0\n'
    + 'FIELD:letter:Like(Invalid_LetterCode):TYPE(STRING1):0,0\n'
    + 'FIELD:unique_id:Like(Invalid_Num):TYPE(STRING7):0,0\n'
    + 'FIELD:rec_type:Like(Invalid_RecType):TYPE(STRING2):0,0\n'
    + 'FIELD:cer_type:Like(Invalid_CerType):TYPE(STRING1):0,0\n'
    + 'FIELD:cer_type_mapped:TYPE(STRING20):0,0\n'
    + 'FIELD:cer_level:Like(Invalid_CerLevel):TYPE(STRING1):0,0\n'
    + 'FIELD:cer_level_mapped:TYPE(STRING45):0,0\n'
    + 'FIELD:cer_exp_date:Like(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:ratings:TYPE(STRING99):0,0\n'
    + 'FIELD:filler:TYPE(STRING79):0,0\n'
    + 'FIELD:lfcr:TYPE(STRING2):0,0\n'
    + 'FIELD:persistent_record_id:TYPE(UNSIGNED8):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
