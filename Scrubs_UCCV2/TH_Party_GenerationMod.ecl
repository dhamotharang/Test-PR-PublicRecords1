// Machine-readable versions of the spec file and subsets thereof
EXPORT TH_Party_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_UCCV2';
  EXPORT spc_NAMESCOPE := 'TH_Party';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_UCCV2\n'
    + 'FILENAME:UCCV2\n'
    + 'NAMESCOPE:TH_Party\n'
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
    + 'FIELD:tmsid:TYPE(STRING31):0,0\n'
    + 'FIELD:rmsid:TYPE(STRING23):0,0\n'
    + 'FIELD:orig_name:TYPE(STRING120):0,0\n'
    + 'FIELD:orig_lname:TYPE(STRING25):0,0\n'
    + 'FIELD:orig_fname:TYPE(STRING25):0,0\n'
    + 'FIELD:orig_mname:TYPE(STRING35):0,0\n'
    + 'FIELD:orig_suffix:TYPE(STRING10):0,0\n'
    + 'FIELD:duns_number:TYPE(STRING9):0,0\n'
    + 'FIELD:hq_duns_number:TYPE(STRING9):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:fein:TYPE(STRING10):0,0\n'
    + 'FIELD:incorp_state:TYPE(STRING45):0,0\n'
    + 'FIELD:corp_number:TYPE(STRING30):0,0\n'
    + 'FIELD:corp_type:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_address1:TYPE(STRING60):0,0\n'
    + 'FIELD:orig_address2:TYPE(STRING60):0,0\n'
    + 'FIELD:orig_city:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_zip5:TYPE(STRING5):0,0\n'
    + 'FIELD:orig_zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:orig_country:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_province:TYPE(STRING30):0,0\n'
    + 'FIELD:orig_postal_code:TYPE(STRING9):0,0\n'
    + 'FIELD:foreign_indc:TYPE(STRING1):0,0\n'
    + 'FIELD:party_type:TYPE(STRING1):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:company_name:TYPE(STRING60):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:zip5:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:county:TYPE(STRING3):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:bdid_score:TYPE(UNSIGNED6):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
