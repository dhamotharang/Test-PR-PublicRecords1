// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_IRS_Nonprofit';
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
  EXPORT spc_FILENAME := 'IRS_Nonprofit';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,employer_id_number,primary_name_of_organization,in_care_of_name,street_address,city,state,zip_code,group_exemption_number,subsection_code,affiliation_code,classification_code,ruling_date,deductibility_code,foundation_code,activity_codes,organization_code,exempt_org_status_code,tax_period,asset_code,income_code,filing_requirement_code_part1,filing_requirement_code_part2,accounting_period,asset_amount,income_amount,form_990_revenue_amount,national_taxonomy_exempt,sort_name';
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
    + 'MODULE:Scrubs_IRS_Nonprofit\n'
    + 'FILENAME:IRS_Nonprofit\n'
    + 'NAMESCOPE:Input\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_emp_id:CUSTOM(Scrubs.Functions.fn_numeric >0)\n'
    + 'FIELDTYPE:invalid_primary_name:LENGTHS(1..):CUSTOM(Scrubs.Functions.fn_ASCII_printable >0)\n'
    + 'FIELDTYPE:invalid_address:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_invalid_addr >0)\n'
    + 'FIELDTYPE:invalid_city:CUSTOM(Scrubs.Functions.fn_ASCII_printable >0)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs.Functions.fn_Valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:invalid_zip:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_full_zip >0)\n'
    + 'FIELDTYPE:invalid_date:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_invalid_date>0)\n'
    + 'FIELDTYPE:invalid_grp_nbr:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_grp_exempt_num>0)\n'
    + 'FIELDTYPE:invalid_subsect_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_subsctn_code>0)\n'
    + 'FIELDTYPE:invalid_affilatn_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_affiliation_code>0)\n'
    + 'FIELDTYPE:invalid_class_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_affiliation_code>0)\n'
    + 'FIELDTYPE:invalid_dedct_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_deductibility_code>0)\n'
    + 'FIELDTYPE:invalid_foundatn_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_foundation_code>0)\n'
    + 'FIELDTYPE:invalid_activity_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_activity_code>0)\n'
    + 'FIELDTYPE:invalid_org_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_org_code>0)\n'
    + 'FIELDTYPE:invalid_org_exmp_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_org_exempt_code>0)\n'
    + 'FIELDTYPE:invalid_asset_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_asset_inc_code>0)\n'
    + 'FIELDTYPE:invalid_req_p1_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_fil_req_pt1_code>0)\n'
    + 'FIELDTYPE:invalid_req_p2_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_fil_req_pt2_code>0)\n'
    + 'FIELDTYPE:invalid_acct_period:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_acct_period_code>0)\n'
    + 'FIELDTYPE:invalid_asset_amt:CUSTOM(Scrubs.Functions.fn_numeric_optional>0)\n'
    + 'FIELDTYPE:invalid_form990_amt:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_valid_form990_amt>0)\n'
    + 'FIELDTYPE:invalid_natl_tax_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_valid_natl_tax_exempt_code>0)\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB \n'
    + '//---------------------------------------------------------------\n'
    + 'FIELD:employer_id_number:TYPE(STRING):LIKE(invalid_emp_id):0,0\n'
    + 'FIELD:primary_name_of_organization:TYPE(STRING):LIKE(invalid_primary_name):0,0\n'
    + 'FIELD:in_care_of_name:TYPE(STRING):0,0\n'
    + 'FIELD:street_address:TYPE(STRING):LIKE(invalid_address):0,0\n'
    + 'FIELD:city:TYPE(STRING):LIKE(invalid_city):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(invalid_state):0,0\n'
    + 'FIELD:zip_code:TYPE(STRING):LIKE(invalid_zip):0,0\n'
    + 'FIELD:group_exemption_number:TYPE(STRING):LIKE(invalid_grp_nbr):0,0\n'
    + 'FIELD:subsection_code:TYPE(STRING):LIKE(invalid_subsect_cd):0,0\n'
    + 'FIELD:affiliation_code:TYPE(STRING):LIKE(invalid_affilatn_cd):0,0\n'
    + 'FIELD:classification_code:TYPE(STRING):LIKE(invalid_class_cd):0,0\n'
    + 'FIELD:ruling_date:TYPE(STRING):LIKE(invalid_date):0,0\n'
    + 'FIELD:deductibility_code:TYPE(STRING):LIKE(invalid_dedct_cd):0,0\n'
    + 'FIELD:foundation_code:TYPE(STRING):LIKE(invalid_foundatn_cd):0,0\n'
    + 'FIELD:activity_codes:TYPE(STRING):LIKE(invalid_activity_cd):0,0\n'
    + 'FIELD:organization_code:TYPE(STRING):LIKE(invalid_org_cd):0,0\n'
    + 'FIELD:exempt_org_status_code:TYPE(STRING):LIKE(invalid_org_exmp_cd):0,0\n'
    + 'FIELD:tax_period:TYPE(STRING):0,0\n'
    + 'FIELD:asset_code:TYPE(STRING):LIKE(invalid_asset_cd):0,0\n'
    + 'FIELD:income_code:TYPE(STRING):0,0\n'
    + 'FIELD:filing_requirement_code_part1:TYPE(STRING):LIKE(invalid_req_p1_cd):0,0\n'
    + 'FIELD:filing_requirement_code_part2:TYPE(STRING):LIKE(invalid_req_p2_cd):0,0\n'
    + 'FIELD:accounting_period:TYPE(STRING):LIKE(invalid_acct_period):0,0\n'
    + 'FIELD:asset_amount:TYPE(STRING):LIKE(invalid_asset_amt):0,0\n'
    + 'FIELD:income_amount:TYPE(STRING):0,0\n'
    + 'FIELD:form_990_revenue_amount:TYPE(STRING):LIKE(invalid_form990_amt):0,0\n'
    + 'FIELD:national_taxonomy_exempt:TYPE(STRING):LIKE(invalid_natl_tax_cd):0,0\n'
    + 'FIELD:sort_name:TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

