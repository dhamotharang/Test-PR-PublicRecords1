﻿Generated by SALT V3.11.11
Command line options: -MScrubs_IRS_Nonprofit -eC:\Users\mattel01\AppData\Local\Temp\TFRCC3B.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_IRS_Nonprofit
FILENAME:IRS_Nonprofit
NAMESCOPE:Input
//-------------------------
//FIELDTYPE DEFINITIONS
//-------------------------
FIELDTYPE:invalid_emp_id:CUSTOM(Scrubs.Functions.fn_numeric >0)
FIELDTYPE:invalid_primary_name:LENGTHS(1..):CUSTOM(Scrubs.Functions.fn_ASCII_printable >0)
FIELDTYPE:invalid_address:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_invalid_addr >0)
FIELDTYPE:invalid_city:CUSTOM(Scrubs.Functions.fn_ASCII_printable >0)
FIELDTYPE:invalid_state:CUSTOM(Scrubs.Functions.fn_Valid_StateAbbrev>0)
FIELDTYPE:invalid_zip:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_full_zip >0)
FIELDTYPE:invalid_date:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_invalid_date>0)
FIELDTYPE:invalid_grp_nbr:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_grp_exempt_num>0)
FIELDTYPE:invalid_subsect_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_subsctn_code>0)
FIELDTYPE:invalid_affilatn_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_affiliation_code>0)
FIELDTYPE:invalid_class_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_affiliation_code>0)
FIELDTYPE:invalid_dedct_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_deductibility_code>0)
FIELDTYPE:invalid_foundatn_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_foundation_code>0)
FIELDTYPE:invalid_activity_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_activity_code>0)
FIELDTYPE:invalid_org_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_org_code>0)
FIELDTYPE:invalid_org_exmp_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_org_exempt_code>0)
FIELDTYPE:invalid_asset_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_verify_asset_inc_code>0)
FIELDTYPE:invalid_req_p1_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_fil_req_pt1_code>0)
FIELDTYPE:invalid_req_p2_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_fil_req_pt2_code>0)
FIELDTYPE:invalid_acct_period:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_acct_period_code>0)
FIELDTYPE:invalid_asset_amt:CUSTOM(Scrubs.Functions.fn_numeric_optional>0)
FIELDTYPE:invalid_form990_amt:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_valid_form990_amt>0)
FIELDTYPE:invalid_natl_tax_cd:CUSTOM(Scrubs_IRS_Nonprofit.Functions.fn_valid_natl_tax_exempt_code>0)
//--------------------------------------------------------------- 
//FIELDS TO SCRUB 
//---------------------------------------------------------------
FIELD:employer_id_number:TYPE(STRING):LIKE(invalid_emp_id):0,0
FIELD:primary_name_of_organization:TYPE(STRING):LIKE(invalid_primary_name):0,0
FIELD:in_care_of_name:TYPE(STRING):0,0
FIELD:street_address:TYPE(STRING):LIKE(invalid_address):0,0
FIELD:city:TYPE(STRING):LIKE(invalid_city):0,0
FIELD:state:TYPE(STRING):LIKE(invalid_state):0,0
FIELD:zip_code:TYPE(STRING):LIKE(invalid_zip):0,0
FIELD:group_exemption_number:TYPE(STRING):LIKE(invalid_grp_nbr):0,0
FIELD:subsection_code:TYPE(STRING):LIKE(invalid_subsect_cd):0,0
FIELD:affiliation_code:TYPE(STRING):LIKE(invalid_affilatn_cd):0,0
FIELD:classification_code:TYPE(STRING):LIKE(invalid_class_cd):0,0
FIELD:ruling_date:TYPE(STRING):LIKE(invalid_date):0,0
FIELD:deductibility_code:TYPE(STRING):LIKE(invalid_dedct_cd):0,0
FIELD:foundation_code:TYPE(STRING):LIKE(invalid_foundatn_cd):0,0
FIELD:activity_codes:TYPE(STRING):LIKE(invalid_activity_cd):0,0
FIELD:organization_code:TYPE(STRING):LIKE(invalid_org_cd):0,0
FIELD:exempt_org_status_code:TYPE(STRING):LIKE(invalid_org_exmp_cd):0,0
FIELD:tax_period:TYPE(STRING):0,0
FIELD:asset_code:TYPE(STRING):LIKE(invalid_asset_cd):0,0
FIELD:income_code:TYPE(STRING):0,0
FIELD:filing_requirement_code_part1:TYPE(STRING):LIKE(invalid_req_p1_cd):0,0
FIELD:filing_requirement_code_part2:TYPE(STRING):LIKE(invalid_req_p2_cd):0,0
FIELD:accounting_period:TYPE(STRING):LIKE(invalid_acct_period):0,0
FIELD:asset_amount:TYPE(STRING):LIKE(invalid_asset_amt):0,0
FIELD:income_amount:TYPE(STRING):0,0
FIELD:form_990_revenue_amount:TYPE(STRING):LIKE(invalid_form990_amt):0,0
FIELD:national_taxonomy_exempt:TYPE(STRING):LIKE(invalid_natl_tax_cd):0,0
FIELD:sort_name:TYPE(STRING):0,0
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
 
Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3
 
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
 
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
 
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
 
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
 
