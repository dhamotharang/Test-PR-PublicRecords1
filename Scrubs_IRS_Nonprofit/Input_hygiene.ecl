IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_IRS_Nonprofit) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_employer_id_number_cnt := COUNT(GROUP,h.employer_id_number <> (TYPEOF(h.employer_id_number))'');
    populated_employer_id_number_pcnt := AVE(GROUP,IF(h.employer_id_number = (TYPEOF(h.employer_id_number))'',0,100));
    maxlength_employer_id_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.employer_id_number)));
    avelength_employer_id_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.employer_id_number)),h.employer_id_number<>(typeof(h.employer_id_number))'');
    populated_primary_name_of_organization_cnt := COUNT(GROUP,h.primary_name_of_organization <> (TYPEOF(h.primary_name_of_organization))'');
    populated_primary_name_of_organization_pcnt := AVE(GROUP,IF(h.primary_name_of_organization = (TYPEOF(h.primary_name_of_organization))'',0,100));
    maxlength_primary_name_of_organization := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_name_of_organization)));
    avelength_primary_name_of_organization := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.primary_name_of_organization)),h.primary_name_of_organization<>(typeof(h.primary_name_of_organization))'');
    populated_in_care_of_name_cnt := COUNT(GROUP,h.in_care_of_name <> (TYPEOF(h.in_care_of_name))'');
    populated_in_care_of_name_pcnt := AVE(GROUP,IF(h.in_care_of_name = (TYPEOF(h.in_care_of_name))'',0,100));
    maxlength_in_care_of_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.in_care_of_name)));
    avelength_in_care_of_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.in_care_of_name)),h.in_care_of_name<>(typeof(h.in_care_of_name))'');
    populated_street_address_cnt := COUNT(GROUP,h.street_address <> (TYPEOF(h.street_address))'');
    populated_street_address_pcnt := AVE(GROUP,IF(h.street_address = (TYPEOF(h.street_address))'',0,100));
    maxlength_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_address)));
    avelength_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street_address)),h.street_address<>(typeof(h.street_address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_group_exemption_number_cnt := COUNT(GROUP,h.group_exemption_number <> (TYPEOF(h.group_exemption_number))'');
    populated_group_exemption_number_pcnt := AVE(GROUP,IF(h.group_exemption_number = (TYPEOF(h.group_exemption_number))'',0,100));
    maxlength_group_exemption_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.group_exemption_number)));
    avelength_group_exemption_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.group_exemption_number)),h.group_exemption_number<>(typeof(h.group_exemption_number))'');
    populated_subsection_code_cnt := COUNT(GROUP,h.subsection_code <> (TYPEOF(h.subsection_code))'');
    populated_subsection_code_pcnt := AVE(GROUP,IF(h.subsection_code = (TYPEOF(h.subsection_code))'',0,100));
    maxlength_subsection_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsection_code)));
    avelength_subsection_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subsection_code)),h.subsection_code<>(typeof(h.subsection_code))'');
    populated_affiliation_code_cnt := COUNT(GROUP,h.affiliation_code <> (TYPEOF(h.affiliation_code))'');
    populated_affiliation_code_pcnt := AVE(GROUP,IF(h.affiliation_code = (TYPEOF(h.affiliation_code))'',0,100));
    maxlength_affiliation_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.affiliation_code)));
    avelength_affiliation_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.affiliation_code)),h.affiliation_code<>(typeof(h.affiliation_code))'');
    populated_classification_code_cnt := COUNT(GROUP,h.classification_code <> (TYPEOF(h.classification_code))'');
    populated_classification_code_pcnt := AVE(GROUP,IF(h.classification_code = (TYPEOF(h.classification_code))'',0,100));
    maxlength_classification_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.classification_code)));
    avelength_classification_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.classification_code)),h.classification_code<>(typeof(h.classification_code))'');
    populated_ruling_date_cnt := COUNT(GROUP,h.ruling_date <> (TYPEOF(h.ruling_date))'');
    populated_ruling_date_pcnt := AVE(GROUP,IF(h.ruling_date = (TYPEOF(h.ruling_date))'',0,100));
    maxlength_ruling_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ruling_date)));
    avelength_ruling_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ruling_date)),h.ruling_date<>(typeof(h.ruling_date))'');
    populated_deductibility_code_cnt := COUNT(GROUP,h.deductibility_code <> (TYPEOF(h.deductibility_code))'');
    populated_deductibility_code_pcnt := AVE(GROUP,IF(h.deductibility_code = (TYPEOF(h.deductibility_code))'',0,100));
    maxlength_deductibility_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deductibility_code)));
    avelength_deductibility_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deductibility_code)),h.deductibility_code<>(typeof(h.deductibility_code))'');
    populated_foundation_code_cnt := COUNT(GROUP,h.foundation_code <> (TYPEOF(h.foundation_code))'');
    populated_foundation_code_pcnt := AVE(GROUP,IF(h.foundation_code = (TYPEOF(h.foundation_code))'',0,100));
    maxlength_foundation_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foundation_code)));
    avelength_foundation_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foundation_code)),h.foundation_code<>(typeof(h.foundation_code))'');
    populated_activity_codes_cnt := COUNT(GROUP,h.activity_codes <> (TYPEOF(h.activity_codes))'');
    populated_activity_codes_pcnt := AVE(GROUP,IF(h.activity_codes = (TYPEOF(h.activity_codes))'',0,100));
    maxlength_activity_codes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_codes)));
    avelength_activity_codes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_codes)),h.activity_codes<>(typeof(h.activity_codes))'');
    populated_organization_code_cnt := COUNT(GROUP,h.organization_code <> (TYPEOF(h.organization_code))'');
    populated_organization_code_pcnt := AVE(GROUP,IF(h.organization_code = (TYPEOF(h.organization_code))'',0,100));
    maxlength_organization_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.organization_code)));
    avelength_organization_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.organization_code)),h.organization_code<>(typeof(h.organization_code))'');
    populated_exempt_org_status_code_cnt := COUNT(GROUP,h.exempt_org_status_code <> (TYPEOF(h.exempt_org_status_code))'');
    populated_exempt_org_status_code_pcnt := AVE(GROUP,IF(h.exempt_org_status_code = (TYPEOF(h.exempt_org_status_code))'',0,100));
    maxlength_exempt_org_status_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exempt_org_status_code)));
    avelength_exempt_org_status_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exempt_org_status_code)),h.exempt_org_status_code<>(typeof(h.exempt_org_status_code))'');
    populated_tax_period_cnt := COUNT(GROUP,h.tax_period <> (TYPEOF(h.tax_period))'');
    populated_tax_period_pcnt := AVE(GROUP,IF(h.tax_period = (TYPEOF(h.tax_period))'',0,100));
    maxlength_tax_period := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_period)));
    avelength_tax_period := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_period)),h.tax_period<>(typeof(h.tax_period))'');
    populated_asset_code_cnt := COUNT(GROUP,h.asset_code <> (TYPEOF(h.asset_code))'');
    populated_asset_code_pcnt := AVE(GROUP,IF(h.asset_code = (TYPEOF(h.asset_code))'',0,100));
    maxlength_asset_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.asset_code)));
    avelength_asset_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.asset_code)),h.asset_code<>(typeof(h.asset_code))'');
    populated_income_code_cnt := COUNT(GROUP,h.income_code <> (TYPEOF(h.income_code))'');
    populated_income_code_pcnt := AVE(GROUP,IF(h.income_code = (TYPEOF(h.income_code))'',0,100));
    maxlength_income_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.income_code)));
    avelength_income_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.income_code)),h.income_code<>(typeof(h.income_code))'');
    populated_filing_requirement_code_part1_cnt := COUNT(GROUP,h.filing_requirement_code_part1 <> (TYPEOF(h.filing_requirement_code_part1))'');
    populated_filing_requirement_code_part1_pcnt := AVE(GROUP,IF(h.filing_requirement_code_part1 = (TYPEOF(h.filing_requirement_code_part1))'',0,100));
    maxlength_filing_requirement_code_part1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_requirement_code_part1)));
    avelength_filing_requirement_code_part1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_requirement_code_part1)),h.filing_requirement_code_part1<>(typeof(h.filing_requirement_code_part1))'');
    populated_filing_requirement_code_part2_cnt := COUNT(GROUP,h.filing_requirement_code_part2 <> (TYPEOF(h.filing_requirement_code_part2))'');
    populated_filing_requirement_code_part2_pcnt := AVE(GROUP,IF(h.filing_requirement_code_part2 = (TYPEOF(h.filing_requirement_code_part2))'',0,100));
    maxlength_filing_requirement_code_part2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_requirement_code_part2)));
    avelength_filing_requirement_code_part2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_requirement_code_part2)),h.filing_requirement_code_part2<>(typeof(h.filing_requirement_code_part2))'');
    populated_accounting_period_cnt := COUNT(GROUP,h.accounting_period <> (TYPEOF(h.accounting_period))'');
    populated_accounting_period_pcnt := AVE(GROUP,IF(h.accounting_period = (TYPEOF(h.accounting_period))'',0,100));
    maxlength_accounting_period := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.accounting_period)));
    avelength_accounting_period := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.accounting_period)),h.accounting_period<>(typeof(h.accounting_period))'');
    populated_asset_amount_cnt := COUNT(GROUP,h.asset_amount <> (TYPEOF(h.asset_amount))'');
    populated_asset_amount_pcnt := AVE(GROUP,IF(h.asset_amount = (TYPEOF(h.asset_amount))'',0,100));
    maxlength_asset_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.asset_amount)));
    avelength_asset_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.asset_amount)),h.asset_amount<>(typeof(h.asset_amount))'');
    populated_income_amount_cnt := COUNT(GROUP,h.income_amount <> (TYPEOF(h.income_amount))'');
    populated_income_amount_pcnt := AVE(GROUP,IF(h.income_amount = (TYPEOF(h.income_amount))'',0,100));
    maxlength_income_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.income_amount)));
    avelength_income_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.income_amount)),h.income_amount<>(typeof(h.income_amount))'');
    populated_form_990_revenue_amount_cnt := COUNT(GROUP,h.form_990_revenue_amount <> (TYPEOF(h.form_990_revenue_amount))'');
    populated_form_990_revenue_amount_pcnt := AVE(GROUP,IF(h.form_990_revenue_amount = (TYPEOF(h.form_990_revenue_amount))'',0,100));
    maxlength_form_990_revenue_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.form_990_revenue_amount)));
    avelength_form_990_revenue_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.form_990_revenue_amount)),h.form_990_revenue_amount<>(typeof(h.form_990_revenue_amount))'');
    populated_national_taxonomy_exempt_cnt := COUNT(GROUP,h.national_taxonomy_exempt <> (TYPEOF(h.national_taxonomy_exempt))'');
    populated_national_taxonomy_exempt_pcnt := AVE(GROUP,IF(h.national_taxonomy_exempt = (TYPEOF(h.national_taxonomy_exempt))'',0,100));
    maxlength_national_taxonomy_exempt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.national_taxonomy_exempt)));
    avelength_national_taxonomy_exempt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.national_taxonomy_exempt)),h.national_taxonomy_exempt<>(typeof(h.national_taxonomy_exempt))'');
    populated_sort_name_cnt := COUNT(GROUP,h.sort_name <> (TYPEOF(h.sort_name))'');
    populated_sort_name_pcnt := AVE(GROUP,IF(h.sort_name = (TYPEOF(h.sort_name))'',0,100));
    maxlength_sort_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sort_name)));
    avelength_sort_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sort_name)),h.sort_name<>(typeof(h.sort_name))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_employer_id_number_pcnt *   0.00 / 100 + T.Populated_primary_name_of_organization_pcnt *   0.00 / 100 + T.Populated_in_care_of_name_pcnt *   0.00 / 100 + T.Populated_street_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_group_exemption_number_pcnt *   0.00 / 100 + T.Populated_subsection_code_pcnt *   0.00 / 100 + T.Populated_affiliation_code_pcnt *   0.00 / 100 + T.Populated_classification_code_pcnt *   0.00 / 100 + T.Populated_ruling_date_pcnt *   0.00 / 100 + T.Populated_deductibility_code_pcnt *   0.00 / 100 + T.Populated_foundation_code_pcnt *   0.00 / 100 + T.Populated_activity_codes_pcnt *   0.00 / 100 + T.Populated_organization_code_pcnt *   0.00 / 100 + T.Populated_exempt_org_status_code_pcnt *   0.00 / 100 + T.Populated_tax_period_pcnt *   0.00 / 100 + T.Populated_asset_code_pcnt *   0.00 / 100 + T.Populated_income_code_pcnt *   0.00 / 100 + T.Populated_filing_requirement_code_part1_pcnt *   0.00 / 100 + T.Populated_filing_requirement_code_part2_pcnt *   0.00 / 100 + T.Populated_accounting_period_pcnt *   0.00 / 100 + T.Populated_asset_amount_pcnt *   0.00 / 100 + T.Populated_income_amount_pcnt *   0.00 / 100 + T.Populated_form_990_revenue_amount_pcnt *   0.00 / 100 + T.Populated_national_taxonomy_exempt_pcnt *   0.00 / 100 + T.Populated_sort_name_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'employer_id_number','primary_name_of_organization','in_care_of_name','street_address','city','state','zip_code','group_exemption_number','subsection_code','affiliation_code','classification_code','ruling_date','deductibility_code','foundation_code','activity_codes','organization_code','exempt_org_status_code','tax_period','asset_code','income_code','filing_requirement_code_part1','filing_requirement_code_part2','accounting_period','asset_amount','income_amount','form_990_revenue_amount','national_taxonomy_exempt','sort_name');
  SELF.populated_pcnt := CHOOSE(C,le.populated_employer_id_number_pcnt,le.populated_primary_name_of_organization_pcnt,le.populated_in_care_of_name_pcnt,le.populated_street_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_group_exemption_number_pcnt,le.populated_subsection_code_pcnt,le.populated_affiliation_code_pcnt,le.populated_classification_code_pcnt,le.populated_ruling_date_pcnt,le.populated_deductibility_code_pcnt,le.populated_foundation_code_pcnt,le.populated_activity_codes_pcnt,le.populated_organization_code_pcnt,le.populated_exempt_org_status_code_pcnt,le.populated_tax_period_pcnt,le.populated_asset_code_pcnt,le.populated_income_code_pcnt,le.populated_filing_requirement_code_part1_pcnt,le.populated_filing_requirement_code_part2_pcnt,le.populated_accounting_period_pcnt,le.populated_asset_amount_pcnt,le.populated_income_amount_pcnt,le.populated_form_990_revenue_amount_pcnt,le.populated_national_taxonomy_exempt_pcnt,le.populated_sort_name_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_employer_id_number,le.maxlength_primary_name_of_organization,le.maxlength_in_care_of_name,le.maxlength_street_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code,le.maxlength_group_exemption_number,le.maxlength_subsection_code,le.maxlength_affiliation_code,le.maxlength_classification_code,le.maxlength_ruling_date,le.maxlength_deductibility_code,le.maxlength_foundation_code,le.maxlength_activity_codes,le.maxlength_organization_code,le.maxlength_exempt_org_status_code,le.maxlength_tax_period,le.maxlength_asset_code,le.maxlength_income_code,le.maxlength_filing_requirement_code_part1,le.maxlength_filing_requirement_code_part2,le.maxlength_accounting_period,le.maxlength_asset_amount,le.maxlength_income_amount,le.maxlength_form_990_revenue_amount,le.maxlength_national_taxonomy_exempt,le.maxlength_sort_name);
  SELF.avelength := CHOOSE(C,le.avelength_employer_id_number,le.avelength_primary_name_of_organization,le.avelength_in_care_of_name,le.avelength_street_address,le.avelength_city,le.avelength_state,le.avelength_zip_code,le.avelength_group_exemption_number,le.avelength_subsection_code,le.avelength_affiliation_code,le.avelength_classification_code,le.avelength_ruling_date,le.avelength_deductibility_code,le.avelength_foundation_code,le.avelength_activity_codes,le.avelength_organization_code,le.avelength_exempt_org_status_code,le.avelength_tax_period,le.avelength_asset_code,le.avelength_income_code,le.avelength_filing_requirement_code_part1,le.avelength_filing_requirement_code_part2,le.avelength_accounting_period,le.avelength_asset_amount,le.avelength_income_amount,le.avelength_form_990_revenue_amount,le.avelength_national_taxonomy_exempt,le.avelength_sort_name);
END;
EXPORT invSummary := NORMALIZE(summary0, 28, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.employer_id_number),TRIM((SALT311.StrType)le.primary_name_of_organization),TRIM((SALT311.StrType)le.in_care_of_name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.group_exemption_number),TRIM((SALT311.StrType)le.subsection_code),TRIM((SALT311.StrType)le.affiliation_code),TRIM((SALT311.StrType)le.classification_code),TRIM((SALT311.StrType)le.ruling_date),TRIM((SALT311.StrType)le.deductibility_code),TRIM((SALT311.StrType)le.foundation_code),TRIM((SALT311.StrType)le.activity_codes),TRIM((SALT311.StrType)le.organization_code),TRIM((SALT311.StrType)le.exempt_org_status_code),TRIM((SALT311.StrType)le.tax_period),TRIM((SALT311.StrType)le.asset_code),TRIM((SALT311.StrType)le.income_code),TRIM((SALT311.StrType)le.filing_requirement_code_part1),TRIM((SALT311.StrType)le.filing_requirement_code_part2),TRIM((SALT311.StrType)le.accounting_period),TRIM((SALT311.StrType)le.asset_amount),TRIM((SALT311.StrType)le.income_amount),TRIM((SALT311.StrType)le.form_990_revenue_amount),TRIM((SALT311.StrType)le.national_taxonomy_exempt),TRIM((SALT311.StrType)le.sort_name)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 28);
  SELF.FldNo2 := 1 + (C % 28);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.employer_id_number),TRIM((SALT311.StrType)le.primary_name_of_organization),TRIM((SALT311.StrType)le.in_care_of_name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.group_exemption_number),TRIM((SALT311.StrType)le.subsection_code),TRIM((SALT311.StrType)le.affiliation_code),TRIM((SALT311.StrType)le.classification_code),TRIM((SALT311.StrType)le.ruling_date),TRIM((SALT311.StrType)le.deductibility_code),TRIM((SALT311.StrType)le.foundation_code),TRIM((SALT311.StrType)le.activity_codes),TRIM((SALT311.StrType)le.organization_code),TRIM((SALT311.StrType)le.exempt_org_status_code),TRIM((SALT311.StrType)le.tax_period),TRIM((SALT311.StrType)le.asset_code),TRIM((SALT311.StrType)le.income_code),TRIM((SALT311.StrType)le.filing_requirement_code_part1),TRIM((SALT311.StrType)le.filing_requirement_code_part2),TRIM((SALT311.StrType)le.accounting_period),TRIM((SALT311.StrType)le.asset_amount),TRIM((SALT311.StrType)le.income_amount),TRIM((SALT311.StrType)le.form_990_revenue_amount),TRIM((SALT311.StrType)le.national_taxonomy_exempt),TRIM((SALT311.StrType)le.sort_name)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.employer_id_number),TRIM((SALT311.StrType)le.primary_name_of_organization),TRIM((SALT311.StrType)le.in_care_of_name),TRIM((SALT311.StrType)le.street_address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.group_exemption_number),TRIM((SALT311.StrType)le.subsection_code),TRIM((SALT311.StrType)le.affiliation_code),TRIM((SALT311.StrType)le.classification_code),TRIM((SALT311.StrType)le.ruling_date),TRIM((SALT311.StrType)le.deductibility_code),TRIM((SALT311.StrType)le.foundation_code),TRIM((SALT311.StrType)le.activity_codes),TRIM((SALT311.StrType)le.organization_code),TRIM((SALT311.StrType)le.exempt_org_status_code),TRIM((SALT311.StrType)le.tax_period),TRIM((SALT311.StrType)le.asset_code),TRIM((SALT311.StrType)le.income_code),TRIM((SALT311.StrType)le.filing_requirement_code_part1),TRIM((SALT311.StrType)le.filing_requirement_code_part2),TRIM((SALT311.StrType)le.accounting_period),TRIM((SALT311.StrType)le.asset_amount),TRIM((SALT311.StrType)le.income_amount),TRIM((SALT311.StrType)le.form_990_revenue_amount),TRIM((SALT311.StrType)le.national_taxonomy_exempt),TRIM((SALT311.StrType)le.sort_name)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),28*28,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'employer_id_number'}
      ,{2,'primary_name_of_organization'}
      ,{3,'in_care_of_name'}
      ,{4,'street_address'}
      ,{5,'city'}
      ,{6,'state'}
      ,{7,'zip_code'}
      ,{8,'group_exemption_number'}
      ,{9,'subsection_code'}
      ,{10,'affiliation_code'}
      ,{11,'classification_code'}
      ,{12,'ruling_date'}
      ,{13,'deductibility_code'}
      ,{14,'foundation_code'}
      ,{15,'activity_codes'}
      ,{16,'organization_code'}
      ,{17,'exempt_org_status_code'}
      ,{18,'tax_period'}
      ,{19,'asset_code'}
      ,{20,'income_code'}
      ,{21,'filing_requirement_code_part1'}
      ,{22,'filing_requirement_code_part2'}
      ,{23,'accounting_period'}
      ,{24,'asset_amount'}
      ,{25,'income_amount'}
      ,{26,'form_990_revenue_amount'}
      ,{27,'national_taxonomy_exempt'}
      ,{28,'sort_name'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_employer_id_number((SALT311.StrType)le.employer_id_number),
    Input_Fields.InValid_primary_name_of_organization((SALT311.StrType)le.primary_name_of_organization),
    Input_Fields.InValid_in_care_of_name((SALT311.StrType)le.in_care_of_name),
    Input_Fields.InValid_street_address((SALT311.StrType)le.street_address),
    Input_Fields.InValid_city((SALT311.StrType)le.city),
    Input_Fields.InValid_state((SALT311.StrType)le.state),
    Input_Fields.InValid_zip_code((SALT311.StrType)le.zip_code),
    Input_Fields.InValid_group_exemption_number((SALT311.StrType)le.group_exemption_number),
    Input_Fields.InValid_subsection_code((SALT311.StrType)le.subsection_code),
    Input_Fields.InValid_affiliation_code((SALT311.StrType)le.affiliation_code),
    Input_Fields.InValid_classification_code((SALT311.StrType)le.classification_code),
    Input_Fields.InValid_ruling_date((SALT311.StrType)le.ruling_date),
    Input_Fields.InValid_deductibility_code((SALT311.StrType)le.deductibility_code),
    Input_Fields.InValid_foundation_code((SALT311.StrType)le.foundation_code),
    Input_Fields.InValid_activity_codes((SALT311.StrType)le.activity_codes),
    Input_Fields.InValid_organization_code((SALT311.StrType)le.organization_code),
    Input_Fields.InValid_exempt_org_status_code((SALT311.StrType)le.exempt_org_status_code),
    Input_Fields.InValid_tax_period((SALT311.StrType)le.tax_period),
    Input_Fields.InValid_asset_code((SALT311.StrType)le.asset_code),
    Input_Fields.InValid_income_code((SALT311.StrType)le.income_code),
    Input_Fields.InValid_filing_requirement_code_part1((SALT311.StrType)le.filing_requirement_code_part1),
    Input_Fields.InValid_filing_requirement_code_part2((SALT311.StrType)le.filing_requirement_code_part2),
    Input_Fields.InValid_accounting_period((SALT311.StrType)le.accounting_period),
    Input_Fields.InValid_asset_amount((SALT311.StrType)le.asset_amount),
    Input_Fields.InValid_income_amount((SALT311.StrType)le.income_amount),
    Input_Fields.InValid_form_990_revenue_amount((SALT311.StrType)le.form_990_revenue_amount),
    Input_Fields.InValid_national_taxonomy_exempt((SALT311.StrType)le.national_taxonomy_exempt),
    Input_Fields.InValid_sort_name((SALT311.StrType)le.sort_name),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,28,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_emp_id','invalid_primary_name','Unknown','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_grp_nbr','invalid_subsect_cd','invalid_affilatn_cd','invalid_class_cd','invalid_date','invalid_dedct_cd','invalid_foundatn_cd','invalid_activity_cd','invalid_org_cd','invalid_org_exmp_cd','Unknown','invalid_asset_cd','Unknown','invalid_req_p1_cd','invalid_req_p2_cd','invalid_acct_period','invalid_asset_amt','Unknown','invalid_form990_amt','invalid_natl_tax_cd','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_employer_id_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_primary_name_of_organization(TotalErrors.ErrorNum),Input_Fields.InValidMessage_in_care_of_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_street_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_group_exemption_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_subsection_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_affiliation_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_classification_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ruling_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_deductibility_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_foundation_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_activity_codes(TotalErrors.ErrorNum),Input_Fields.InValidMessage_organization_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exempt_org_status_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_tax_period(TotalErrors.ErrorNum),Input_Fields.InValidMessage_asset_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_income_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filing_requirement_code_part1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_filing_requirement_code_part2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_accounting_period(TotalErrors.ErrorNum),Input_Fields.InValidMessage_asset_amount(TotalErrors.ErrorNum),Input_Fields.InValidMessage_income_amount(TotalErrors.ErrorNum),Input_Fields.InValidMessage_form_990_revenue_amount(TotalErrors.ErrorNum),Input_Fields.InValidMessage_national_taxonomy_exempt(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sort_name(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IRS_Nonprofit, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
