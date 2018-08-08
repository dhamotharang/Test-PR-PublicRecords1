IMPORT SALT311,STD,Corp2_Mapping;
EXPORT hygiene(dataset(Corp2_Mapping.LayoutsCommon.AR) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_corp_key_cnt := COUNT(GROUP,h.corp_key <> (TYPEOF(h.corp_key))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_vendor_cnt := COUNT(GROUP,h.corp_vendor <> (TYPEOF(h.corp_vendor))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_vendor_county_cnt := COUNT(GROUP,h.corp_vendor_county <> (TYPEOF(h.corp_vendor_county))'');
    populated_corp_vendor_county_pcnt := AVE(GROUP,IF(h.corp_vendor_county = (TYPEOF(h.corp_vendor_county))'',0,100));
    maxlength_corp_vendor_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_vendor_county)));
    avelength_corp_vendor_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_vendor_county)),h.corp_vendor_county<>(typeof(h.corp_vendor_county))'');
    populated_corp_vendor_subcode_cnt := COUNT(GROUP,h.corp_vendor_subcode <> (TYPEOF(h.corp_vendor_subcode))'');
    populated_corp_vendor_subcode_pcnt := AVE(GROUP,IF(h.corp_vendor_subcode = (TYPEOF(h.corp_vendor_subcode))'',0,100));
    maxlength_corp_vendor_subcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_vendor_subcode)));
    avelength_corp_vendor_subcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_vendor_subcode)),h.corp_vendor_subcode<>(typeof(h.corp_vendor_subcode))'');
    populated_corp_state_origin_cnt := COUNT(GROUP,h.corp_state_origin <> (TYPEOF(h.corp_state_origin))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_process_date_cnt := COUNT(GROUP,h.corp_process_date <> (TYPEOF(h.corp_process_date))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_sos_charter_nbr_cnt := COUNT(GROUP,h.corp_sos_charter_nbr <> (TYPEOF(h.corp_sos_charter_nbr))'');
    populated_corp_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_sos_charter_nbr = (TYPEOF(h.corp_sos_charter_nbr))'',0,100));
    maxlength_corp_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_sos_charter_nbr)));
    avelength_corp_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.corp_sos_charter_nbr)),h.corp_sos_charter_nbr<>(typeof(h.corp_sos_charter_nbr))'');
    populated_ar_year_cnt := COUNT(GROUP,h.ar_year <> (TYPEOF(h.ar_year))'');
    populated_ar_year_pcnt := AVE(GROUP,IF(h.ar_year = (TYPEOF(h.ar_year))'',0,100));
    maxlength_ar_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_year)));
    avelength_ar_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_year)),h.ar_year<>(typeof(h.ar_year))'');
    populated_ar_mailed_dt_cnt := COUNT(GROUP,h.ar_mailed_dt <> (TYPEOF(h.ar_mailed_dt))'');
    populated_ar_mailed_dt_pcnt := AVE(GROUP,IF(h.ar_mailed_dt = (TYPEOF(h.ar_mailed_dt))'',0,100));
    maxlength_ar_mailed_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_mailed_dt)));
    avelength_ar_mailed_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_mailed_dt)),h.ar_mailed_dt<>(typeof(h.ar_mailed_dt))'');
    populated_ar_due_dt_cnt := COUNT(GROUP,h.ar_due_dt <> (TYPEOF(h.ar_due_dt))'');
    populated_ar_due_dt_pcnt := AVE(GROUP,IF(h.ar_due_dt = (TYPEOF(h.ar_due_dt))'',0,100));
    maxlength_ar_due_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_due_dt)));
    avelength_ar_due_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_due_dt)),h.ar_due_dt<>(typeof(h.ar_due_dt))'');
    populated_ar_filed_dt_cnt := COUNT(GROUP,h.ar_filed_dt <> (TYPEOF(h.ar_filed_dt))'');
    populated_ar_filed_dt_pcnt := AVE(GROUP,IF(h.ar_filed_dt = (TYPEOF(h.ar_filed_dt))'',0,100));
    maxlength_ar_filed_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_filed_dt)));
    avelength_ar_filed_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_filed_dt)),h.ar_filed_dt<>(typeof(h.ar_filed_dt))'');
    populated_ar_report_dt_cnt := COUNT(GROUP,h.ar_report_dt <> (TYPEOF(h.ar_report_dt))'');
    populated_ar_report_dt_pcnt := AVE(GROUP,IF(h.ar_report_dt = (TYPEOF(h.ar_report_dt))'',0,100));
    maxlength_ar_report_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_report_dt)));
    avelength_ar_report_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_report_dt)),h.ar_report_dt<>(typeof(h.ar_report_dt))'');
    populated_ar_report_nbr_cnt := COUNT(GROUP,h.ar_report_nbr <> (TYPEOF(h.ar_report_nbr))'');
    populated_ar_report_nbr_pcnt := AVE(GROUP,IF(h.ar_report_nbr = (TYPEOF(h.ar_report_nbr))'',0,100));
    maxlength_ar_report_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_report_nbr)));
    avelength_ar_report_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_report_nbr)),h.ar_report_nbr<>(typeof(h.ar_report_nbr))'');
    populated_ar_franchise_tax_paid_dt_cnt := COUNT(GROUP,h.ar_franchise_tax_paid_dt <> (TYPEOF(h.ar_franchise_tax_paid_dt))'');
    populated_ar_franchise_tax_paid_dt_pcnt := AVE(GROUP,IF(h.ar_franchise_tax_paid_dt = (TYPEOF(h.ar_franchise_tax_paid_dt))'',0,100));
    maxlength_ar_franchise_tax_paid_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_franchise_tax_paid_dt)));
    avelength_ar_franchise_tax_paid_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_franchise_tax_paid_dt)),h.ar_franchise_tax_paid_dt<>(typeof(h.ar_franchise_tax_paid_dt))'');
    populated_ar_delinquent_dt_cnt := COUNT(GROUP,h.ar_delinquent_dt <> (TYPEOF(h.ar_delinquent_dt))'');
    populated_ar_delinquent_dt_pcnt := AVE(GROUP,IF(h.ar_delinquent_dt = (TYPEOF(h.ar_delinquent_dt))'',0,100));
    maxlength_ar_delinquent_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_delinquent_dt)));
    avelength_ar_delinquent_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_delinquent_dt)),h.ar_delinquent_dt<>(typeof(h.ar_delinquent_dt))'');
    populated_ar_tax_factor_cnt := COUNT(GROUP,h.ar_tax_factor <> (TYPEOF(h.ar_tax_factor))'');
    populated_ar_tax_factor_pcnt := AVE(GROUP,IF(h.ar_tax_factor = (TYPEOF(h.ar_tax_factor))'',0,100));
    maxlength_ar_tax_factor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_tax_factor)));
    avelength_ar_tax_factor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_tax_factor)),h.ar_tax_factor<>(typeof(h.ar_tax_factor))'');
    populated_ar_tax_amount_paid_cnt := COUNT(GROUP,h.ar_tax_amount_paid <> (TYPEOF(h.ar_tax_amount_paid))'');
    populated_ar_tax_amount_paid_pcnt := AVE(GROUP,IF(h.ar_tax_amount_paid = (TYPEOF(h.ar_tax_amount_paid))'',0,100));
    maxlength_ar_tax_amount_paid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_tax_amount_paid)));
    avelength_ar_tax_amount_paid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_tax_amount_paid)),h.ar_tax_amount_paid<>(typeof(h.ar_tax_amount_paid))'');
    populated_ar_annual_report_cap_cnt := COUNT(GROUP,h.ar_annual_report_cap <> (TYPEOF(h.ar_annual_report_cap))'');
    populated_ar_annual_report_cap_pcnt := AVE(GROUP,IF(h.ar_annual_report_cap = (TYPEOF(h.ar_annual_report_cap))'',0,100));
    maxlength_ar_annual_report_cap := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_annual_report_cap)));
    avelength_ar_annual_report_cap := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_annual_report_cap)),h.ar_annual_report_cap<>(typeof(h.ar_annual_report_cap))'');
    populated_ar_illinois_capital_cnt := COUNT(GROUP,h.ar_illinois_capital <> (TYPEOF(h.ar_illinois_capital))'');
    populated_ar_illinois_capital_pcnt := AVE(GROUP,IF(h.ar_illinois_capital = (TYPEOF(h.ar_illinois_capital))'',0,100));
    maxlength_ar_illinois_capital := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_illinois_capital)));
    avelength_ar_illinois_capital := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_illinois_capital)),h.ar_illinois_capital<>(typeof(h.ar_illinois_capital))'');
    populated_ar_roll_cnt := COUNT(GROUP,h.ar_roll <> (TYPEOF(h.ar_roll))'');
    populated_ar_roll_pcnt := AVE(GROUP,IF(h.ar_roll = (TYPEOF(h.ar_roll))'',0,100));
    maxlength_ar_roll := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_roll)));
    avelength_ar_roll := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_roll)),h.ar_roll<>(typeof(h.ar_roll))'');
    populated_ar_frame_cnt := COUNT(GROUP,h.ar_frame <> (TYPEOF(h.ar_frame))'');
    populated_ar_frame_pcnt := AVE(GROUP,IF(h.ar_frame = (TYPEOF(h.ar_frame))'',0,100));
    maxlength_ar_frame := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_frame)));
    avelength_ar_frame := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_frame)),h.ar_frame<>(typeof(h.ar_frame))'');
    populated_ar_extension_cnt := COUNT(GROUP,h.ar_extension <> (TYPEOF(h.ar_extension))'');
    populated_ar_extension_pcnt := AVE(GROUP,IF(h.ar_extension = (TYPEOF(h.ar_extension))'',0,100));
    maxlength_ar_extension := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_extension)));
    avelength_ar_extension := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_extension)),h.ar_extension<>(typeof(h.ar_extension))'');
    populated_ar_microfilm_nbr_cnt := COUNT(GROUP,h.ar_microfilm_nbr <> (TYPEOF(h.ar_microfilm_nbr))'');
    populated_ar_microfilm_nbr_pcnt := AVE(GROUP,IF(h.ar_microfilm_nbr = (TYPEOF(h.ar_microfilm_nbr))'',0,100));
    maxlength_ar_microfilm_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_microfilm_nbr)));
    avelength_ar_microfilm_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_microfilm_nbr)),h.ar_microfilm_nbr<>(typeof(h.ar_microfilm_nbr))'');
    populated_ar_comment_cnt := COUNT(GROUP,h.ar_comment <> (TYPEOF(h.ar_comment))'');
    populated_ar_comment_pcnt := AVE(GROUP,IF(h.ar_comment = (TYPEOF(h.ar_comment))'',0,100));
    maxlength_ar_comment := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_comment)));
    avelength_ar_comment := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_comment)),h.ar_comment<>(typeof(h.ar_comment))'');
    populated_ar_type_cnt := COUNT(GROUP,h.ar_type <> (TYPEOF(h.ar_type))'');
    populated_ar_type_pcnt := AVE(GROUP,IF(h.ar_type = (TYPEOF(h.ar_type))'',0,100));
    maxlength_ar_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_type)));
    avelength_ar_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_type)),h.ar_type<>(typeof(h.ar_type))'');
    populated_ar_exempt_cnt := COUNT(GROUP,h.ar_exempt <> (TYPEOF(h.ar_exempt))'');
    populated_ar_exempt_pcnt := AVE(GROUP,IF(h.ar_exempt = (TYPEOF(h.ar_exempt))'',0,100));
    maxlength_ar_exempt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_exempt)));
    avelength_ar_exempt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_exempt)),h.ar_exempt<>(typeof(h.ar_exempt))'');
    populated_ar_license_tax_amount_cnt := COUNT(GROUP,h.ar_license_tax_amount <> (TYPEOF(h.ar_license_tax_amount))'');
    populated_ar_license_tax_amount_pcnt := AVE(GROUP,IF(h.ar_license_tax_amount = (TYPEOF(h.ar_license_tax_amount))'',0,100));
    maxlength_ar_license_tax_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_license_tax_amount)));
    avelength_ar_license_tax_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_license_tax_amount)),h.ar_license_tax_amount<>(typeof(h.ar_license_tax_amount))'');
    populated_ar_status_cnt := COUNT(GROUP,h.ar_status <> (TYPEOF(h.ar_status))'');
    populated_ar_status_pcnt := AVE(GROUP,IF(h.ar_status = (TYPEOF(h.ar_status))'',0,100));
    maxlength_ar_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_status)));
    avelength_ar_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_status)),h.ar_status<>(typeof(h.ar_status))'');
    populated_ar_paid_date_cnt := COUNT(GROUP,h.ar_paid_date <> (TYPEOF(h.ar_paid_date))'');
    populated_ar_paid_date_pcnt := AVE(GROUP,IF(h.ar_paid_date = (TYPEOF(h.ar_paid_date))'',0,100));
    maxlength_ar_paid_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_paid_date)));
    avelength_ar_paid_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_paid_date)),h.ar_paid_date<>(typeof(h.ar_paid_date))'');
    populated_ar_prev_paid_date_cnt := COUNT(GROUP,h.ar_prev_paid_date <> (TYPEOF(h.ar_prev_paid_date))'');
    populated_ar_prev_paid_date_pcnt := AVE(GROUP,IF(h.ar_prev_paid_date = (TYPEOF(h.ar_prev_paid_date))'',0,100));
    maxlength_ar_prev_paid_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_prev_paid_date)));
    avelength_ar_prev_paid_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_prev_paid_date)),h.ar_prev_paid_date<>(typeof(h.ar_prev_paid_date))'');
    populated_ar_prev_tax_factor_cnt := COUNT(GROUP,h.ar_prev_tax_factor <> (TYPEOF(h.ar_prev_tax_factor))'');
    populated_ar_prev_tax_factor_pcnt := AVE(GROUP,IF(h.ar_prev_tax_factor = (TYPEOF(h.ar_prev_tax_factor))'',0,100));
    maxlength_ar_prev_tax_factor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_prev_tax_factor)));
    avelength_ar_prev_tax_factor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_prev_tax_factor)),h.ar_prev_tax_factor<>(typeof(h.ar_prev_tax_factor))'');
    populated_ar_extension_date_cnt := COUNT(GROUP,h.ar_extension_date <> (TYPEOF(h.ar_extension_date))'');
    populated_ar_extension_date_pcnt := AVE(GROUP,IF(h.ar_extension_date = (TYPEOF(h.ar_extension_date))'',0,100));
    maxlength_ar_extension_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_extension_date)));
    avelength_ar_extension_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_extension_date)),h.ar_extension_date<>(typeof(h.ar_extension_date))'');
    populated_ar_report_mail_date_cnt := COUNT(GROUP,h.ar_report_mail_date <> (TYPEOF(h.ar_report_mail_date))'');
    populated_ar_report_mail_date_pcnt := AVE(GROUP,IF(h.ar_report_mail_date = (TYPEOF(h.ar_report_mail_date))'',0,100));
    maxlength_ar_report_mail_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_report_mail_date)));
    avelength_ar_report_mail_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_report_mail_date)),h.ar_report_mail_date<>(typeof(h.ar_report_mail_date))'');
    populated_ar_deliquent_report_mail_date_cnt := COUNT(GROUP,h.ar_deliquent_report_mail_date <> (TYPEOF(h.ar_deliquent_report_mail_date))'');
    populated_ar_deliquent_report_mail_date_pcnt := AVE(GROUP,IF(h.ar_deliquent_report_mail_date = (TYPEOF(h.ar_deliquent_report_mail_date))'',0,100));
    maxlength_ar_deliquent_report_mail_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_deliquent_report_mail_date)));
    avelength_ar_deliquent_report_mail_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_deliquent_report_mail_date)),h.ar_deliquent_report_mail_date<>(typeof(h.ar_deliquent_report_mail_date))'');
    populated_ar_report_filed_date_cnt := COUNT(GROUP,h.ar_report_filed_date <> (TYPEOF(h.ar_report_filed_date))'');
    populated_ar_report_filed_date_pcnt := AVE(GROUP,IF(h.ar_report_filed_date = (TYPEOF(h.ar_report_filed_date))'',0,100));
    maxlength_ar_report_filed_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_report_filed_date)));
    avelength_ar_report_filed_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_report_filed_date)),h.ar_report_filed_date<>(typeof(h.ar_report_filed_date))'');
    populated_ar_year_and_month_due_cnt := COUNT(GROUP,h.ar_year_and_month_due <> (TYPEOF(h.ar_year_and_month_due))'');
    populated_ar_year_and_month_due_pcnt := AVE(GROUP,IF(h.ar_year_and_month_due = (TYPEOF(h.ar_year_and_month_due))'',0,100));
    maxlength_ar_year_and_month_due := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_year_and_month_due)));
    avelength_ar_year_and_month_due := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ar_year_and_month_due)),h.ar_year_and_month_due<>(typeof(h.ar_year_and_month_due))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_vendor_county_pcnt *   0.00 / 100 + T.Populated_corp_vendor_subcode_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_ar_year_pcnt *   0.00 / 100 + T.Populated_ar_mailed_dt_pcnt *   0.00 / 100 + T.Populated_ar_due_dt_pcnt *   0.00 / 100 + T.Populated_ar_filed_dt_pcnt *   0.00 / 100 + T.Populated_ar_report_dt_pcnt *   0.00 / 100 + T.Populated_ar_report_nbr_pcnt *   0.00 / 100 + T.Populated_ar_franchise_tax_paid_dt_pcnt *   0.00 / 100 + T.Populated_ar_delinquent_dt_pcnt *   0.00 / 100 + T.Populated_ar_tax_factor_pcnt *   0.00 / 100 + T.Populated_ar_tax_amount_paid_pcnt *   0.00 / 100 + T.Populated_ar_annual_report_cap_pcnt *   0.00 / 100 + T.Populated_ar_illinois_capital_pcnt *   0.00 / 100 + T.Populated_ar_roll_pcnt *   0.00 / 100 + T.Populated_ar_frame_pcnt *   0.00 / 100 + T.Populated_ar_extension_pcnt *   0.00 / 100 + T.Populated_ar_microfilm_nbr_pcnt *   0.00 / 100 + T.Populated_ar_comment_pcnt *   0.00 / 100 + T.Populated_ar_type_pcnt *   0.00 / 100 + T.Populated_ar_exempt_pcnt *   0.00 / 100 + T.Populated_ar_license_tax_amount_pcnt *   0.00 / 100 + T.Populated_ar_status_pcnt *   0.00 / 100 + T.Populated_ar_paid_date_pcnt *   0.00 / 100 + T.Populated_ar_prev_paid_date_pcnt *   0.00 / 100 + T.Populated_ar_prev_tax_factor_pcnt *   0.00 / 100 + T.Populated_ar_extension_date_pcnt *   0.00 / 100 + T.Populated_ar_report_mail_date_pcnt *   0.00 / 100 + T.Populated_ar_deliquent_report_mail_date_pcnt *   0.00 / 100 + T.Populated_ar_report_filed_date_pcnt *   0.00 / 100 + T.Populated_ar_year_and_month_due_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','ar_year','ar_mailed_dt','ar_due_dt','ar_filed_dt','ar_report_dt','ar_report_nbr','ar_franchise_tax_paid_dt','ar_delinquent_dt','ar_tax_factor','ar_tax_amount_paid','ar_annual_report_cap','ar_illinois_capital','ar_roll','ar_frame','ar_extension','ar_microfilm_nbr','ar_comment','ar_type','ar_exempt','ar_license_tax_amount','ar_status','ar_paid_date','ar_prev_paid_date','ar_prev_tax_factor','ar_extension_date','ar_report_mail_date','ar_deliquent_report_mail_date','ar_report_filed_date','ar_year_and_month_due');
  SELF.populated_pcnt := CHOOSE(C,le.populated_corp_key_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_vendor_county_pcnt,le.populated_corp_vendor_subcode_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_sos_charter_nbr_pcnt,le.populated_ar_year_pcnt,le.populated_ar_mailed_dt_pcnt,le.populated_ar_due_dt_pcnt,le.populated_ar_filed_dt_pcnt,le.populated_ar_report_dt_pcnt,le.populated_ar_report_nbr_pcnt,le.populated_ar_franchise_tax_paid_dt_pcnt,le.populated_ar_delinquent_dt_pcnt,le.populated_ar_tax_factor_pcnt,le.populated_ar_tax_amount_paid_pcnt,le.populated_ar_annual_report_cap_pcnt,le.populated_ar_illinois_capital_pcnt,le.populated_ar_roll_pcnt,le.populated_ar_frame_pcnt,le.populated_ar_extension_pcnt,le.populated_ar_microfilm_nbr_pcnt,le.populated_ar_comment_pcnt,le.populated_ar_type_pcnt,le.populated_ar_exempt_pcnt,le.populated_ar_license_tax_amount_pcnt,le.populated_ar_status_pcnt,le.populated_ar_paid_date_pcnt,le.populated_ar_prev_paid_date_pcnt,le.populated_ar_prev_tax_factor_pcnt,le.populated_ar_extension_date_pcnt,le.populated_ar_report_mail_date_pcnt,le.populated_ar_deliquent_report_mail_date_pcnt,le.populated_ar_report_filed_date_pcnt,le.populated_ar_year_and_month_due_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_corp_key,le.maxlength_corp_vendor,le.maxlength_corp_vendor_county,le.maxlength_corp_vendor_subcode,le.maxlength_corp_state_origin,le.maxlength_corp_process_date,le.maxlength_corp_sos_charter_nbr,le.maxlength_ar_year,le.maxlength_ar_mailed_dt,le.maxlength_ar_due_dt,le.maxlength_ar_filed_dt,le.maxlength_ar_report_dt,le.maxlength_ar_report_nbr,le.maxlength_ar_franchise_tax_paid_dt,le.maxlength_ar_delinquent_dt,le.maxlength_ar_tax_factor,le.maxlength_ar_tax_amount_paid,le.maxlength_ar_annual_report_cap,le.maxlength_ar_illinois_capital,le.maxlength_ar_roll,le.maxlength_ar_frame,le.maxlength_ar_extension,le.maxlength_ar_microfilm_nbr,le.maxlength_ar_comment,le.maxlength_ar_type,le.maxlength_ar_exempt,le.maxlength_ar_license_tax_amount,le.maxlength_ar_status,le.maxlength_ar_paid_date,le.maxlength_ar_prev_paid_date,le.maxlength_ar_prev_tax_factor,le.maxlength_ar_extension_date,le.maxlength_ar_report_mail_date,le.maxlength_ar_deliquent_report_mail_date,le.maxlength_ar_report_filed_date,le.maxlength_ar_year_and_month_due);
  SELF.avelength := CHOOSE(C,le.avelength_corp_key,le.avelength_corp_vendor,le.avelength_corp_vendor_county,le.avelength_corp_vendor_subcode,le.avelength_corp_state_origin,le.avelength_corp_process_date,le.avelength_corp_sos_charter_nbr,le.avelength_ar_year,le.avelength_ar_mailed_dt,le.avelength_ar_due_dt,le.avelength_ar_filed_dt,le.avelength_ar_report_dt,le.avelength_ar_report_nbr,le.avelength_ar_franchise_tax_paid_dt,le.avelength_ar_delinquent_dt,le.avelength_ar_tax_factor,le.avelength_ar_tax_amount_paid,le.avelength_ar_annual_report_cap,le.avelength_ar_illinois_capital,le.avelength_ar_roll,le.avelength_ar_frame,le.avelength_ar_extension,le.avelength_ar_microfilm_nbr,le.avelength_ar_comment,le.avelength_ar_type,le.avelength_ar_exempt,le.avelength_ar_license_tax_amount,le.avelength_ar_status,le.avelength_ar_paid_date,le.avelength_ar_prev_paid_date,le.avelength_ar_prev_tax_factor,le.avelength_ar_extension_date,le.avelength_ar_report_mail_date,le.avelength_ar_deliquent_report_mail_date,le.avelength_ar_report_filed_date,le.avelength_ar_year_and_month_due);
END;
EXPORT invSummary := NORMALIZE(summary0, 36, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.corp_key),TRIM((SALT311.StrType)le.corp_vendor),TRIM((SALT311.StrType)le.corp_vendor_county),TRIM((SALT311.StrType)le.corp_vendor_subcode),TRIM((SALT311.StrType)le.corp_state_origin),TRIM((SALT311.StrType)le.corp_process_date),TRIM((SALT311.StrType)le.corp_sos_charter_nbr),TRIM((SALT311.StrType)le.ar_year),TRIM((SALT311.StrType)le.ar_mailed_dt),TRIM((SALT311.StrType)le.ar_due_dt),TRIM((SALT311.StrType)le.ar_filed_dt),TRIM((SALT311.StrType)le.ar_report_dt),TRIM((SALT311.StrType)le.ar_report_nbr),TRIM((SALT311.StrType)le.ar_franchise_tax_paid_dt),TRIM((SALT311.StrType)le.ar_delinquent_dt),TRIM((SALT311.StrType)le.ar_tax_factor),TRIM((SALT311.StrType)le.ar_tax_amount_paid),TRIM((SALT311.StrType)le.ar_annual_report_cap),TRIM((SALT311.StrType)le.ar_illinois_capital),TRIM((SALT311.StrType)le.ar_roll),TRIM((SALT311.StrType)le.ar_frame),TRIM((SALT311.StrType)le.ar_extension),TRIM((SALT311.StrType)le.ar_microfilm_nbr),TRIM((SALT311.StrType)le.ar_comment),TRIM((SALT311.StrType)le.ar_type),TRIM((SALT311.StrType)le.ar_exempt),TRIM((SALT311.StrType)le.ar_license_tax_amount),TRIM((SALT311.StrType)le.ar_status),TRIM((SALT311.StrType)le.ar_paid_date),TRIM((SALT311.StrType)le.ar_prev_paid_date),TRIM((SALT311.StrType)le.ar_prev_tax_factor),TRIM((SALT311.StrType)le.ar_extension_date),TRIM((SALT311.StrType)le.ar_report_mail_date),TRIM((SALT311.StrType)le.ar_deliquent_report_mail_date),TRIM((SALT311.StrType)le.ar_report_filed_date),TRIM((SALT311.StrType)le.ar_year_and_month_due)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,36,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 36);
  SELF.FldNo2 := 1 + (C % 36);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.corp_key),TRIM((SALT311.StrType)le.corp_vendor),TRIM((SALT311.StrType)le.corp_vendor_county),TRIM((SALT311.StrType)le.corp_vendor_subcode),TRIM((SALT311.StrType)le.corp_state_origin),TRIM((SALT311.StrType)le.corp_process_date),TRIM((SALT311.StrType)le.corp_sos_charter_nbr),TRIM((SALT311.StrType)le.ar_year),TRIM((SALT311.StrType)le.ar_mailed_dt),TRIM((SALT311.StrType)le.ar_due_dt),TRIM((SALT311.StrType)le.ar_filed_dt),TRIM((SALT311.StrType)le.ar_report_dt),TRIM((SALT311.StrType)le.ar_report_nbr),TRIM((SALT311.StrType)le.ar_franchise_tax_paid_dt),TRIM((SALT311.StrType)le.ar_delinquent_dt),TRIM((SALT311.StrType)le.ar_tax_factor),TRIM((SALT311.StrType)le.ar_tax_amount_paid),TRIM((SALT311.StrType)le.ar_annual_report_cap),TRIM((SALT311.StrType)le.ar_illinois_capital),TRIM((SALT311.StrType)le.ar_roll),TRIM((SALT311.StrType)le.ar_frame),TRIM((SALT311.StrType)le.ar_extension),TRIM((SALT311.StrType)le.ar_microfilm_nbr),TRIM((SALT311.StrType)le.ar_comment),TRIM((SALT311.StrType)le.ar_type),TRIM((SALT311.StrType)le.ar_exempt),TRIM((SALT311.StrType)le.ar_license_tax_amount),TRIM((SALT311.StrType)le.ar_status),TRIM((SALT311.StrType)le.ar_paid_date),TRIM((SALT311.StrType)le.ar_prev_paid_date),TRIM((SALT311.StrType)le.ar_prev_tax_factor),TRIM((SALT311.StrType)le.ar_extension_date),TRIM((SALT311.StrType)le.ar_report_mail_date),TRIM((SALT311.StrType)le.ar_deliquent_report_mail_date),TRIM((SALT311.StrType)le.ar_report_filed_date),TRIM((SALT311.StrType)le.ar_year_and_month_due)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.corp_key),TRIM((SALT311.StrType)le.corp_vendor),TRIM((SALT311.StrType)le.corp_vendor_county),TRIM((SALT311.StrType)le.corp_vendor_subcode),TRIM((SALT311.StrType)le.corp_state_origin),TRIM((SALT311.StrType)le.corp_process_date),TRIM((SALT311.StrType)le.corp_sos_charter_nbr),TRIM((SALT311.StrType)le.ar_year),TRIM((SALT311.StrType)le.ar_mailed_dt),TRIM((SALT311.StrType)le.ar_due_dt),TRIM((SALT311.StrType)le.ar_filed_dt),TRIM((SALT311.StrType)le.ar_report_dt),TRIM((SALT311.StrType)le.ar_report_nbr),TRIM((SALT311.StrType)le.ar_franchise_tax_paid_dt),TRIM((SALT311.StrType)le.ar_delinquent_dt),TRIM((SALT311.StrType)le.ar_tax_factor),TRIM((SALT311.StrType)le.ar_tax_amount_paid),TRIM((SALT311.StrType)le.ar_annual_report_cap),TRIM((SALT311.StrType)le.ar_illinois_capital),TRIM((SALT311.StrType)le.ar_roll),TRIM((SALT311.StrType)le.ar_frame),TRIM((SALT311.StrType)le.ar_extension),TRIM((SALT311.StrType)le.ar_microfilm_nbr),TRIM((SALT311.StrType)le.ar_comment),TRIM((SALT311.StrType)le.ar_type),TRIM((SALT311.StrType)le.ar_exempt),TRIM((SALT311.StrType)le.ar_license_tax_amount),TRIM((SALT311.StrType)le.ar_status),TRIM((SALT311.StrType)le.ar_paid_date),TRIM((SALT311.StrType)le.ar_prev_paid_date),TRIM((SALT311.StrType)le.ar_prev_tax_factor),TRIM((SALT311.StrType)le.ar_extension_date),TRIM((SALT311.StrType)le.ar_report_mail_date),TRIM((SALT311.StrType)le.ar_deliquent_report_mail_date),TRIM((SALT311.StrType)le.ar_report_filed_date),TRIM((SALT311.StrType)le.ar_year_and_month_due)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),36*36,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'corp_key'}
      ,{2,'corp_vendor'}
      ,{3,'corp_vendor_county'}
      ,{4,'corp_vendor_subcode'}
      ,{5,'corp_state_origin'}
      ,{6,'corp_process_date'}
      ,{7,'corp_sos_charter_nbr'}
      ,{8,'ar_year'}
      ,{9,'ar_mailed_dt'}
      ,{10,'ar_due_dt'}
      ,{11,'ar_filed_dt'}
      ,{12,'ar_report_dt'}
      ,{13,'ar_report_nbr'}
      ,{14,'ar_franchise_tax_paid_dt'}
      ,{15,'ar_delinquent_dt'}
      ,{16,'ar_tax_factor'}
      ,{17,'ar_tax_amount_paid'}
      ,{18,'ar_annual_report_cap'}
      ,{19,'ar_illinois_capital'}
      ,{20,'ar_roll'}
      ,{21,'ar_frame'}
      ,{22,'ar_extension'}
      ,{23,'ar_microfilm_nbr'}
      ,{24,'ar_comment'}
      ,{25,'ar_type'}
      ,{26,'ar_exempt'}
      ,{27,'ar_license_tax_amount'}
      ,{28,'ar_status'}
      ,{29,'ar_paid_date'}
      ,{30,'ar_prev_paid_date'}
      ,{31,'ar_prev_tax_factor'}
      ,{32,'ar_extension_date'}
      ,{33,'ar_report_mail_date'}
      ,{34,'ar_deliquent_report_mail_date'}
      ,{35,'ar_report_filed_date'}
      ,{36,'ar_year_and_month_due'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_corp_key((SALT311.StrType)le.corp_key),
    Fields.InValid_corp_vendor((SALT311.StrType)le.corp_vendor),
    Fields.InValid_corp_vendor_county((SALT311.StrType)le.corp_vendor_county),
    Fields.InValid_corp_vendor_subcode((SALT311.StrType)le.corp_vendor_subcode),
    Fields.InValid_corp_state_origin((SALT311.StrType)le.corp_state_origin),
    Fields.InValid_corp_process_date((SALT311.StrType)le.corp_process_date),
    Fields.InValid_corp_sos_charter_nbr((SALT311.StrType)le.corp_sos_charter_nbr),
    Fields.InValid_ar_year((SALT311.StrType)le.ar_year),
    Fields.InValid_ar_mailed_dt((SALT311.StrType)le.ar_mailed_dt),
    Fields.InValid_ar_due_dt((SALT311.StrType)le.ar_due_dt),
    Fields.InValid_ar_filed_dt((SALT311.StrType)le.ar_filed_dt),
    Fields.InValid_ar_report_dt((SALT311.StrType)le.ar_report_dt),
    Fields.InValid_ar_report_nbr((SALT311.StrType)le.ar_report_nbr),
    Fields.InValid_ar_franchise_tax_paid_dt((SALT311.StrType)le.ar_franchise_tax_paid_dt),
    Fields.InValid_ar_delinquent_dt((SALT311.StrType)le.ar_delinquent_dt),
    Fields.InValid_ar_tax_factor((SALT311.StrType)le.ar_tax_factor),
    Fields.InValid_ar_tax_amount_paid((SALT311.StrType)le.ar_tax_amount_paid),
    Fields.InValid_ar_annual_report_cap((SALT311.StrType)le.ar_annual_report_cap),
    Fields.InValid_ar_illinois_capital((SALT311.StrType)le.ar_illinois_capital),
    Fields.InValid_ar_roll((SALT311.StrType)le.ar_roll),
    Fields.InValid_ar_frame((SALT311.StrType)le.ar_frame),
    Fields.InValid_ar_extension((SALT311.StrType)le.ar_extension),
    Fields.InValid_ar_microfilm_nbr((SALT311.StrType)le.ar_microfilm_nbr),
    Fields.InValid_ar_comment((SALT311.StrType)le.ar_comment),
    Fields.InValid_ar_type((SALT311.StrType)le.ar_type),
    Fields.InValid_ar_exempt((SALT311.StrType)le.ar_exempt),
    Fields.InValid_ar_license_tax_amount((SALT311.StrType)le.ar_license_tax_amount),
    Fields.InValid_ar_status((SALT311.StrType)le.ar_status),
    Fields.InValid_ar_paid_date((SALT311.StrType)le.ar_paid_date),
    Fields.InValid_ar_prev_paid_date((SALT311.StrType)le.ar_prev_paid_date),
    Fields.InValid_ar_prev_tax_factor((SALT311.StrType)le.ar_prev_tax_factor),
    Fields.InValid_ar_extension_date((SALT311.StrType)le.ar_extension_date),
    Fields.InValid_ar_report_mail_date((SALT311.StrType)le.ar_report_mail_date),
    Fields.InValid_ar_deliquent_report_mail_date((SALT311.StrType)le.ar_deliquent_report_mail_date),
    Fields.InValid_ar_report_filed_date((SALT311.StrType)le.ar_report_filed_date),
    Fields.InValid_ar_year_and_month_due((SALT311.StrType)le.ar_year_and_month_due),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,36,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_corp_key','invalid_corp_vendor','Unknown','Unknown','invalid_state_origin','invalid_date','invalid_charter_nbr','invalid_numeric','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_subcode(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_ar_year(TotalErrors.ErrorNum),Fields.InValidMessage_ar_mailed_dt(TotalErrors.ErrorNum),Fields.InValidMessage_ar_due_dt(TotalErrors.ErrorNum),Fields.InValidMessage_ar_filed_dt(TotalErrors.ErrorNum),Fields.InValidMessage_ar_report_dt(TotalErrors.ErrorNum),Fields.InValidMessage_ar_report_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_ar_franchise_tax_paid_dt(TotalErrors.ErrorNum),Fields.InValidMessage_ar_delinquent_dt(TotalErrors.ErrorNum),Fields.InValidMessage_ar_tax_factor(TotalErrors.ErrorNum),Fields.InValidMessage_ar_tax_amount_paid(TotalErrors.ErrorNum),Fields.InValidMessage_ar_annual_report_cap(TotalErrors.ErrorNum),Fields.InValidMessage_ar_illinois_capital(TotalErrors.ErrorNum),Fields.InValidMessage_ar_roll(TotalErrors.ErrorNum),Fields.InValidMessage_ar_frame(TotalErrors.ErrorNum),Fields.InValidMessage_ar_extension(TotalErrors.ErrorNum),Fields.InValidMessage_ar_microfilm_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_ar_comment(TotalErrors.ErrorNum),Fields.InValidMessage_ar_type(TotalErrors.ErrorNum),Fields.InValidMessage_ar_exempt(TotalErrors.ErrorNum),Fields.InValidMessage_ar_license_tax_amount(TotalErrors.ErrorNum),Fields.InValidMessage_ar_status(TotalErrors.ErrorNum),Fields.InValidMessage_ar_paid_date(TotalErrors.ErrorNum),Fields.InValidMessage_ar_prev_paid_date(TotalErrors.ErrorNum),Fields.InValidMessage_ar_prev_tax_factor(TotalErrors.ErrorNum),Fields.InValidMessage_ar_extension_date(TotalErrors.ErrorNum),Fields.InValidMessage_ar_report_mail_date(TotalErrors.ErrorNum),Fields.InValidMessage_ar_deliquent_report_mail_date(TotalErrors.ErrorNum),Fields.InValidMessage_ar_report_filed_date(TotalErrors.ErrorNum),Fields.InValidMessage_ar_year_and_month_due(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_MI_AR, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
