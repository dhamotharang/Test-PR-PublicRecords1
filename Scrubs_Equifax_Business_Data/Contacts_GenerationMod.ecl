// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Contacts_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Equifax_Business_Data';
  EXPORT spc_NAMESCOPE := 'Contacts';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Equifax_Business_Data';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,EFX_id,EFX_CONTCT,EFX_TITLECD,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE';
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
    + 'MODULE:Scrubs_Equifax_Business_Data\n'
    + 'FILENAME:Equifax_Business_Data\n'
    + 'NAMESCOPE:Contacts\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + '// FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + '// FIELDTYPE:invalid_title:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_title > 0)\n'
    + '// FIELDTYPE:invalid_title_desc:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_title_desc > 0)\n'
    + 'FIELDTYPE:invalid_last_name:ALLOW( ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz)\n'
    + 'FIELDTYPE:invalid_first_name:ALLOW( ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz)\n'
    + '\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_title:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_title > 0)\n'
    + 'FIELDTYPE:invalid_title_desc:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_title_desc > 0)\n'
    + '// FIELDTYPE:invalid_last_name:ALLOW(0123456789+_`/@:"&[]() ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz)\n'
    + '// FIELDTYPE:invalid_first_name:ALLOW(0123456789+_`/@:"&[]() ,.-\'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz)\n'
    + '\n'
    + 'FIELDTYPE:invalid_efx_id:ALLOW(0123456789):LENGTHS(1..10)\n'
    + 'FIELDTYPE:invalid_efx_titlecd:LENGTHS(0..2)\n'
    + '// FIELDTYPE:invalid_efx_date:ALLOW(-0123456789):LENGTHS(0,10)\n'
    + 'FIELDTYPE:invalid_efx_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_valid_Load_Date > 0)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + '// FIELD:EFX_id:TYPE(STRING198):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:EFX_CONTCT:TYPE(STRING198):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:EFX_TITLECD:TYPE(STRING75):LIKE(invalid_title):0,0\n'
    + '// FIELD:EFX_TITLEDESC:TYPE(STRING75):LIKE(invalid_title_desc):0,0\n'
    + '// FIELD:EFX_TITLECD:TYPE(STRING198):LIKE(invalid_title):0,0\n'
    + '// FIELD:EFX_TITLEDESC:TYPE(STRING198):LIKE(invalid_title_desc):0,0\n'
    + '// FIELD:EFX_LASTNAM:TYPE(STRING198):LIKE(invalid_last_name):0,0\n'
    + '// FIELD:EFX_FSTNAM:TYPE(STRING198):LIKE(invalid_first_name):0,0\n'
    + '// FIELD:EFX_EMAIL:TYPE(STRING198):0,0\n'
    + '// FIELD:EFX_DATE:TYPE(STRING198):0,0\n'
    + '\n'
    + 'FIELD:EFX_id:TYPE(STRING198):LIKE(invalid_efx_id):0,0\n'
    + 'FIELD:EFX_CONTCT:TYPE(STRING198):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:EFX_TITLECD:TYPE(STRING198):LIKE(invalid_title):0,0\n'
    + 'FIELD:EFX_TITLEDESC:TYPE(STRING198):LIKE(invalid_title_desc):0,0\n'
    + 'FIELD:EFX_LASTNAM:TYPE(STRING198):LIKE(invalid_last_name):0,0\n'
    + 'FIELD:EFX_FSTNAM:TYPE(STRING198):LIKE(invalid_first_name):0,0\n'
    + 'FIELD:EFX_EMAIL:TYPE(STRING198):0,0\n'
    + 'FIELD:EFX_DATE:TYPE(STRING198):LIKE(invalid_efx_date):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

