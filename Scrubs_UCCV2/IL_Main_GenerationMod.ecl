// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT IL_Main_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_UCCV2';
  EXPORT spc_NAMESCOPE := 'IL_Main';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'UCCV2';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,tmsid,rmsid,process_date,static_value,date_vendor_removed,date_vendor_changed,filing_jurisdiction,orig_filing_number,orig_filing_type,orig_filing_date,orig_filing_time,filing_number,filing_number_indc,filing_type,filing_date,filing_time,filing_status,status_type,page,expiration_date,contract_type,vendor_entry_date,vendor_upd_date,statements_filed,continuious_expiration,microfilm_number,amount,irs_serial_number,effective_date,signer_name,title,filing_agency,address,city,state,county,zip,duns_number,cmnt_effective_date,description,collateral_desc,prim_machine,sec_machine,manufacturer_code,manufacturer_name,model,model_year,model_desc,collateral_count,manufactured_year,new_used,serial_number,property_desc,borough,block,lot,collateral_address,air_rights_indc,subterranean_rights_indc,easment_indc,volume,persistent_record_id';
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
    + 'MODULE:Scrubs_UCCV2\n'
    + 'FILENAME:UCCV2\n'
    + 'NAMESCOPE:IL_Main\n'
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
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_numeric_blank:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:invalid_boolean_yn_blank:ENUM(N|Y|)\n'
    + 'FIELDTYPE:invalid_empty:LENGTHS(0)\n'
    + 'FIELDTYPE:invalid_8pastdate:LENGTHS(0,8):CUSTOM(Scrubs.fn_valid_pastDate>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_tmsid:CUSTOM(Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid>0,\'IL\')\n'
    + 'FIELDTYPE:invalid_rmsid:CUSTOM(Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid>0,\'IL\')\n'
    + '//ENUM requires 2 values, otherwise assumes the single value is an attribute\n'
    + 'FIELDTYPE:invalid_filing_jurisdiction:ENUM(IL|IL)\n'
    + 'FIELDTYPE:invalid_orig_filing_number:CUSTOM(Scrubs_UCCV2.Functions.fn_non_empty_numeric>0)\n'
    + 'FIELDTYPE:invalid_orig_filing_type:CUSTOM(Scrubs_UCCV2.Functions.fn_il_orig_filing_type>0)\n'
    + 'FIELDTYPE:invalid_orig_filing_date:CUSTOM(Scrubs_UCCV2.Functions.fn_orig_filing_date>0)\n'
    + 'FIELDTYPE:invalid_orig_filing_time:CUSTOM(Scrubs_UCCV2.Functions.fn_check_time>0)\n'
    + 'FIELDTYPE:invalid_filing_number:CUSTOM(Scrubs_UCCV2.Functions.fn_numeric_or_blank>0)\n'
    + 'FIELDTYPE:invalid_filing_type:CUSTOM(Scrubs_UCCV2.Functions.fn_il_filing_type>0)\n'
    + 'FIELDTYPE:invalid_filing_date:CUSTOM(Scrubs_UCCV2.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_filing_time:CUSTOM(Scrubs_UCCV2.Functions.fn_check_time>0)\n'
    + 'FIELDTYPE:invalid_expiration_date:CUSTOM(Scrubs_UCCV2.Functions.fn_expiration_date>0)\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:tmsid:TYPE(STRING31):LIKE(invalid_tmsid):0,0\n'
    + 'FIELD:rmsid:TYPE(STRING23):LIKE(invalid_rmsid):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_8pastdate):0,0\n'
    + 'FIELD:static_value:TYPE(STRING12):0,0\n'
    + 'FIELD:date_vendor_removed:TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_changed:TYPE(STRING8):0,0\n'
    + 'FIELD:filing_jurisdiction:TYPE(STRING3):LIKE(invalid_filing_jurisdiction):0,0\n'
    + 'FIELD:orig_filing_number:TYPE(STRING25):LIKE(invalid_orig_filing_number):0,0\n'
    + 'FIELD:orig_filing_type:TYPE(STRING40):LIKE(invalid_orig_filing_type):0,0\n'
    + 'FIELD:orig_filing_date:TYPE(STRING8):LIKE(invalid_orig_filing_date):0,0\n'
    + 'FIELD:orig_filing_time:TYPE(STRING4):LIKE(invalid_orig_filing_time):0,0\n'
    + 'FIELD:filing_number:TYPE(STRING25):LIKE(invalid_filing_number):0,0\n'
    + 'FIELD:filing_number_indc:TYPE(STRING1):0,0\n'
    + 'FIELD:filing_type:TYPE(STRING40):LIKE(invalid_filing_type):0,0\n'
    + 'FIELD:filing_date:TYPE(STRING8):LIKE(invalid_filing_date):0,0\n'
    + 'FIELD:filing_time:TYPE(STRING4):LIKE(invalid_filing_time):0,0\n'
    + 'FIELD:filing_status:TYPE(STRING8):LIKE(invalid_empty):0,0\n'
    + 'FIELD:status_type:TYPE(STRING30):LIKE(invalid_empty):0,0\n'
    + 'FIELD:page:TYPE(STRING3):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:expiration_date:TYPE(STRING8):LIKE(invalid_expiration_date):0,0\n'
    + 'FIELD:contract_type:TYPE(STRING9):LIKE(invalid_empty):0,0\n'
    + 'FIELD:vendor_entry_date:TYPE(STRING8):LIKE(invalid_empty):0,0\n'
    + 'FIELD:vendor_upd_date:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:statements_filed:TYPE(STRING3):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:continuious_expiration:TYPE(STRING8):LIKE(invalid_boolean_yn_blank):0,0\n'
    + 'FIELD:microfilm_number:TYPE(STRING17):LIKE(invalid_empty):0,0\n'
    + 'FIELD:amount:TYPE(STRING17):LIKE(invalid_empty):0,0\n'
    + 'FIELD:irs_serial_number:TYPE(STRING17):LIKE(invalid_empty):0,0\n'
    + 'FIELD:effective_date:TYPE(STRING8):LIKE(invalid_empty):0,0\n'
    + 'FIELD:signer_name:TYPE(STRING75):LIKE(invalid_empty):0,0\n'
    + 'FIELD:title:TYPE(STRING60):LIKE(invalid_empty):0,0\n'
    + 'FIELD:filing_agency:TYPE(STRING120):LIKE(invalid_empty):0,0\n'
    + 'FIELD:address:TYPE(STRING64):LIKE(invalid_empty):0,0\n'
    + 'FIELD:city:TYPE(STRING30):LIKE(invalid_empty):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(invalid_empty):0,0\n'
    + 'FIELD:county:TYPE(STRING30):LIKE(invalid_empty):0,0\n'
    + 'FIELD:zip:TYPE(STRING9):LIKE(invalid_empty):0,0\n'
    + 'FIELD:duns_number:TYPE(STRING9):LIKE(invalid_empty):0,0\n'
    + 'FIELD:cmnt_effective_date:TYPE(STRING8):LIKE(invalid_empty):0,0\n'
    + 'FIELD:description:TYPE(STRING500):LIKE(invalid_empty):0,0\n'
    + 'FIELD:collateral_desc:TYPE(STRING512):0,0\n'
    + 'FIELD:prim_machine:TYPE(STRING145):LIKE(invalid_empty):0,0\n'
    + 'FIELD:sec_machine:TYPE(STRING145):LIKE(invalid_empty):0,0\n'
    + 'FIELD:manufacturer_code:TYPE(STRING5):LIKE(invalid_empty):0,0\n'
    + 'FIELD:manufacturer_name:TYPE(STRING120):LIKE(invalid_empty):0,0\n'
    + 'FIELD:model:TYPE(STRING15):LIKE(invalid_empty):0,0\n'
    + 'FIELD:model_year:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:model_desc:TYPE(STRING50):LIKE(invalid_empty):0,0\n'
    + 'FIELD:collateral_count:TYPE(STRING5):LIKE(invalid_empty):0,0\n'
    + 'FIELD:manufactured_year:TYPE(STRING4):LIKE(invalid_empty):0,0\n'
    + 'FIELD:new_used:TYPE(STRING1):LIKE(invalid_empty):0,0\n'
    + 'FIELD:serial_number:TYPE(STRING30):LIKE(invalid_empty):0,0\n'
    + 'FIELD:property_desc:TYPE(STRING50):LIKE(invalid_empty):0,0\n'
    + 'FIELD:borough:TYPE(STRING9):LIKE(invalid_empty):0,0\n'
    + 'FIELD:block:TYPE(STRING5):LIKE(invalid_empty):0,0\n'
    + 'FIELD:lot:TYPE(STRING4:LIKE(invalid_empty)):0,0\n'
    + 'FIELD:collateral_address:TYPE(STRING60):LIKE(invalid_empty):0,0\n'
    + 'FIELD:air_rights_indc:TYPE(STRING1):LIKE(invalid_empty):0,0\n'
    + 'FIELD:subterranean_rights_indc:TYPE(STRING1):LIKE(invalid_empty):0,0\n'
    + 'FIELD:easment_indc:TYPE(STRING1):LIKE(invalid_empty):0,0\n'
    + 'FIELD:volume:TYPE(STRING3):LIKE(invalid_empty):0,0\n'
    + 'FIELD:persistent_record_id:TYPE(UNSIGNED8):LIKE(invalid_mandatory):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

