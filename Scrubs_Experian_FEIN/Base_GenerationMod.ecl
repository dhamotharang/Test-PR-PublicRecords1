// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT38;
EXPORT Base_GenerationMod := MODULE(SALT38.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.1';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Experian_FEIN';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Experian_FEIN';
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
    + 'MODULE:Scrubs_Experian_FEIN\n'
    + 'FILENAME:Experian_FEIN\n'
    + 'NAMESCOPE:Base\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + '\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_populated_strings>0)\n'
    + 'FIELDTYPE:invalid_zero_integer:ENUM(0|)\n'
    + 'FIELDTYPE:invalid_boolean_yes_no:ENUM(Y|N)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_percentage:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_range_numeric>0,0,100)\n'
    + 'FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_past_yyyymmdd>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_business_identification_number:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,9)\n'
    + 'FIELDTYPE:invalid_business_state:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_business_zip:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_norm_type:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_range_numeric>0,1,5)\n'
    + 'FIELDTYPE:invalid_norm_tax_id:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,9)\n'
    + 'FIELDTYPE:invalid_norm_confidence_level:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_range_numeric>0,1,3)\n'
    + 'FIELDTYPE:invalid_source:ENUM(E5|E6)\n'
    + 'FIELDTYPE:invalid_direction:ALLOW(ENSW)\n'
    + 'FIELDTYPE:invalid_st:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_zip4:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,4)\n'
    + 'FIELDTYPE:invalid_cart:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_alphanumeric>0,4)\n'
    + 'FIELDTYPE:invalid_cr_sort_sz:ENUM(A|B|C|D)\n'
    + 'FIELDTYPE:invalid_lot:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,4)\n'
    + 'FIELDTYPE:invalid_lot_order:ENUM(A|D)\n'
    + 'FIELDTYPE:invalid_dpbc:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,2)\n'
    + 'FIELDTYPE:invalid_chk_digit:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,1)\n'
    + 'FIELDTYPE:invalid_rec_type:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_addr_rec_type>0)\n'
    + 'FIELDTYPE:invalid_fips_state:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,2)\n'
    + 'FIELDTYPE:invalid_fips_county:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,3)\n'
    + 'FIELDTYPE:invalid_geo:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_geo_coord>0)\n'
    + 'FIELDTYPE:invalid_msa:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,4)\n'
    + 'FIELDTYPE:invalid_geo_blk:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,7)\n'
    + 'FIELDTYPE:invalid_geo_match:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0,1)\n'
    + 'FIELDTYPE:invalid_err_stat:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_alphanumeric>0,4)\n'
    + 'FIELDTYPE:invalid_raw_aid:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_ace_aid:CUSTOM(Scrubs_Experian_FEIN.Functions.fn_numeric>0)\n'
    + '\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:business_identification_number:TYPE(STRING9):LIKE(invalid_business_identification_number):0,0\n'
    + 'FIELD:business_name:TYPE(STRING40):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:business_address:TYPE(STRING30):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:business_city:TYPE(STRING28):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:business_state:TYPE(STRING2):LIKE(invalid_business_state):0,0\n'
    + 'FIELD:business_zip:TYPE(STRING5):LIKE(invalid_business_zip):0,0\n'
    + 'FIELD:norm_type:TYPE(STRING1):LIKE(invalid_norm_type):0,0\n'
    + 'FIELD:norm_tax_id:TYPE(STRING9):LIKE(invalid_norm_tax_id):0,0\n'
    + 'FIELD:norm_confidence_level:TYPE(STRING1):LIKE(invalid_norm_confidence_level):0,0\n'
    + 'FIELD:norm_display_configuration:TYPE(STRING1):LIKE(invalid_boolean_yes_no):0,0\n'
    + 'FIELD:long_name:TYPE(STRING120):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:source:TYPE(STRING2):LIKE(invalid_source):0,0\n'
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:bdid_score:TYPE(UNSIGNED1):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:st:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(invalid_zip4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):LIKE(invalid_cart):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):LIKE(invalid_cr_sort_sz):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):LIKE(invalid_lot):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):LIKE(invalid_lot_order):0,0\n'
    + 'FIELD:dbpc:TYPE(STRING2):LIKE(invalid_dpbc):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):LIKE(invalid_chk_digit):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):LIKE(invalid_rec_type):0,0\n'
    + 'FIELD:fips_state:TYPE(STRING2):LIKE(invalid_fips_state):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):LIKE(invalid_fips_county):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):LIKE(invalid_geo):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):LIKE(invalid_geo):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):LIKE(invalid_msa):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):LIKE(invalid_geo_blk):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):LIKE(invalid_geo_match):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):LIKE(invalid_err_stat):0,0\n'
    + 'FIELD:raw_aid:TYPE(UNSIGNED8):LIKE(invalid_raw_aid):0,0\n'
    + 'FIELD:ace_aid:TYPE(UNSIGNED8):LIKE(invalid_ace_aid):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
