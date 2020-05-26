// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FCC';
  EXPORT spc_NAMESCOPE := 'Input';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'FCC';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,license_type,file_number,callsign_of_license,radio_service_code,licensees_name,licensees_attention_line,dba_name,licensees_street,licensees_city,licensees_state,licensees_zip,licensees_phone,date_application_received_at_fcc,date_license_issued,date_license_expires,date_of_last_change,type_of_last_change,latitude,longitude,transmitters_street,transmitters_city,transmitters_county,transmitters_state,transmitters_antenna_height,transmitters_height_above_avg_terra,transmitters_height_above_ground_le,power_of_this_frequency,frequency_mhz,class_of_station,number_of_units_authorized_on_freq,effective_radiated_power,emissions_codes,frequency_coordination_number,paging_license_status,control_point_for_the_system,pending_or_granted,firm_preparing_application,contact_firms_street_address,contact_firms_city,contact_firms_state,contact_firms_zipcode,contact_firms_phone_number,contact_firms_fax_number,unique_key,crlf';
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
    + 'MODULE:Scrubs_FCC\n'
    + 'FILENAME:FCC\n'
    + 'NAMESCOPE:Input\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789 .-/)\n'
    + 'FIELDTYPE:Invalid_Alpha:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'Alpha\')\n'
    + 'FIELDTYPE:Invalid_AlphaChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaChar\')\n'
    + 'FIELDTYPE:Invalid_AlphaNum:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNum\')\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNumChar\')\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9,10)\n'
    + 'FIELDTYPE:Invalid_Phone:LIKE(Invalid_Float):LENGTHS(0,9,10)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_FCC.Functions.fn_valid_Date > 0)\n'
    + 'FIELDTYPE:Invalid_Future:CUSTOM(Scrubs_FCC.Functions.fn_valid_Date > 0, \'Future\')\n'
    + '\n'
    + 'FIELD:license_type:TYPE(STRING3):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:file_number:TYPE(STRING15):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:callsign_of_license:TYPE(STRING10):0,0\n'
    + 'FIELD:radio_service_code:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:licensees_name:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:licensees_attention_line:TYPE(STRING35):0,0\n'
    + 'FIELD:dba_name:TYPE(STRING40):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:licensees_street:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:licensees_city:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:licensees_state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:licensees_zip:TYPE(STRING9):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:licensees_phone:TYPE(STRING10):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:date_application_received_at_fcc:TYPE(STRING10):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:date_license_issued:TYPE(STRING10):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:date_license_expires:TYPE(STRING10):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:date_of_last_change:TYPE(STRING10):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:type_of_last_change:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:latitude:TYPE(STRING6):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:longitude:TYPE(STRING7):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:transmitters_street:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:transmitters_city:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:transmitters_county:TYPE(STRING30):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:transmitters_state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:transmitters_antenna_height:TYPE(STRING8):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:transmitters_height_above_avg_terra:TYPE(STRING8):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:transmitters_height_above_ground_le:TYPE(STRING8):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:power_of_this_frequency:TYPE(STRING9):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:frequency_mhz:TYPE(STRING17):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:class_of_station:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:number_of_units_authorized_on_freq:TYPE(STRING9):LIKE(Invalid_No):0,0\n'
    + 'FIELD:effective_radiated_power:TYPE(STRING9):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:emissions_codes:TYPE(STRING45):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:frequency_coordination_number:TYPE(STRING30):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:paging_license_status:TYPE(STRING2):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:control_point_for_the_system:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:pending_or_granted:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:firm_preparing_application:TYPE(STRING40):0,0\n'
    + 'FIELD:contact_firms_street_address:TYPE(STRING40):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:contact_firms_city:TYPE(STRING40):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:contact_firms_state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:contact_firms_zipcode:TYPE(STRING9):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:contact_firms_phone_number:TYPE(STRING10):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:contact_firms_fax_number:TYPE(STRING10):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:unique_key:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:crlf:TYPE(STRING2):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

