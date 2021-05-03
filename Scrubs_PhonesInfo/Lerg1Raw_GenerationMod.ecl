// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Lerg1Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'Lerg1Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'PhonesInfo';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,ocn,ocn_name,ocn_abbr_name,ocn_state,category,overall_ocn,filler1,filler2,last_name,first_name,middle_initial,company_name,title,address1,address2,floor,room,city,state,postal_code,phone,target_ocn,overall_target_ocn,rural_lec_indicator,small_ilec_indicator,filename';
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
    + 'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:Lerg1Raw\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Alpha:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:Invalid_Category:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Char:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\',.)\n'
    + 'FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)\n'
    + 'FIELDTYPE:Invalid_Indicator:SPACES( ):ALLOW(X)\n'
    + 'FIELDTYPE:Invalid_NotBlank:LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Ocn:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Ocn_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(1..2)\n'
    + 'FIELDTYPE:Invalid_Phone:SPACES( ):ALLOW(0123456789-)\n'
    + '\n'
    + 'FIELD:ocn:LIKE(Invalid_Ocn):TYPE(STRING4):0,0\n'
    + 'FIELD:ocn_name:LIKE(Invalid_NotBlank):TYPE(STRING50):0,0\n'
    + 'FIELD:ocn_abbr_name:LIKE(Invalid_NotBlank):TYPE(STRING20):0,0\n'
    + 'FIELD:ocn_state:LIKE(Invalid_Ocn_State):TYPE(STRING2):0,0\n'
    + 'FIELD:category:LIKE(Invalid_Category):TYPE(STRING10):0,0\n'
    + 'FIELD:overall_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0\n'
    + 'FIELD:filler1:TYPE(STRING5):0,0\n'
    + 'FIELD:filler2:TYPE(STRING1):0,0\n'
    + 'FIELD:last_name:LIKE(Invalid_NotBlank):TYPE(STRING20):0,0\n'
    + 'FIELD:first_name:LIKE(Invalid_NotBlank):TYPE(STRING10):0,0\n'
    + 'FIELD:middle_initial:LIKE(Invalid_Alpha):TYPE(STRING1):0,0\n'
    + 'FIELD:company_name:TYPE(STRING50):0,0\n'
    + 'FIELD:title:TYPE(STRING30):0,0\n'
    + 'FIELD:address1:TYPE(STRING):0,0\n'
    + 'FIELD:address2:TYPE(STRING):0,0\n'
    + 'FIELD:floor:TYPE(STRING10):0,0\n'
    + 'FIELD:room:TYPE(STRING20):0,0\n'
    + 'FIELD:city:LIKE(Invalid_Char):TYPE(STRING20):0,0\n'
    + 'FIELD:state:LIKE(Invalid_Alpha):TYPE(STRING2):0,0\n'
    + 'FIELD:postal_code:LIKE(Invalid_AlphaNum):TYPE(STRING9):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Phone):TYPE(STRING12):0,0\n'
    + 'FIELD:target_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0\n'
    + 'FIELD:overall_target_ocn:LIKE(Invalid_AlphaNum):TYPE(STRING4):0,0\n'
    + 'FIELD:rural_lec_indicator:LIKE(Invalid_Indicator):TYPE(STRING1):0,0\n'
    + 'FIELD:small_ilec_indicator:TYPE(STRING1):0,0\n'
    + 'FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

