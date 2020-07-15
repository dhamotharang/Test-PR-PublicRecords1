IMPORT SALT311;
IMPORT Scrubs,Scrubs_IRS_Nonprofit; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 28;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_emp_id','invalid_primary_name','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_date','invalid_grp_nbr','invalid_subsect_cd','invalid_affilatn_cd','invalid_class_cd','invalid_dedct_cd','invalid_foundatn_cd','invalid_activity_cd','invalid_org_cd','invalid_org_exmp_cd','invalid_asset_cd','invalid_req_p1_cd','invalid_req_p2_cd','invalid_acct_period','invalid_asset_amt','invalid_form990_amt','invalid_natl_tax_cd');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_emp_id' => 1,'invalid_primary_name' => 2,'invalid_address' => 3,'invalid_city' => 4,'invalid_state' => 5,'invalid_zip' => 6,'invalid_date' => 7,'invalid_grp_nbr' => 8,'invalid_subsect_cd' => 9,'invalid_affilatn_cd' => 10,'invalid_class_cd' => 11,'invalid_dedct_cd' => 12,'invalid_foundatn_cd' => 13,'invalid_activity_cd' => 14,'invalid_org_cd' => 15,'invalid_org_exmp_cd' => 16,'invalid_asset_cd' => 17,'invalid_req_p1_cd' => 18,'invalid_req_p2_cd' => 19,'invalid_acct_period' => 20,'invalid_asset_amt' => 21,'invalid_form990_amt' => 22,'invalid_natl_tax_cd' => 23,0);
 
EXPORT MakeFT_invalid_emp_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_emp_id(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_emp_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_primary_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_primary_name(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_ASCII_printable(s)>0,~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_primary_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_ASCII_printable'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_invalid_addr(s)>0);
EXPORT InValidMessageFT_invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_invalid_addr'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_Valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_full_zip(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_full_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_invalid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_invalid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_grp_nbr(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_grp_nbr(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_grp_exempt_num(s)>0);
EXPORT InValidMessageFT_invalid_grp_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_grp_exempt_num'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_subsect_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_subsect_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_subsctn_code(s)>0);
EXPORT InValidMessageFT_invalid_subsect_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_subsctn_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_affilatn_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_affilatn_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_affiliation_code(s)>0);
EXPORT InValidMessageFT_invalid_affilatn_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_affiliation_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_class_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_class_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_affiliation_code(s)>0);
EXPORT InValidMessageFT_invalid_class_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_affiliation_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dedct_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dedct_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_deductibility_code(s)>0);
EXPORT InValidMessageFT_invalid_dedct_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_deductibility_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_foundatn_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_foundatn_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_foundation_code(s)>0);
EXPORT InValidMessageFT_invalid_foundatn_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_foundation_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_activity_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_activity_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_activity_code(s)>0);
EXPORT InValidMessageFT_invalid_activity_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_activity_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_org_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_org_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_org_code(s)>0);
EXPORT InValidMessageFT_invalid_org_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_org_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_org_exmp_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_org_exmp_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_org_exempt_code(s)>0);
EXPORT InValidMessageFT_invalid_org_exmp_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_org_exempt_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_asset_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_asset_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_verify_asset_inc_code(s)>0);
EXPORT InValidMessageFT_invalid_asset_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_verify_asset_inc_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_req_p1_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_req_p1_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_fil_req_pt1_code(s)>0);
EXPORT InValidMessageFT_invalid_req_p1_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_fil_req_pt1_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_req_p2_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_req_p2_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_fil_req_pt2_code(s)>0);
EXPORT InValidMessageFT_invalid_req_p2_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_fil_req_pt2_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_acct_period(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_acct_period(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_acct_period_code(s)>0);
EXPORT InValidMessageFT_invalid_acct_period(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_acct_period_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_asset_amt(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_asset_amt(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s)>0);
EXPORT InValidMessageFT_invalid_asset_amt(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_form990_amt(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_form990_amt(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_valid_form990_amt(s)>0);
EXPORT InValidMessageFT_invalid_form990_amt(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_valid_form990_amt'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_natl_tax_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_natl_tax_cd(SALT311.StrType s) := WHICH(~Scrubs_IRS_Nonprofit.Functions.fn_valid_natl_tax_exempt_code(s)>0);
EXPORT InValidMessageFT_invalid_natl_tax_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_IRS_Nonprofit.Functions.fn_valid_natl_tax_exempt_code'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'employer_id_number','primary_name_of_organization','in_care_of_name','street_address','city','state','zip_code','group_exemption_number','subsection_code','affiliation_code','classification_code','ruling_date','deductibility_code','foundation_code','activity_codes','organization_code','exempt_org_status_code','tax_period','asset_code','income_code','filing_requirement_code_part1','filing_requirement_code_part2','accounting_period','asset_amount','income_amount','form_990_revenue_amount','national_taxonomy_exempt','sort_name');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'employer_id_number','primary_name_of_organization','in_care_of_name','street_address','city','state','zip_code','group_exemption_number','subsection_code','affiliation_code','classification_code','ruling_date','deductibility_code','foundation_code','activity_codes','organization_code','exempt_org_status_code','tax_period','asset_code','income_code','filing_requirement_code_part1','filing_requirement_code_part2','accounting_period','asset_amount','income_amount','form_990_revenue_amount','national_taxonomy_exempt','sort_name');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'employer_id_number' => 0,'primary_name_of_organization' => 1,'in_care_of_name' => 2,'street_address' => 3,'city' => 4,'state' => 5,'zip_code' => 6,'group_exemption_number' => 7,'subsection_code' => 8,'affiliation_code' => 9,'classification_code' => 10,'ruling_date' => 11,'deductibility_code' => 12,'foundation_code' => 13,'activity_codes' => 14,'organization_code' => 15,'exempt_org_status_code' => 16,'tax_period' => 17,'asset_code' => 18,'income_code' => 19,'filing_requirement_code_part1' => 20,'filing_requirement_code_part2' => 21,'accounting_period' => 22,'asset_amount' => 23,'income_amount' => 24,'form_990_revenue_amount' => 25,'national_taxonomy_exempt' => 26,'sort_name' => 27,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM','LENGTHS'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_employer_id_number(SALT311.StrType s0) := MakeFT_invalid_emp_id(s0);
EXPORT InValid_employer_id_number(SALT311.StrType s) := InValidFT_invalid_emp_id(s);
EXPORT InValidMessage_employer_id_number(UNSIGNED1 wh) := InValidMessageFT_invalid_emp_id(wh);
 
EXPORT Make_primary_name_of_organization(SALT311.StrType s0) := MakeFT_invalid_primary_name(s0);
EXPORT InValid_primary_name_of_organization(SALT311.StrType s) := InValidFT_invalid_primary_name(s);
EXPORT InValidMessage_primary_name_of_organization(UNSIGNED1 wh) := InValidMessageFT_invalid_primary_name(wh);
 
EXPORT Make_in_care_of_name(SALT311.StrType s0) := s0;
EXPORT InValid_in_care_of_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_in_care_of_name(UNSIGNED1 wh) := '';
 
EXPORT Make_street_address(SALT311.StrType s0) := MakeFT_invalid_address(s0);
EXPORT InValid_street_address(SALT311.StrType s) := InValidFT_invalid_address(s);
EXPORT InValidMessage_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_address(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip_code(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip_code(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_group_exemption_number(SALT311.StrType s0) := MakeFT_invalid_grp_nbr(s0);
EXPORT InValid_group_exemption_number(SALT311.StrType s) := InValidFT_invalid_grp_nbr(s);
EXPORT InValidMessage_group_exemption_number(UNSIGNED1 wh) := InValidMessageFT_invalid_grp_nbr(wh);
 
EXPORT Make_subsection_code(SALT311.StrType s0) := MakeFT_invalid_subsect_cd(s0);
EXPORT InValid_subsection_code(SALT311.StrType s) := InValidFT_invalid_subsect_cd(s);
EXPORT InValidMessage_subsection_code(UNSIGNED1 wh) := InValidMessageFT_invalid_subsect_cd(wh);
 
EXPORT Make_affiliation_code(SALT311.StrType s0) := MakeFT_invalid_affilatn_cd(s0);
EXPORT InValid_affiliation_code(SALT311.StrType s) := InValidFT_invalid_affilatn_cd(s);
EXPORT InValidMessage_affiliation_code(UNSIGNED1 wh) := InValidMessageFT_invalid_affilatn_cd(wh);
 
EXPORT Make_classification_code(SALT311.StrType s0) := MakeFT_invalid_class_cd(s0);
EXPORT InValid_classification_code(SALT311.StrType s) := InValidFT_invalid_class_cd(s);
EXPORT InValidMessage_classification_code(UNSIGNED1 wh) := InValidMessageFT_invalid_class_cd(wh);
 
EXPORT Make_ruling_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ruling_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ruling_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_deductibility_code(SALT311.StrType s0) := MakeFT_invalid_dedct_cd(s0);
EXPORT InValid_deductibility_code(SALT311.StrType s) := InValidFT_invalid_dedct_cd(s);
EXPORT InValidMessage_deductibility_code(UNSIGNED1 wh) := InValidMessageFT_invalid_dedct_cd(wh);
 
EXPORT Make_foundation_code(SALT311.StrType s0) := MakeFT_invalid_foundatn_cd(s0);
EXPORT InValid_foundation_code(SALT311.StrType s) := InValidFT_invalid_foundatn_cd(s);
EXPORT InValidMessage_foundation_code(UNSIGNED1 wh) := InValidMessageFT_invalid_foundatn_cd(wh);
 
EXPORT Make_activity_codes(SALT311.StrType s0) := MakeFT_invalid_activity_cd(s0);
EXPORT InValid_activity_codes(SALT311.StrType s) := InValidFT_invalid_activity_cd(s);
EXPORT InValidMessage_activity_codes(UNSIGNED1 wh) := InValidMessageFT_invalid_activity_cd(wh);
 
EXPORT Make_organization_code(SALT311.StrType s0) := MakeFT_invalid_org_cd(s0);
EXPORT InValid_organization_code(SALT311.StrType s) := InValidFT_invalid_org_cd(s);
EXPORT InValidMessage_organization_code(UNSIGNED1 wh) := InValidMessageFT_invalid_org_cd(wh);
 
EXPORT Make_exempt_org_status_code(SALT311.StrType s0) := MakeFT_invalid_org_exmp_cd(s0);
EXPORT InValid_exempt_org_status_code(SALT311.StrType s) := InValidFT_invalid_org_exmp_cd(s);
EXPORT InValidMessage_exempt_org_status_code(UNSIGNED1 wh) := InValidMessageFT_invalid_org_exmp_cd(wh);
 
EXPORT Make_tax_period(SALT311.StrType s0) := s0;
EXPORT InValid_tax_period(SALT311.StrType s) := 0;
EXPORT InValidMessage_tax_period(UNSIGNED1 wh) := '';
 
EXPORT Make_asset_code(SALT311.StrType s0) := MakeFT_invalid_asset_cd(s0);
EXPORT InValid_asset_code(SALT311.StrType s) := InValidFT_invalid_asset_cd(s);
EXPORT InValidMessage_asset_code(UNSIGNED1 wh) := InValidMessageFT_invalid_asset_cd(wh);
 
EXPORT Make_income_code(SALT311.StrType s0) := s0;
EXPORT InValid_income_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_income_code(UNSIGNED1 wh) := '';
 
EXPORT Make_filing_requirement_code_part1(SALT311.StrType s0) := MakeFT_invalid_req_p1_cd(s0);
EXPORT InValid_filing_requirement_code_part1(SALT311.StrType s) := InValidFT_invalid_req_p1_cd(s);
EXPORT InValidMessage_filing_requirement_code_part1(UNSIGNED1 wh) := InValidMessageFT_invalid_req_p1_cd(wh);
 
EXPORT Make_filing_requirement_code_part2(SALT311.StrType s0) := MakeFT_invalid_req_p2_cd(s0);
EXPORT InValid_filing_requirement_code_part2(SALT311.StrType s) := InValidFT_invalid_req_p2_cd(s);
EXPORT InValidMessage_filing_requirement_code_part2(UNSIGNED1 wh) := InValidMessageFT_invalid_req_p2_cd(wh);
 
EXPORT Make_accounting_period(SALT311.StrType s0) := MakeFT_invalid_acct_period(s0);
EXPORT InValid_accounting_period(SALT311.StrType s) := InValidFT_invalid_acct_period(s);
EXPORT InValidMessage_accounting_period(UNSIGNED1 wh) := InValidMessageFT_invalid_acct_period(wh);
 
EXPORT Make_asset_amount(SALT311.StrType s0) := MakeFT_invalid_asset_amt(s0);
EXPORT InValid_asset_amount(SALT311.StrType s) := InValidFT_invalid_asset_amt(s);
EXPORT InValidMessage_asset_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_asset_amt(wh);
 
EXPORT Make_income_amount(SALT311.StrType s0) := s0;
EXPORT InValid_income_amount(SALT311.StrType s) := 0;
EXPORT InValidMessage_income_amount(UNSIGNED1 wh) := '';
 
EXPORT Make_form_990_revenue_amount(SALT311.StrType s0) := MakeFT_invalid_form990_amt(s0);
EXPORT InValid_form_990_revenue_amount(SALT311.StrType s) := InValidFT_invalid_form990_amt(s);
EXPORT InValidMessage_form_990_revenue_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_form990_amt(wh);
 
EXPORT Make_national_taxonomy_exempt(SALT311.StrType s0) := MakeFT_invalid_natl_tax_cd(s0);
EXPORT InValid_national_taxonomy_exempt(SALT311.StrType s) := InValidFT_invalid_natl_tax_cd(s);
EXPORT InValidMessage_national_taxonomy_exempt(UNSIGNED1 wh) := InValidMessageFT_invalid_natl_tax_cd(wh);
 
EXPORT Make_sort_name(SALT311.StrType s0) := s0;
EXPORT InValid_sort_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_sort_name(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_IRS_Nonprofit;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_employer_id_number;
    BOOLEAN Diff_primary_name_of_organization;
    BOOLEAN Diff_in_care_of_name;
    BOOLEAN Diff_street_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_group_exemption_number;
    BOOLEAN Diff_subsection_code;
    BOOLEAN Diff_affiliation_code;
    BOOLEAN Diff_classification_code;
    BOOLEAN Diff_ruling_date;
    BOOLEAN Diff_deductibility_code;
    BOOLEAN Diff_foundation_code;
    BOOLEAN Diff_activity_codes;
    BOOLEAN Diff_organization_code;
    BOOLEAN Diff_exempt_org_status_code;
    BOOLEAN Diff_tax_period;
    BOOLEAN Diff_asset_code;
    BOOLEAN Diff_income_code;
    BOOLEAN Diff_filing_requirement_code_part1;
    BOOLEAN Diff_filing_requirement_code_part2;
    BOOLEAN Diff_accounting_period;
    BOOLEAN Diff_asset_amount;
    BOOLEAN Diff_income_amount;
    BOOLEAN Diff_form_990_revenue_amount;
    BOOLEAN Diff_national_taxonomy_exempt;
    BOOLEAN Diff_sort_name;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_employer_id_number := le.employer_id_number <> ri.employer_id_number;
    SELF.Diff_primary_name_of_organization := le.primary_name_of_organization <> ri.primary_name_of_organization;
    SELF.Diff_in_care_of_name := le.in_care_of_name <> ri.in_care_of_name;
    SELF.Diff_street_address := le.street_address <> ri.street_address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_group_exemption_number := le.group_exemption_number <> ri.group_exemption_number;
    SELF.Diff_subsection_code := le.subsection_code <> ri.subsection_code;
    SELF.Diff_affiliation_code := le.affiliation_code <> ri.affiliation_code;
    SELF.Diff_classification_code := le.classification_code <> ri.classification_code;
    SELF.Diff_ruling_date := le.ruling_date <> ri.ruling_date;
    SELF.Diff_deductibility_code := le.deductibility_code <> ri.deductibility_code;
    SELF.Diff_foundation_code := le.foundation_code <> ri.foundation_code;
    SELF.Diff_activity_codes := le.activity_codes <> ri.activity_codes;
    SELF.Diff_organization_code := le.organization_code <> ri.organization_code;
    SELF.Diff_exempt_org_status_code := le.exempt_org_status_code <> ri.exempt_org_status_code;
    SELF.Diff_tax_period := le.tax_period <> ri.tax_period;
    SELF.Diff_asset_code := le.asset_code <> ri.asset_code;
    SELF.Diff_income_code := le.income_code <> ri.income_code;
    SELF.Diff_filing_requirement_code_part1 := le.filing_requirement_code_part1 <> ri.filing_requirement_code_part1;
    SELF.Diff_filing_requirement_code_part2 := le.filing_requirement_code_part2 <> ri.filing_requirement_code_part2;
    SELF.Diff_accounting_period := le.accounting_period <> ri.accounting_period;
    SELF.Diff_asset_amount := le.asset_amount <> ri.asset_amount;
    SELF.Diff_income_amount := le.income_amount <> ri.income_amount;
    SELF.Diff_form_990_revenue_amount := le.form_990_revenue_amount <> ri.form_990_revenue_amount;
    SELF.Diff_national_taxonomy_exempt := le.national_taxonomy_exempt <> ri.national_taxonomy_exempt;
    SELF.Diff_sort_name := le.sort_name <> ri.sort_name;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_employer_id_number,1,0)+ IF( SELF.Diff_primary_name_of_organization,1,0)+ IF( SELF.Diff_in_care_of_name,1,0)+ IF( SELF.Diff_street_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_group_exemption_number,1,0)+ IF( SELF.Diff_subsection_code,1,0)+ IF( SELF.Diff_affiliation_code,1,0)+ IF( SELF.Diff_classification_code,1,0)+ IF( SELF.Diff_ruling_date,1,0)+ IF( SELF.Diff_deductibility_code,1,0)+ IF( SELF.Diff_foundation_code,1,0)+ IF( SELF.Diff_activity_codes,1,0)+ IF( SELF.Diff_organization_code,1,0)+ IF( SELF.Diff_exempt_org_status_code,1,0)+ IF( SELF.Diff_tax_period,1,0)+ IF( SELF.Diff_asset_code,1,0)+ IF( SELF.Diff_income_code,1,0)+ IF( SELF.Diff_filing_requirement_code_part1,1,0)+ IF( SELF.Diff_filing_requirement_code_part2,1,0)+ IF( SELF.Diff_accounting_period,1,0)+ IF( SELF.Diff_asset_amount,1,0)+ IF( SELF.Diff_income_amount,1,0)+ IF( SELF.Diff_form_990_revenue_amount,1,0)+ IF( SELF.Diff_national_taxonomy_exempt,1,0)+ IF( SELF.Diff_sort_name,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_employer_id_number := COUNT(GROUP,%Closest%.Diff_employer_id_number);
    Count_Diff_primary_name_of_organization := COUNT(GROUP,%Closest%.Diff_primary_name_of_organization);
    Count_Diff_in_care_of_name := COUNT(GROUP,%Closest%.Diff_in_care_of_name);
    Count_Diff_street_address := COUNT(GROUP,%Closest%.Diff_street_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_group_exemption_number := COUNT(GROUP,%Closest%.Diff_group_exemption_number);
    Count_Diff_subsection_code := COUNT(GROUP,%Closest%.Diff_subsection_code);
    Count_Diff_affiliation_code := COUNT(GROUP,%Closest%.Diff_affiliation_code);
    Count_Diff_classification_code := COUNT(GROUP,%Closest%.Diff_classification_code);
    Count_Diff_ruling_date := COUNT(GROUP,%Closest%.Diff_ruling_date);
    Count_Diff_deductibility_code := COUNT(GROUP,%Closest%.Diff_deductibility_code);
    Count_Diff_foundation_code := COUNT(GROUP,%Closest%.Diff_foundation_code);
    Count_Diff_activity_codes := COUNT(GROUP,%Closest%.Diff_activity_codes);
    Count_Diff_organization_code := COUNT(GROUP,%Closest%.Diff_organization_code);
    Count_Diff_exempt_org_status_code := COUNT(GROUP,%Closest%.Diff_exempt_org_status_code);
    Count_Diff_tax_period := COUNT(GROUP,%Closest%.Diff_tax_period);
    Count_Diff_asset_code := COUNT(GROUP,%Closest%.Diff_asset_code);
    Count_Diff_income_code := COUNT(GROUP,%Closest%.Diff_income_code);
    Count_Diff_filing_requirement_code_part1 := COUNT(GROUP,%Closest%.Diff_filing_requirement_code_part1);
    Count_Diff_filing_requirement_code_part2 := COUNT(GROUP,%Closest%.Diff_filing_requirement_code_part2);
    Count_Diff_accounting_period := COUNT(GROUP,%Closest%.Diff_accounting_period);
    Count_Diff_asset_amount := COUNT(GROUP,%Closest%.Diff_asset_amount);
    Count_Diff_income_amount := COUNT(GROUP,%Closest%.Diff_income_amount);
    Count_Diff_form_990_revenue_amount := COUNT(GROUP,%Closest%.Diff_form_990_revenue_amount);
    Count_Diff_national_taxonomy_exempt := COUNT(GROUP,%Closest%.Diff_national_taxonomy_exempt);
    Count_Diff_sort_name := COUNT(GROUP,%Closest%.Diff_sort_name);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
