// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT InfutorWP_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_CanadianPhones';
  EXPORT spc_NAMESCOPE := 'InfutorWP';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'CanadianPhones';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,can_phone,can_title,can_fname,can_lname,can_suffix,can_address1,can_house,can_predir,can_street,can_strtype,can_postdir,can_apttype,can_aptnbr,can_city,can_province,can_postalcd,can_lang,can_rectype';
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
    + 'MODULE:Scrubs_CanadianPhones\n'
    + 'FILENAME:CanadianPhones\n'
    + 'NAMESCOPE:InfutorWP\n'
    + '\n'
    + 'FIELDTYPE:invalid_phone:ALLOW(0123456789):LENGTHS(10,0)\n'
    + 'FIELDTYPE:invalid_canadian_zip:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ):LENGTHS(0,6)\n'
    + 'FIELDTYPE:invalid_province:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(B|R|):LENGTHS(1,0)\n'
    + 'FIELDTYPE:invalid_address:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\'):SPACES( ()-&/\\#.;,\\:"=*+):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_city:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-\'.,&/):SPACES( ):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'"+=@#$%^&+-_\\:*!?`):SPACES( ,.(){}/\\;):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890+_`):SPACES( -\'/.):LENGTHS(0..)\n'
    + '\n'
    + '\n'
    + 'FIELD:can_phone:LIKE(invalid_phone):TYPE(STRING10):0,0\n'
    + 'FIELD:can_title:LIKE(invalid_alpha):TYPE(STRING15):0,0\n'
    + 'FIELD:can_fname:LIKE(invalid_alpha):TYPE(STRING50):0,0\n'
    + 'FIELD:can_lname:LIKE(invalid_name):TYPE(STRING255):0,0\n'
    + 'FIELD:can_suffix:LIKE(invalid_alpha):TYPE(STRING10):0,0\n'
    + 'FIELD:can_address1:LIKE(invalid_address):TYPE(STRING100):0,0\n'
    + 'FIELD:can_house:LIKE(invalid_address):TYPE(STRING10):0,0\n'
    + 'FIELD:can_predir:LIKE(invalid_address):TYPE(STRING4):0,0\n'
    + 'FIELD:can_street:LIKE(invalid_address):TYPE(STRING40):0,0\n'
    + 'FIELD:can_strtype:LIKE(invalid_address):TYPE(STRING4):0,0\n'
    + 'FIELD:can_postdir:LIKE(invalid_address):TYPE(STRING2):0,0\n'
    + 'FIELD:can_apttype:LIKE(invalid_address):TYPE(STRING14):0,0\n'
    + 'FIELD:can_aptnbr:LIKE(invalid_address):TYPE(STRING6):0,0\n'
    + 'FIELD:can_city:LIKE(invalid_city):TYPE(STRING40):0,0\n'
    + 'FIELD:can_province:LIKE(invalid_province):TYPE(STRING2):0,0\n'
    + 'FIELD:can_postalcd:LIKE(invalid_canadian_zip):TYPE(STRING6):0,0\n'
    + 'FIELD:can_lang:TYPE(STRING1):0,0\n'
    + 'FIELD:can_rectype:LIKE(invalid_record_type):TYPE(STRING1):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

