IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_IRS_Nonprofit; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 24;
  EXPORT NumRulesFromFieldType := 24;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 23;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_IRS_Nonprofit)
    UNSIGNED1 employer_id_number_Invalid;
    UNSIGNED1 primary_name_of_organization_Invalid;
    UNSIGNED1 street_address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 group_exemption_number_Invalid;
    UNSIGNED1 subsection_code_Invalid;
    UNSIGNED1 affiliation_code_Invalid;
    UNSIGNED1 classification_code_Invalid;
    UNSIGNED1 ruling_date_Invalid;
    UNSIGNED1 deductibility_code_Invalid;
    UNSIGNED1 foundation_code_Invalid;
    UNSIGNED1 activity_codes_Invalid;
    UNSIGNED1 organization_code_Invalid;
    UNSIGNED1 exempt_org_status_code_Invalid;
    UNSIGNED1 asset_code_Invalid;
    UNSIGNED1 filing_requirement_code_part1_Invalid;
    UNSIGNED1 filing_requirement_code_part2_Invalid;
    UNSIGNED1 accounting_period_Invalid;
    UNSIGNED1 asset_amount_Invalid;
    UNSIGNED1 form_990_revenue_amount_Invalid;
    UNSIGNED1 national_taxonomy_exempt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_IRS_Nonprofit)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Input_Layout_IRS_Nonprofit)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'employer_id_number:invalid_emp_id:CUSTOM'
          ,'primary_name_of_organization:invalid_primary_name:CUSTOM','primary_name_of_organization:invalid_primary_name:LENGTHS'
          ,'street_address:invalid_address:CUSTOM'
          ,'city:invalid_city:CUSTOM'
          ,'state:invalid_state:CUSTOM'
          ,'zip_code:invalid_zip:CUSTOM'
          ,'group_exemption_number:invalid_grp_nbr:CUSTOM'
          ,'subsection_code:invalid_subsect_cd:CUSTOM'
          ,'affiliation_code:invalid_affilatn_cd:CUSTOM'
          ,'classification_code:invalid_class_cd:CUSTOM'
          ,'ruling_date:invalid_date:CUSTOM'
          ,'deductibility_code:invalid_dedct_cd:CUSTOM'
          ,'foundation_code:invalid_foundatn_cd:CUSTOM'
          ,'activity_codes:invalid_activity_cd:CUSTOM'
          ,'organization_code:invalid_org_cd:CUSTOM'
          ,'exempt_org_status_code:invalid_org_exmp_cd:CUSTOM'
          ,'asset_code:invalid_asset_cd:CUSTOM'
          ,'filing_requirement_code_part1:invalid_req_p1_cd:CUSTOM'
          ,'filing_requirement_code_part2:invalid_req_p2_cd:CUSTOM'
          ,'accounting_period:invalid_acct_period:CUSTOM'
          ,'asset_amount:invalid_asset_amt:CUSTOM'
          ,'form_990_revenue_amount:invalid_form990_amt:CUSTOM'
          ,'national_taxonomy_exempt:invalid_natl_tax_cd:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Input_Fields.InvalidMessage_employer_id_number(1)
          ,Input_Fields.InvalidMessage_primary_name_of_organization(1),Input_Fields.InvalidMessage_primary_name_of_organization(2)
          ,Input_Fields.InvalidMessage_street_address(1)
          ,Input_Fields.InvalidMessage_city(1)
          ,Input_Fields.InvalidMessage_state(1)
          ,Input_Fields.InvalidMessage_zip_code(1)
          ,Input_Fields.InvalidMessage_group_exemption_number(1)
          ,Input_Fields.InvalidMessage_subsection_code(1)
          ,Input_Fields.InvalidMessage_affiliation_code(1)
          ,Input_Fields.InvalidMessage_classification_code(1)
          ,Input_Fields.InvalidMessage_ruling_date(1)
          ,Input_Fields.InvalidMessage_deductibility_code(1)
          ,Input_Fields.InvalidMessage_foundation_code(1)
          ,Input_Fields.InvalidMessage_activity_codes(1)
          ,Input_Fields.InvalidMessage_organization_code(1)
          ,Input_Fields.InvalidMessage_exempt_org_status_code(1)
          ,Input_Fields.InvalidMessage_asset_code(1)
          ,Input_Fields.InvalidMessage_filing_requirement_code_part1(1)
          ,Input_Fields.InvalidMessage_filing_requirement_code_part2(1)
          ,Input_Fields.InvalidMessage_accounting_period(1)
          ,Input_Fields.InvalidMessage_asset_amount(1)
          ,Input_Fields.InvalidMessage_form_990_revenue_amount(1)
          ,Input_Fields.InvalidMessage_national_taxonomy_exempt(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Input_Layout_IRS_Nonprofit) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.employer_id_number_Invalid := Input_Fields.InValid_employer_id_number((SALT311.StrType)le.employer_id_number);
    SELF.primary_name_of_organization_Invalid := Input_Fields.InValid_primary_name_of_organization((SALT311.StrType)le.primary_name_of_organization);
    SELF.street_address_Invalid := Input_Fields.InValid_street_address((SALT311.StrType)le.street_address);
    SELF.city_Invalid := Input_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Input_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_code_Invalid := Input_Fields.InValid_zip_code((SALT311.StrType)le.zip_code);
    SELF.group_exemption_number_Invalid := Input_Fields.InValid_group_exemption_number((SALT311.StrType)le.group_exemption_number);
    SELF.subsection_code_Invalid := Input_Fields.InValid_subsection_code((SALT311.StrType)le.subsection_code);
    SELF.affiliation_code_Invalid := Input_Fields.InValid_affiliation_code((SALT311.StrType)le.affiliation_code);
    SELF.classification_code_Invalid := Input_Fields.InValid_classification_code((SALT311.StrType)le.classification_code);
    SELF.ruling_date_Invalid := Input_Fields.InValid_ruling_date((SALT311.StrType)le.ruling_date);
    SELF.deductibility_code_Invalid := Input_Fields.InValid_deductibility_code((SALT311.StrType)le.deductibility_code);
    SELF.foundation_code_Invalid := Input_Fields.InValid_foundation_code((SALT311.StrType)le.foundation_code);
    SELF.activity_codes_Invalid := Input_Fields.InValid_activity_codes((SALT311.StrType)le.activity_codes);
    SELF.organization_code_Invalid := Input_Fields.InValid_organization_code((SALT311.StrType)le.organization_code);
    SELF.exempt_org_status_code_Invalid := Input_Fields.InValid_exempt_org_status_code((SALT311.StrType)le.exempt_org_status_code);
    SELF.asset_code_Invalid := Input_Fields.InValid_asset_code((SALT311.StrType)le.asset_code);
    SELF.filing_requirement_code_part1_Invalid := Input_Fields.InValid_filing_requirement_code_part1((SALT311.StrType)le.filing_requirement_code_part1);
    SELF.filing_requirement_code_part2_Invalid := Input_Fields.InValid_filing_requirement_code_part2((SALT311.StrType)le.filing_requirement_code_part2);
    SELF.accounting_period_Invalid := Input_Fields.InValid_accounting_period((SALT311.StrType)le.accounting_period);
    SELF.asset_amount_Invalid := Input_Fields.InValid_asset_amount((SALT311.StrType)le.asset_amount);
    SELF.form_990_revenue_amount_Invalid := Input_Fields.InValid_form_990_revenue_amount((SALT311.StrType)le.form_990_revenue_amount);
    SELF.national_taxonomy_exempt_Invalid := Input_Fields.InValid_national_taxonomy_exempt((SALT311.StrType)le.national_taxonomy_exempt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_IRS_Nonprofit);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.employer_id_number_Invalid << 0 ) + ( le.primary_name_of_organization_Invalid << 1 ) + ( le.street_address_Invalid << 3 ) + ( le.city_Invalid << 4 ) + ( le.state_Invalid << 5 ) + ( le.zip_code_Invalid << 6 ) + ( le.group_exemption_number_Invalid << 7 ) + ( le.subsection_code_Invalid << 8 ) + ( le.affiliation_code_Invalid << 9 ) + ( le.classification_code_Invalid << 10 ) + ( le.ruling_date_Invalid << 11 ) + ( le.deductibility_code_Invalid << 12 ) + ( le.foundation_code_Invalid << 13 ) + ( le.activity_codes_Invalid << 14 ) + ( le.organization_code_Invalid << 15 ) + ( le.exempt_org_status_code_Invalid << 16 ) + ( le.asset_code_Invalid << 17 ) + ( le.filing_requirement_code_part1_Invalid << 18 ) + ( le.filing_requirement_code_part2_Invalid << 19 ) + ( le.accounting_period_Invalid << 20 ) + ( le.asset_amount_Invalid << 21 ) + ( le.form_990_revenue_amount_Invalid << 22 ) + ( le.national_taxonomy_exempt_Invalid << 23 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_Layout_IRS_Nonprofit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.employer_id_number_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.primary_name_of_organization_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.street_address_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.group_exemption_number_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.subsection_code_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.affiliation_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.classification_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.ruling_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.deductibility_code_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.foundation_code_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.activity_codes_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.organization_code_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.exempt_org_status_code_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.asset_code_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.filing_requirement_code_part1_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.filing_requirement_code_part2_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.accounting_period_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.asset_amount_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.form_990_revenue_amount_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.national_taxonomy_exempt_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    employer_id_number_CUSTOM_ErrorCount := COUNT(GROUP,h.employer_id_number_Invalid=1);
    primary_name_of_organization_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_name_of_organization_Invalid=1);
    primary_name_of_organization_LENGTHS_ErrorCount := COUNT(GROUP,h.primary_name_of_organization_Invalid=2);
    primary_name_of_organization_Total_ErrorCount := COUNT(GROUP,h.primary_name_of_organization_Invalid>0);
    street_address_CUSTOM_ErrorCount := COUNT(GROUP,h.street_address_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    group_exemption_number_CUSTOM_ErrorCount := COUNT(GROUP,h.group_exemption_number_Invalid=1);
    subsection_code_CUSTOM_ErrorCount := COUNT(GROUP,h.subsection_code_Invalid=1);
    affiliation_code_CUSTOM_ErrorCount := COUNT(GROUP,h.affiliation_code_Invalid=1);
    classification_code_CUSTOM_ErrorCount := COUNT(GROUP,h.classification_code_Invalid=1);
    ruling_date_CUSTOM_ErrorCount := COUNT(GROUP,h.ruling_date_Invalid=1);
    deductibility_code_CUSTOM_ErrorCount := COUNT(GROUP,h.deductibility_code_Invalid=1);
    foundation_code_CUSTOM_ErrorCount := COUNT(GROUP,h.foundation_code_Invalid=1);
    activity_codes_CUSTOM_ErrorCount := COUNT(GROUP,h.activity_codes_Invalid=1);
    organization_code_CUSTOM_ErrorCount := COUNT(GROUP,h.organization_code_Invalid=1);
    exempt_org_status_code_CUSTOM_ErrorCount := COUNT(GROUP,h.exempt_org_status_code_Invalid=1);
    asset_code_CUSTOM_ErrorCount := COUNT(GROUP,h.asset_code_Invalid=1);
    filing_requirement_code_part1_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_requirement_code_part1_Invalid=1);
    filing_requirement_code_part2_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_requirement_code_part2_Invalid=1);
    accounting_period_CUSTOM_ErrorCount := COUNT(GROUP,h.accounting_period_Invalid=1);
    asset_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.asset_amount_Invalid=1);
    form_990_revenue_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.form_990_revenue_amount_Invalid=1);
    national_taxonomy_exempt_CUSTOM_ErrorCount := COUNT(GROUP,h.national_taxonomy_exempt_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.employer_id_number_Invalid > 0 OR h.primary_name_of_organization_Invalid > 0 OR h.street_address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.group_exemption_number_Invalid > 0 OR h.subsection_code_Invalid > 0 OR h.affiliation_code_Invalid > 0 OR h.classification_code_Invalid > 0 OR h.ruling_date_Invalid > 0 OR h.deductibility_code_Invalid > 0 OR h.foundation_code_Invalid > 0 OR h.activity_codes_Invalid > 0 OR h.organization_code_Invalid > 0 OR h.exempt_org_status_code_Invalid > 0 OR h.asset_code_Invalid > 0 OR h.filing_requirement_code_part1_Invalid > 0 OR h.filing_requirement_code_part2_Invalid > 0 OR h.accounting_period_Invalid > 0 OR h.asset_amount_Invalid > 0 OR h.form_990_revenue_amount_Invalid > 0 OR h.national_taxonomy_exempt_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.employer_id_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_name_of_organization_Total_ErrorCount > 0, 1, 0) + IF(le.street_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.group_exemption_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.subsection_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.affiliation_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.classification_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ruling_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deductibility_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.foundation_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.activity_codes_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.organization_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exempt_org_status_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.asset_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_requirement_code_part1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_requirement_code_part2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.accounting_period_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.asset_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.form_990_revenue_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.national_taxonomy_exempt_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.employer_id_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_name_of_organization_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_name_of_organization_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.street_address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.group_exemption_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.subsection_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.affiliation_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.classification_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ruling_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deductibility_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.foundation_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.activity_codes_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.organization_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exempt_org_status_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.asset_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_requirement_code_part1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_requirement_code_part2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.accounting_period_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.asset_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.form_990_revenue_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.national_taxonomy_exempt_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.employer_id_number_Invalid,le.primary_name_of_organization_Invalid,le.street_address_Invalid,le.city_Invalid,le.state_Invalid,le.zip_code_Invalid,le.group_exemption_number_Invalid,le.subsection_code_Invalid,le.affiliation_code_Invalid,le.classification_code_Invalid,le.ruling_date_Invalid,le.deductibility_code_Invalid,le.foundation_code_Invalid,le.activity_codes_Invalid,le.organization_code_Invalid,le.exempt_org_status_code_Invalid,le.asset_code_Invalid,le.filing_requirement_code_part1_Invalid,le.filing_requirement_code_part2_Invalid,le.accounting_period_Invalid,le.asset_amount_Invalid,le.form_990_revenue_amount_Invalid,le.national_taxonomy_exempt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_employer_id_number(le.employer_id_number_Invalid),Input_Fields.InvalidMessage_primary_name_of_organization(le.primary_name_of_organization_Invalid),Input_Fields.InvalidMessage_street_address(le.street_address_Invalid),Input_Fields.InvalidMessage_city(le.city_Invalid),Input_Fields.InvalidMessage_state(le.state_Invalid),Input_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Input_Fields.InvalidMessage_group_exemption_number(le.group_exemption_number_Invalid),Input_Fields.InvalidMessage_subsection_code(le.subsection_code_Invalid),Input_Fields.InvalidMessage_affiliation_code(le.affiliation_code_Invalid),Input_Fields.InvalidMessage_classification_code(le.classification_code_Invalid),Input_Fields.InvalidMessage_ruling_date(le.ruling_date_Invalid),Input_Fields.InvalidMessage_deductibility_code(le.deductibility_code_Invalid),Input_Fields.InvalidMessage_foundation_code(le.foundation_code_Invalid),Input_Fields.InvalidMessage_activity_codes(le.activity_codes_Invalid),Input_Fields.InvalidMessage_organization_code(le.organization_code_Invalid),Input_Fields.InvalidMessage_exempt_org_status_code(le.exempt_org_status_code_Invalid),Input_Fields.InvalidMessage_asset_code(le.asset_code_Invalid),Input_Fields.InvalidMessage_filing_requirement_code_part1(le.filing_requirement_code_part1_Invalid),Input_Fields.InvalidMessage_filing_requirement_code_part2(le.filing_requirement_code_part2_Invalid),Input_Fields.InvalidMessage_accounting_period(le.accounting_period_Invalid),Input_Fields.InvalidMessage_asset_amount(le.asset_amount_Invalid),Input_Fields.InvalidMessage_form_990_revenue_amount(le.form_990_revenue_amount_Invalid),Input_Fields.InvalidMessage_national_taxonomy_exempt(le.national_taxonomy_exempt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.employer_id_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_name_of_organization_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.street_address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.group_exemption_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.subsection_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.affiliation_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.classification_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ruling_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deductibility_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.foundation_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.activity_codes_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.organization_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.exempt_org_status_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.asset_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_requirement_code_part1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_requirement_code_part2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.accounting_period_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.asset_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.form_990_revenue_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.national_taxonomy_exempt_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'employer_id_number','primary_name_of_organization','street_address','city','state','zip_code','group_exemption_number','subsection_code','affiliation_code','classification_code','ruling_date','deductibility_code','foundation_code','activity_codes','organization_code','exempt_org_status_code','asset_code','filing_requirement_code_part1','filing_requirement_code_part2','accounting_period','asset_amount','form_990_revenue_amount','national_taxonomy_exempt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_emp_id','invalid_primary_name','invalid_address','invalid_city','invalid_state','invalid_zip','invalid_grp_nbr','invalid_subsect_cd','invalid_affilatn_cd','invalid_class_cd','invalid_date','invalid_dedct_cd','invalid_foundatn_cd','invalid_activity_cd','invalid_org_cd','invalid_org_exmp_cd','invalid_asset_cd','invalid_req_p1_cd','invalid_req_p2_cd','invalid_acct_period','invalid_asset_amt','invalid_form990_amt','invalid_natl_tax_cd','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.employer_id_number,(SALT311.StrType)le.primary_name_of_organization,(SALT311.StrType)le.street_address,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip_code,(SALT311.StrType)le.group_exemption_number,(SALT311.StrType)le.subsection_code,(SALT311.StrType)le.affiliation_code,(SALT311.StrType)le.classification_code,(SALT311.StrType)le.ruling_date,(SALT311.StrType)le.deductibility_code,(SALT311.StrType)le.foundation_code,(SALT311.StrType)le.activity_codes,(SALT311.StrType)le.organization_code,(SALT311.StrType)le.exempt_org_status_code,(SALT311.StrType)le.asset_code,(SALT311.StrType)le.filing_requirement_code_part1,(SALT311.StrType)le.filing_requirement_code_part2,(SALT311.StrType)le.accounting_period,(SALT311.StrType)le.asset_amount,(SALT311.StrType)le.form_990_revenue_amount,(SALT311.StrType)le.national_taxonomy_exempt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,23,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_IRS_Nonprofit) prevDS = DATASET([], Input_Layout_IRS_Nonprofit), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.employer_id_number_CUSTOM_ErrorCount
          ,le.primary_name_of_organization_CUSTOM_ErrorCount,le.primary_name_of_organization_LENGTHS_ErrorCount
          ,le.street_address_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.group_exemption_number_CUSTOM_ErrorCount
          ,le.subsection_code_CUSTOM_ErrorCount
          ,le.affiliation_code_CUSTOM_ErrorCount
          ,le.classification_code_CUSTOM_ErrorCount
          ,le.ruling_date_CUSTOM_ErrorCount
          ,le.deductibility_code_CUSTOM_ErrorCount
          ,le.foundation_code_CUSTOM_ErrorCount
          ,le.activity_codes_CUSTOM_ErrorCount
          ,le.organization_code_CUSTOM_ErrorCount
          ,le.exempt_org_status_code_CUSTOM_ErrorCount
          ,le.asset_code_CUSTOM_ErrorCount
          ,le.filing_requirement_code_part1_CUSTOM_ErrorCount
          ,le.filing_requirement_code_part2_CUSTOM_ErrorCount
          ,le.accounting_period_CUSTOM_ErrorCount
          ,le.asset_amount_CUSTOM_ErrorCount
          ,le.form_990_revenue_amount_CUSTOM_ErrorCount
          ,le.national_taxonomy_exempt_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.employer_id_number_CUSTOM_ErrorCount
          ,le.primary_name_of_organization_CUSTOM_ErrorCount,le.primary_name_of_organization_LENGTHS_ErrorCount
          ,le.street_address_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.group_exemption_number_CUSTOM_ErrorCount
          ,le.subsection_code_CUSTOM_ErrorCount
          ,le.affiliation_code_CUSTOM_ErrorCount
          ,le.classification_code_CUSTOM_ErrorCount
          ,le.ruling_date_CUSTOM_ErrorCount
          ,le.deductibility_code_CUSTOM_ErrorCount
          ,le.foundation_code_CUSTOM_ErrorCount
          ,le.activity_codes_CUSTOM_ErrorCount
          ,le.organization_code_CUSTOM_ErrorCount
          ,le.exempt_org_status_code_CUSTOM_ErrorCount
          ,le.asset_code_CUSTOM_ErrorCount
          ,le.filing_requirement_code_part1_CUSTOM_ErrorCount
          ,le.filing_requirement_code_part2_CUSTOM_ErrorCount
          ,le.accounting_period_CUSTOM_ErrorCount
          ,le.asset_amount_CUSTOM_ErrorCount
          ,le.form_990_revenue_amount_CUSTOM_ErrorCount
          ,le.national_taxonomy_exempt_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_IRS_Nonprofit));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'employer_id_number:' + getFieldTypeText(h.employer_id_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_name_of_organization:' + getFieldTypeText(h.primary_name_of_organization) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'in_care_of_name:' + getFieldTypeText(h.in_care_of_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_address:' + getFieldTypeText(h.street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'group_exemption_number:' + getFieldTypeText(h.group_exemption_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsection_code:' + getFieldTypeText(h.subsection_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'affiliation_code:' + getFieldTypeText(h.affiliation_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classification_code:' + getFieldTypeText(h.classification_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ruling_date:' + getFieldTypeText(h.ruling_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deductibility_code:' + getFieldTypeText(h.deductibility_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'foundation_code:' + getFieldTypeText(h.foundation_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'activity_codes:' + getFieldTypeText(h.activity_codes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'organization_code:' + getFieldTypeText(h.organization_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exempt_org_status_code:' + getFieldTypeText(h.exempt_org_status_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_period:' + getFieldTypeText(h.tax_period) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'asset_code:' + getFieldTypeText(h.asset_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'income_code:' + getFieldTypeText(h.income_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_requirement_code_part1:' + getFieldTypeText(h.filing_requirement_code_part1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_requirement_code_part2:' + getFieldTypeText(h.filing_requirement_code_part2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'accounting_period:' + getFieldTypeText(h.accounting_period) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'asset_amount:' + getFieldTypeText(h.asset_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'income_amount:' + getFieldTypeText(h.income_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'form_990_revenue_amount:' + getFieldTypeText(h.form_990_revenue_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'national_taxonomy_exempt:' + getFieldTypeText(h.national_taxonomy_exempt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sort_name:' + getFieldTypeText(h.sort_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_employer_id_number_cnt
          ,le.populated_primary_name_of_organization_cnt
          ,le.populated_in_care_of_name_cnt
          ,le.populated_street_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_group_exemption_number_cnt
          ,le.populated_subsection_code_cnt
          ,le.populated_affiliation_code_cnt
          ,le.populated_classification_code_cnt
          ,le.populated_ruling_date_cnt
          ,le.populated_deductibility_code_cnt
          ,le.populated_foundation_code_cnt
          ,le.populated_activity_codes_cnt
          ,le.populated_organization_code_cnt
          ,le.populated_exempt_org_status_code_cnt
          ,le.populated_tax_period_cnt
          ,le.populated_asset_code_cnt
          ,le.populated_income_code_cnt
          ,le.populated_filing_requirement_code_part1_cnt
          ,le.populated_filing_requirement_code_part2_cnt
          ,le.populated_accounting_period_cnt
          ,le.populated_asset_amount_cnt
          ,le.populated_income_amount_cnt
          ,le.populated_form_990_revenue_amount_cnt
          ,le.populated_national_taxonomy_exempt_cnt
          ,le.populated_sort_name_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_employer_id_number_pcnt
          ,le.populated_primary_name_of_organization_pcnt
          ,le.populated_in_care_of_name_pcnt
          ,le.populated_street_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_group_exemption_number_pcnt
          ,le.populated_subsection_code_pcnt
          ,le.populated_affiliation_code_pcnt
          ,le.populated_classification_code_pcnt
          ,le.populated_ruling_date_pcnt
          ,le.populated_deductibility_code_pcnt
          ,le.populated_foundation_code_pcnt
          ,le.populated_activity_codes_pcnt
          ,le.populated_organization_code_pcnt
          ,le.populated_exempt_org_status_code_pcnt
          ,le.populated_tax_period_pcnt
          ,le.populated_asset_code_pcnt
          ,le.populated_income_code_pcnt
          ,le.populated_filing_requirement_code_part1_pcnt
          ,le.populated_filing_requirement_code_part2_pcnt
          ,le.populated_accounting_period_pcnt
          ,le.populated_asset_amount_pcnt
          ,le.populated_income_amount_pcnt
          ,le.populated_form_990_revenue_amount_pcnt
          ,le.populated_national_taxonomy_exempt_pcnt
          ,le.populated_sort_name_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,28,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_IRS_Nonprofit));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),28,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_IRS_Nonprofit) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_IRS_Nonprofit, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
