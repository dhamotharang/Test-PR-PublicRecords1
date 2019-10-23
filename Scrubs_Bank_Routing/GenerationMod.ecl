// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT38;
EXPORT GenerationMod := MODULE(SALT38.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.1';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'scrubs_bank_routing';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'bank_routing.Files.base';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:scrubs_bank_routing\n'
    + 'FILENAME:bank_routing.Files.base\n'
    + '\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:ALPHA:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):\n'
    + 'FIELDTYPE:WORDBAG:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN):\n'
    + 'FIELDTYPE:CITY:LIKE(WORDBAG):LENGTHS(0,4..):WORDS(0..3):PARSE(CITIES):ONFAIL(CLEAN):\n'
    + 'FIELDTYPE:ST:LIKE(ALPHA):WORDS(1):LENGTHS(0,2..):SPACES(&.,;: -):PARSE(STATES):ONFAIL(CLEAN):\n'
    + 'FIELDTYPE:NAME:LIKE(WORDBAG):PARSE(Name):ONFAIL(CLEAN):\n'
    + 'FIELDTYPE:UPPERNAME:LIKE(WORDBAG):PARSE(*C):ONFAIL(CLEAN):\n'
    + 'FIELDTYPE:STREET_ADDR:LIKE(WORDBAG):PARSE(STREET_ADDR):ONFAIL(CLEAN):\n'
    + 'FIELDTYPE:FULL_ADDRESS:LIKE(WORDBAG):PARSE(FULL_ADDRESS):ONFAIL(CLEAN):\n'
    + 'FIELDTYPE:ZIP5:ALLOW(0123456789):LENGTHS(0,5):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:HASZIP4:ALLOW(0123456789):LENGTHS(0,4):ONFAIL(CLEAN)\n'
    + '\n'
    + '\n'
    + 'FIELD:file_key:LIKE(NUMBER):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_updated:LIKE(NUMBER):0,0\n'
    + 'FIELD:type_instituon_code:LIKE(NUMBER):0,0\n'
    + 'FIELD:head_office_branch_codes:LIKE(NUMBER):0,0\n'
    + 'FIELD:routing_number_micr:LIKE(NUMBER):0,0\n'
    + 'FIELD:routing_number_fractional:LIKE(NUMBER):0,0\n'
    + 'FIELD:institution_name_full:TYPE(QSTRING128):BAGOFWORDS:LIKE(UPPERNAME):0,0\n'
    + 'FIELD:institution_name_abbreviated:TYPE(QSTRING50):BAGOFWORDS:LIKE(UPPERNAME):0,0\n'
    + 'FIELD:street_address:TYPE(QSTRING40):BAGOFWORDS:LIKE(STREET_ADDR):0,0\n'
    + 'FIELD:city_town:TYPE(QSTRING30):BAGOFWORDS:LIKE(CITY):0,0\n'
    + 'FIELD:state:LIKE(ST):0,0\n'
    + 'FIELD:zip_code:LIKE(zip5):0,0\n'
    + 'FIELD:zip_4:LIKE(hasZip4):0,0\n'
    + 'FIELD:mail_address:TYPE(QSTRING40):BAGOFWORDS:LIKE(STREET_ADDR):0,0\n'
    + 'FIELD:mail_city_town:TYPE(QSTRING30):BAGOFWORDS:LIKE(CITY):0,0\n'
    + 'FIELD:mail_state:LIKE(ST):0,0\n'
    + 'FIELD:mail_zip_code:LIKE(zip5):0,0\n'
    + 'FIELD:mail_zip_4:LIKE(hasZip4):0,0\n'
    + 'FIELD:branch_office_name:TYPE(QSTRING30):BAGOFWORDS:LIKE(UPPERNAME):0,0\n'
    + 'FIELD:head_office_routing_number:LIKE(NUMBER):0,0\n'
    + 'FIELD:phone_number_area_code:LIKE(NUMBER):0,0\n'
    + 'FIELD:phone_number:LIKE(NUMBER):0,0\n'
    + 'FIELD:phone_number_extension:LIKE(NUMBER):0,0\n'
    + 'FIELD:fax_area_code:LIKE(NUMBER):0,0\n'
    + 'FIELD:fax_number:LIKE(NUMBER):0,0\n'
    + 'FIELD:fax_extension:LIKE(NUMBER):0,0\n'
    + 'FIELD:head_office_asset_size:LIKE(NUMBER):0,0\n'
    + 'FIELD:federal_reserve_district_code:0,0\n'
    + 'FIELD:year_2000_date_last_updated:LIKE(NUMBER):0,0\n'
    + 'FIELD:head_office_file_key:LIKE(NUMBER):0,0\n'
    + 'FIELD:routing_number_type:BAGOFWORDS:LIKE(UPPERNAME):0,0\n'
    + 'FIELD:routing_number_status:LIKE(ALPHA):0,0\n'
    + 'FIELD:employer_tax_id:LIKE(NUMBER):0,0\n'
    + 'FIELD:institution_identifier:LIKE(NUMBER):0,0\n'
    + '\n'
    + 'INGESTFILE:NEWFILE:NAMED(bank_routing.Files.base)'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
