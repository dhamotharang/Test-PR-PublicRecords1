// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Govdata';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'SEC_BrokerDealer';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_reported,dt_last_reported,cik_number,company_name,reporting_file_number,address1,address2,city,state_code,zip_code,irs_taxpayer_id,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,record_type,ace_fips_st,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,title,fname,mname,lname,name_suffix,name_score,is_company_flag,cname,lf';
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
    + 'MODULE:Scrubs_Govdata\n'
    + 'FILENAME:SEC_BrokerDealer\n'
    + 'NAMESCOPE:Base \n'
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
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.functions.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_numeric:CUSTOM(Scrubs.functions.fn_numeric>0,10)\n'
    + 'FIELDTYPE:Invalid_mandatory_alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0) \n'
    + 'FIELDTYPE:Invalid_St:CUSTOM(Scrubs.functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:Invalid_zip:CUSTOM(Scrubs_Govdata.Functions.fn_verify_zip59>0)\n'
    + 'FIELDTYPE:Invalid_numeric_optional:CUSTOM(Scrubs.functions.fn_numeric_optional>0,9)\n'
    + 'FIELDTYPE:Invalid_company_flag:ENUM(0|1)\n'
    + '\n'
    + '\n'
    + 'FIELD:dt_first_reported:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_last_reported:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:cik_number:TYPE(STRING10):LIKE(Invalid_numeric):0,0\n'
    + 'FIELD:company_name:TYPE(STRING60):LIKE(Invalid_mandatory_alpha):0,0\n'
    + 'FIELD:reporting_file_number:TYPE(STRING8):0,0\n'
    + 'FIELD:address1:TYPE(STRING40):LIKE(Invalid_mandatory_alpha):0,0\n'
    + 'FIELD:address2:TYPE(STRING40):LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:city:TYPE(STRING30):LIKE(Invalid_alpha):0,0\n'
    + 'FIELD:state_code:TYPE(STRING2):LIKE(Invalid_St):0,0  \n'
    + 'FIELD:zip_code:TYPE(STRING10):LIKE(Invalid_zip):0,0\n'
    + 'FIELD:irs_taxpayer_id:TYPE(STRING9):LIKE(Invalid_numeric_optional):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):0,0\n'
    + 'FIELD:st:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):0,0\n'
    + 'FIELD:dpbc:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):0,0\n'
    + 'FIELD:record_type:TYPE(STRING2):0,0\n'
    + 'FIELD:ace_fips_st:TYPE(STRING2):0,0\n'
    + 'FIELD:county:TYPE(STRING3):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):0,0\n'
    + 'FIELD:title:TYPE(STRING5):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):0,0\n'
    + 'FIELD:mname:TYPE(STRING20):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:name_score:TYPE(STRING3):0,0\n'
    + 'FIELD:is_company_flag:TYPE(DATA2):LIKE(Invalid_company_flag):0,0\n'
    + 'FIELD:cname:TYPE(STRING60):0,0\n'
    + 'FIELD:lf:TYPE(STRING1):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

