IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_reported_cnt := COUNT(GROUP,h.dt_first_reported <> (TYPEOF(h.dt_first_reported))'');
    populated_dt_first_reported_pcnt := AVE(GROUP,IF(h.dt_first_reported = (TYPEOF(h.dt_first_reported))'',0,100));
    maxlength_dt_first_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_reported)));
    avelength_dt_first_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_reported)),h.dt_first_reported<>(typeof(h.dt_first_reported))'');
    populated_dt_last_reported_cnt := COUNT(GROUP,h.dt_last_reported <> (TYPEOF(h.dt_last_reported))'');
    populated_dt_last_reported_pcnt := AVE(GROUP,IF(h.dt_last_reported = (TYPEOF(h.dt_last_reported))'',0,100));
    maxlength_dt_last_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_reported)));
    avelength_dt_last_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_reported)),h.dt_last_reported<>(typeof(h.dt_last_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_source_file_cnt := COUNT(GROUP,h.source_file <> (TYPEOF(h.source_file))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_case_key_cnt := COUNT(GROUP,h.case_key <> (TYPEOF(h.case_key))'');
    populated_case_key_pcnt := AVE(GROUP,IF(h.case_key = (TYPEOF(h.case_key))'',0,100));
    maxlength_case_key := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_key)));
    avelength_case_key := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_key)),h.case_key<>(typeof(h.case_key))'');
    populated_parent_case_key_cnt := COUNT(GROUP,h.parent_case_key <> (TYPEOF(h.parent_case_key))'');
    populated_parent_case_key_pcnt := AVE(GROUP,IF(h.parent_case_key = (TYPEOF(h.parent_case_key))'',0,100));
    maxlength_parent_case_key := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.parent_case_key)));
    avelength_parent_case_key := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.parent_case_key)),h.parent_case_key<>(typeof(h.parent_case_key))'');
    populated_court_code_cnt := COUNT(GROUP,h.court_code <> (TYPEOF(h.court_code))'');
    populated_court_code_pcnt := AVE(GROUP,IF(h.court_code = (TYPEOF(h.court_code))'',0,100));
    maxlength_court_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.court_code)));
    avelength_court_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.court_code)),h.court_code<>(typeof(h.court_code))'');
    populated_court_cnt := COUNT(GROUP,h.court <> (TYPEOF(h.court))'');
    populated_court_pcnt := AVE(GROUP,IF(h.court = (TYPEOF(h.court))'',0,100));
    maxlength_court := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.court)));
    avelength_court := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.court)),h.court<>(typeof(h.court))'');
    populated_case_number_cnt := COUNT(GROUP,h.case_number <> (TYPEOF(h.case_number))'');
    populated_case_number_pcnt := AVE(GROUP,IF(h.case_number = (TYPEOF(h.case_number))'',0,100));
    maxlength_case_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_number)));
    avelength_case_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_number)),h.case_number<>(typeof(h.case_number))'');
    populated_case_type_code_cnt := COUNT(GROUP,h.case_type_code <> (TYPEOF(h.case_type_code))'');
    populated_case_type_code_pcnt := AVE(GROUP,IF(h.case_type_code = (TYPEOF(h.case_type_code))'',0,100));
    maxlength_case_type_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_type_code)));
    avelength_case_type_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_type_code)),h.case_type_code<>(typeof(h.case_type_code))'');
    populated_case_type_cnt := COUNT(GROUP,h.case_type <> (TYPEOF(h.case_type))'');
    populated_case_type_pcnt := AVE(GROUP,IF(h.case_type = (TYPEOF(h.case_type))'',0,100));
    maxlength_case_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_type)));
    avelength_case_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_type)),h.case_type<>(typeof(h.case_type))'');
    populated_case_title_cnt := COUNT(GROUP,h.case_title <> (TYPEOF(h.case_title))'');
    populated_case_title_pcnt := AVE(GROUP,IF(h.case_title = (TYPEOF(h.case_title))'',0,100));
    maxlength_case_title := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_title)));
    avelength_case_title := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_title)),h.case_title<>(typeof(h.case_title))'');
    populated_case_cause_code_cnt := COUNT(GROUP,h.case_cause_code <> (TYPEOF(h.case_cause_code))'');
    populated_case_cause_code_pcnt := AVE(GROUP,IF(h.case_cause_code = (TYPEOF(h.case_cause_code))'',0,100));
    maxlength_case_cause_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_cause_code)));
    avelength_case_cause_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_cause_code)),h.case_cause_code<>(typeof(h.case_cause_code))'');
    populated_case_cause_cnt := COUNT(GROUP,h.case_cause <> (TYPEOF(h.case_cause))'');
    populated_case_cause_pcnt := AVE(GROUP,IF(h.case_cause = (TYPEOF(h.case_cause))'',0,100));
    maxlength_case_cause := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_cause)));
    avelength_case_cause := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_cause)),h.case_cause<>(typeof(h.case_cause))'');
    populated_manner_of_filing_code_cnt := COUNT(GROUP,h.manner_of_filing_code <> (TYPEOF(h.manner_of_filing_code))'');
    populated_manner_of_filing_code_pcnt := AVE(GROUP,IF(h.manner_of_filing_code = (TYPEOF(h.manner_of_filing_code))'',0,100));
    maxlength_manner_of_filing_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.manner_of_filing_code)));
    avelength_manner_of_filing_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.manner_of_filing_code)),h.manner_of_filing_code<>(typeof(h.manner_of_filing_code))'');
    populated_manner_of_filing_cnt := COUNT(GROUP,h.manner_of_filing <> (TYPEOF(h.manner_of_filing))'');
    populated_manner_of_filing_pcnt := AVE(GROUP,IF(h.manner_of_filing = (TYPEOF(h.manner_of_filing))'',0,100));
    maxlength_manner_of_filing := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.manner_of_filing)));
    avelength_manner_of_filing := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.manner_of_filing)),h.manner_of_filing<>(typeof(h.manner_of_filing))'');
    populated_filing_date_cnt := COUNT(GROUP,h.filing_date <> (TYPEOF(h.filing_date))'');
    populated_filing_date_pcnt := AVE(GROUP,IF(h.filing_date = (TYPEOF(h.filing_date))'',0,100));
    maxlength_filing_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.filing_date)));
    avelength_filing_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.filing_date)),h.filing_date<>(typeof(h.filing_date))'');
    populated_manner_of_judgmt_code_cnt := COUNT(GROUP,h.manner_of_judgmt_code <> (TYPEOF(h.manner_of_judgmt_code))'');
    populated_manner_of_judgmt_code_pcnt := AVE(GROUP,IF(h.manner_of_judgmt_code = (TYPEOF(h.manner_of_judgmt_code))'',0,100));
    maxlength_manner_of_judgmt_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.manner_of_judgmt_code)));
    avelength_manner_of_judgmt_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.manner_of_judgmt_code)),h.manner_of_judgmt_code<>(typeof(h.manner_of_judgmt_code))'');
    populated_manner_of_judgmt_cnt := COUNT(GROUP,h.manner_of_judgmt <> (TYPEOF(h.manner_of_judgmt))'');
    populated_manner_of_judgmt_pcnt := AVE(GROUP,IF(h.manner_of_judgmt = (TYPEOF(h.manner_of_judgmt))'',0,100));
    maxlength_manner_of_judgmt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.manner_of_judgmt)));
    avelength_manner_of_judgmt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.manner_of_judgmt)),h.manner_of_judgmt<>(typeof(h.manner_of_judgmt))'');
    populated_judgmt_date_cnt := COUNT(GROUP,h.judgmt_date <> (TYPEOF(h.judgmt_date))'');
    populated_judgmt_date_pcnt := AVE(GROUP,IF(h.judgmt_date = (TYPEOF(h.judgmt_date))'',0,100));
    maxlength_judgmt_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_date)));
    avelength_judgmt_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_date)),h.judgmt_date<>(typeof(h.judgmt_date))'');
    populated_ruled_for_against_code_cnt := COUNT(GROUP,h.ruled_for_against_code <> (TYPEOF(h.ruled_for_against_code))'');
    populated_ruled_for_against_code_pcnt := AVE(GROUP,IF(h.ruled_for_against_code = (TYPEOF(h.ruled_for_against_code))'',0,100));
    maxlength_ruled_for_against_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ruled_for_against_code)));
    avelength_ruled_for_against_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ruled_for_against_code)),h.ruled_for_against_code<>(typeof(h.ruled_for_against_code))'');
    populated_ruled_for_against_cnt := COUNT(GROUP,h.ruled_for_against <> (TYPEOF(h.ruled_for_against))'');
    populated_ruled_for_against_pcnt := AVE(GROUP,IF(h.ruled_for_against = (TYPEOF(h.ruled_for_against))'',0,100));
    maxlength_ruled_for_against := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ruled_for_against)));
    avelength_ruled_for_against := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ruled_for_against)),h.ruled_for_against<>(typeof(h.ruled_for_against))'');
    populated_judgmt_type_code_cnt := COUNT(GROUP,h.judgmt_type_code <> (TYPEOF(h.judgmt_type_code))'');
    populated_judgmt_type_code_pcnt := AVE(GROUP,IF(h.judgmt_type_code = (TYPEOF(h.judgmt_type_code))'',0,100));
    maxlength_judgmt_type_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_type_code)));
    avelength_judgmt_type_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_type_code)),h.judgmt_type_code<>(typeof(h.judgmt_type_code))'');
    populated_judgmt_type_cnt := COUNT(GROUP,h.judgmt_type <> (TYPEOF(h.judgmt_type))'');
    populated_judgmt_type_pcnt := AVE(GROUP,IF(h.judgmt_type = (TYPEOF(h.judgmt_type))'',0,100));
    maxlength_judgmt_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_type)));
    avelength_judgmt_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_type)),h.judgmt_type<>(typeof(h.judgmt_type))'');
    populated_judgmt_disposition_date_cnt := COUNT(GROUP,h.judgmt_disposition_date <> (TYPEOF(h.judgmt_disposition_date))'');
    populated_judgmt_disposition_date_pcnt := AVE(GROUP,IF(h.judgmt_disposition_date = (TYPEOF(h.judgmt_disposition_date))'',0,100));
    maxlength_judgmt_disposition_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_disposition_date)));
    avelength_judgmt_disposition_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_disposition_date)),h.judgmt_disposition_date<>(typeof(h.judgmt_disposition_date))'');
    populated_judgmt_disposition_code_cnt := COUNT(GROUP,h.judgmt_disposition_code <> (TYPEOF(h.judgmt_disposition_code))'');
    populated_judgmt_disposition_code_pcnt := AVE(GROUP,IF(h.judgmt_disposition_code = (TYPEOF(h.judgmt_disposition_code))'',0,100));
    maxlength_judgmt_disposition_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_disposition_code)));
    avelength_judgmt_disposition_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_disposition_code)),h.judgmt_disposition_code<>(typeof(h.judgmt_disposition_code))'');
    populated_judgmt_disposition_cnt := COUNT(GROUP,h.judgmt_disposition <> (TYPEOF(h.judgmt_disposition))'');
    populated_judgmt_disposition_pcnt := AVE(GROUP,IF(h.judgmt_disposition = (TYPEOF(h.judgmt_disposition))'',0,100));
    maxlength_judgmt_disposition := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_disposition)));
    avelength_judgmt_disposition := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.judgmt_disposition)),h.judgmt_disposition<>(typeof(h.judgmt_disposition))'');
    populated_disposition_code_cnt := COUNT(GROUP,h.disposition_code <> (TYPEOF(h.disposition_code))'');
    populated_disposition_code_pcnt := AVE(GROUP,IF(h.disposition_code = (TYPEOF(h.disposition_code))'',0,100));
    maxlength_disposition_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.disposition_code)));
    avelength_disposition_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.disposition_code)),h.disposition_code<>(typeof(h.disposition_code))'');
    populated_disposition_description_cnt := COUNT(GROUP,h.disposition_description <> (TYPEOF(h.disposition_description))'');
    populated_disposition_description_pcnt := AVE(GROUP,IF(h.disposition_description = (TYPEOF(h.disposition_description))'',0,100));
    maxlength_disposition_description := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.disposition_description)));
    avelength_disposition_description := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.disposition_description)),h.disposition_description<>(typeof(h.disposition_description))'');
    populated_disposition_date_cnt := COUNT(GROUP,h.disposition_date <> (TYPEOF(h.disposition_date))'');
    populated_disposition_date_pcnt := AVE(GROUP,IF(h.disposition_date = (TYPEOF(h.disposition_date))'',0,100));
    maxlength_disposition_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.disposition_date)));
    avelength_disposition_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.disposition_date)),h.disposition_date<>(typeof(h.disposition_date))'');
    populated_suit_amount_cnt := COUNT(GROUP,h.suit_amount <> (TYPEOF(h.suit_amount))'');
    populated_suit_amount_pcnt := AVE(GROUP,IF(h.suit_amount = (TYPEOF(h.suit_amount))'',0,100));
    maxlength_suit_amount := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.suit_amount)));
    avelength_suit_amount := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.suit_amount)),h.suit_amount<>(typeof(h.suit_amount))'');
    populated_award_amount_cnt := COUNT(GROUP,h.award_amount <> (TYPEOF(h.award_amount))'');
    populated_award_amount_pcnt := AVE(GROUP,IF(h.award_amount = (TYPEOF(h.award_amount))'',0,100));
    maxlength_award_amount := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.award_amount)));
    avelength_award_amount := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.award_amount)),h.award_amount<>(typeof(h.award_amount))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_case_key_pcnt *   0.00 / 100 + T.Populated_parent_case_key_pcnt *   0.00 / 100 + T.Populated_court_code_pcnt *   0.00 / 100 + T.Populated_court_pcnt *   0.00 / 100 + T.Populated_case_number_pcnt *   0.00 / 100 + T.Populated_case_type_code_pcnt *   0.00 / 100 + T.Populated_case_type_pcnt *   0.00 / 100 + T.Populated_case_title_pcnt *   0.00 / 100 + T.Populated_case_cause_code_pcnt *   0.00 / 100 + T.Populated_case_cause_pcnt *   0.00 / 100 + T.Populated_manner_of_filing_code_pcnt *   0.00 / 100 + T.Populated_manner_of_filing_pcnt *   0.00 / 100 + T.Populated_filing_date_pcnt *   0.00 / 100 + T.Populated_manner_of_judgmt_code_pcnt *   0.00 / 100 + T.Populated_manner_of_judgmt_pcnt *   0.00 / 100 + T.Populated_judgmt_date_pcnt *   0.00 / 100 + T.Populated_ruled_for_against_code_pcnt *   0.00 / 100 + T.Populated_ruled_for_against_pcnt *   0.00 / 100 + T.Populated_judgmt_type_code_pcnt *   0.00 / 100 + T.Populated_judgmt_type_pcnt *   0.00 / 100 + T.Populated_judgmt_disposition_date_pcnt *   0.00 / 100 + T.Populated_judgmt_disposition_code_pcnt *   0.00 / 100 + T.Populated_judgmt_disposition_pcnt *   0.00 / 100 + T.Populated_disposition_code_pcnt *   0.00 / 100 + T.Populated_disposition_description_pcnt *   0.00 / 100 + T.Populated_disposition_date_pcnt *   0.00 / 100 + T.Populated_suit_amount_pcnt *   0.00 / 100 + T.Populated_award_amount_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','parent_case_key','court_code','court','case_number','case_type_code','case_type','case_title','case_cause_code','case_cause','manner_of_filing_code','manner_of_filing','filing_date','manner_of_judgmt_code','manner_of_judgmt','judgmt_date','ruled_for_against_code','ruled_for_against','judgmt_type_code','judgmt_type','judgmt_disposition_date','judgmt_disposition_code','judgmt_disposition','disposition_code','disposition_description','disposition_date','suit_amount','award_amount');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_reported_pcnt,le.populated_dt_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_vendor_pcnt,le.populated_state_origin_pcnt,le.populated_source_file_pcnt,le.populated_case_key_pcnt,le.populated_parent_case_key_pcnt,le.populated_court_code_pcnt,le.populated_court_pcnt,le.populated_case_number_pcnt,le.populated_case_type_code_pcnt,le.populated_case_type_pcnt,le.populated_case_title_pcnt,le.populated_case_cause_code_pcnt,le.populated_case_cause_pcnt,le.populated_manner_of_filing_code_pcnt,le.populated_manner_of_filing_pcnt,le.populated_filing_date_pcnt,le.populated_manner_of_judgmt_code_pcnt,le.populated_manner_of_judgmt_pcnt,le.populated_judgmt_date_pcnt,le.populated_ruled_for_against_code_pcnt,le.populated_ruled_for_against_pcnt,le.populated_judgmt_type_code_pcnt,le.populated_judgmt_type_pcnt,le.populated_judgmt_disposition_date_pcnt,le.populated_judgmt_disposition_code_pcnt,le.populated_judgmt_disposition_pcnt,le.populated_disposition_code_pcnt,le.populated_disposition_description_pcnt,le.populated_disposition_date_pcnt,le.populated_suit_amount_pcnt,le.populated_award_amount_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_reported,le.maxlength_dt_last_reported,le.maxlength_process_date,le.maxlength_vendor,le.maxlength_state_origin,le.maxlength_source_file,le.maxlength_case_key,le.maxlength_parent_case_key,le.maxlength_court_code,le.maxlength_court,le.maxlength_case_number,le.maxlength_case_type_code,le.maxlength_case_type,le.maxlength_case_title,le.maxlength_case_cause_code,le.maxlength_case_cause,le.maxlength_manner_of_filing_code,le.maxlength_manner_of_filing,le.maxlength_filing_date,le.maxlength_manner_of_judgmt_code,le.maxlength_manner_of_judgmt,le.maxlength_judgmt_date,le.maxlength_ruled_for_against_code,le.maxlength_ruled_for_against,le.maxlength_judgmt_type_code,le.maxlength_judgmt_type,le.maxlength_judgmt_disposition_date,le.maxlength_judgmt_disposition_code,le.maxlength_judgmt_disposition,le.maxlength_disposition_code,le.maxlength_disposition_description,le.maxlength_disposition_date,le.maxlength_suit_amount,le.maxlength_award_amount);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_reported,le.avelength_dt_last_reported,le.avelength_process_date,le.avelength_vendor,le.avelength_state_origin,le.avelength_source_file,le.avelength_case_key,le.avelength_parent_case_key,le.avelength_court_code,le.avelength_court,le.avelength_case_number,le.avelength_case_type_code,le.avelength_case_type,le.avelength_case_title,le.avelength_case_cause_code,le.avelength_case_cause,le.avelength_manner_of_filing_code,le.avelength_manner_of_filing,le.avelength_filing_date,le.avelength_manner_of_judgmt_code,le.avelength_manner_of_judgmt,le.avelength_judgmt_date,le.avelength_ruled_for_against_code,le.avelength_ruled_for_against,le.avelength_judgmt_type_code,le.avelength_judgmt_type,le.avelength_judgmt_disposition_date,le.avelength_judgmt_disposition_code,le.avelength_judgmt_disposition,le.avelength_disposition_code,le.avelength_disposition_description,le.avelength_disposition_date,le.avelength_suit_amount,le.avelength_award_amount);
END;
EXPORT invSummary := NORMALIZE(summary0, 34, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.parent_case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.case_type_code),TRIM((SALT39.StrType)le.case_type),TRIM((SALT39.StrType)le.case_title),TRIM((SALT39.StrType)le.case_cause_code),TRIM((SALT39.StrType)le.case_cause),TRIM((SALT39.StrType)le.manner_of_filing_code),TRIM((SALT39.StrType)le.manner_of_filing),TRIM((SALT39.StrType)le.filing_date),TRIM((SALT39.StrType)le.manner_of_judgmt_code),TRIM((SALT39.StrType)le.manner_of_judgmt),TRIM((SALT39.StrType)le.judgmt_date),TRIM((SALT39.StrType)le.ruled_for_against_code),TRIM((SALT39.StrType)le.ruled_for_against),TRIM((SALT39.StrType)le.judgmt_type_code),TRIM((SALT39.StrType)le.judgmt_type),TRIM((SALT39.StrType)le.judgmt_disposition_date),TRIM((SALT39.StrType)le.judgmt_disposition_code),TRIM((SALT39.StrType)le.judgmt_disposition),TRIM((SALT39.StrType)le.disposition_code),TRIM((SALT39.StrType)le.disposition_description),TRIM((SALT39.StrType)le.disposition_date),TRIM((SALT39.StrType)le.suit_amount),TRIM((SALT39.StrType)le.award_amount)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,34,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 34);
  SELF.FldNo2 := 1 + (C % 34);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.parent_case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.case_type_code),TRIM((SALT39.StrType)le.case_type),TRIM((SALT39.StrType)le.case_title),TRIM((SALT39.StrType)le.case_cause_code),TRIM((SALT39.StrType)le.case_cause),TRIM((SALT39.StrType)le.manner_of_filing_code),TRIM((SALT39.StrType)le.manner_of_filing),TRIM((SALT39.StrType)le.filing_date),TRIM((SALT39.StrType)le.manner_of_judgmt_code),TRIM((SALT39.StrType)le.manner_of_judgmt),TRIM((SALT39.StrType)le.judgmt_date),TRIM((SALT39.StrType)le.ruled_for_against_code),TRIM((SALT39.StrType)le.ruled_for_against),TRIM((SALT39.StrType)le.judgmt_type_code),TRIM((SALT39.StrType)le.judgmt_type),TRIM((SALT39.StrType)le.judgmt_disposition_date),TRIM((SALT39.StrType)le.judgmt_disposition_code),TRIM((SALT39.StrType)le.judgmt_disposition),TRIM((SALT39.StrType)le.disposition_code),TRIM((SALT39.StrType)le.disposition_description),TRIM((SALT39.StrType)le.disposition_date),TRIM((SALT39.StrType)le.suit_amount),TRIM((SALT39.StrType)le.award_amount)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.parent_case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.case_type_code),TRIM((SALT39.StrType)le.case_type),TRIM((SALT39.StrType)le.case_title),TRIM((SALT39.StrType)le.case_cause_code),TRIM((SALT39.StrType)le.case_cause),TRIM((SALT39.StrType)le.manner_of_filing_code),TRIM((SALT39.StrType)le.manner_of_filing),TRIM((SALT39.StrType)le.filing_date),TRIM((SALT39.StrType)le.manner_of_judgmt_code),TRIM((SALT39.StrType)le.manner_of_judgmt),TRIM((SALT39.StrType)le.judgmt_date),TRIM((SALT39.StrType)le.ruled_for_against_code),TRIM((SALT39.StrType)le.ruled_for_against),TRIM((SALT39.StrType)le.judgmt_type_code),TRIM((SALT39.StrType)le.judgmt_type),TRIM((SALT39.StrType)le.judgmt_disposition_date),TRIM((SALT39.StrType)le.judgmt_disposition_code),TRIM((SALT39.StrType)le.judgmt_disposition),TRIM((SALT39.StrType)le.disposition_code),TRIM((SALT39.StrType)le.disposition_description),TRIM((SALT39.StrType)le.disposition_date),TRIM((SALT39.StrType)le.suit_amount),TRIM((SALT39.StrType)le.award_amount)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),34*34,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_reported'}
      ,{2,'dt_last_reported'}
      ,{3,'process_date'}
      ,{4,'vendor'}
      ,{5,'state_origin'}
      ,{6,'source_file'}
      ,{7,'case_key'}
      ,{8,'parent_case_key'}
      ,{9,'court_code'}
      ,{10,'court'}
      ,{11,'case_number'}
      ,{12,'case_type_code'}
      ,{13,'case_type'}
      ,{14,'case_title'}
      ,{15,'case_cause_code'}
      ,{16,'case_cause'}
      ,{17,'manner_of_filing_code'}
      ,{18,'manner_of_filing'}
      ,{19,'filing_date'}
      ,{20,'manner_of_judgmt_code'}
      ,{21,'manner_of_judgmt'}
      ,{22,'judgmt_date'}
      ,{23,'ruled_for_against_code'}
      ,{24,'ruled_for_against'}
      ,{25,'judgmt_type_code'}
      ,{26,'judgmt_type'}
      ,{27,'judgmt_disposition_date'}
      ,{28,'judgmt_disposition_code'}
      ,{29,'judgmt_disposition'}
      ,{30,'disposition_code'}
      ,{31,'disposition_description'}
      ,{32,'disposition_date'}
      ,{33,'suit_amount'}
      ,{34,'award_amount'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_reported((SALT39.StrType)le.dt_first_reported),
    Fields.InValid_dt_last_reported((SALT39.StrType)le.dt_last_reported),
    Fields.InValid_process_date((SALT39.StrType)le.process_date),
    Fields.InValid_vendor((SALT39.StrType)le.vendor),
    Fields.InValid_state_origin((SALT39.StrType)le.state_origin),
    Fields.InValid_source_file((SALT39.StrType)le.source_file),
    Fields.InValid_case_key((SALT39.StrType)le.case_key),
    Fields.InValid_parent_case_key((SALT39.StrType)le.parent_case_key),
    Fields.InValid_court_code((SALT39.StrType)le.court_code),
    Fields.InValid_court((SALT39.StrType)le.court),
    Fields.InValid_case_number((SALT39.StrType)le.case_number),
    Fields.InValid_case_type_code((SALT39.StrType)le.case_type_code),
    Fields.InValid_case_type((SALT39.StrType)le.case_type),
    Fields.InValid_case_title((SALT39.StrType)le.case_title),
    Fields.InValid_case_cause_code((SALT39.StrType)le.case_cause_code),
    Fields.InValid_case_cause((SALT39.StrType)le.case_cause),
    Fields.InValid_manner_of_filing_code((SALT39.StrType)le.manner_of_filing_code),
    Fields.InValid_manner_of_filing((SALT39.StrType)le.manner_of_filing),
    Fields.InValid_filing_date((SALT39.StrType)le.filing_date),
    Fields.InValid_manner_of_judgmt_code((SALT39.StrType)le.manner_of_judgmt_code),
    Fields.InValid_manner_of_judgmt((SALT39.StrType)le.manner_of_judgmt),
    Fields.InValid_judgmt_date((SALT39.StrType)le.judgmt_date),
    Fields.InValid_ruled_for_against_code((SALT39.StrType)le.ruled_for_against_code),
    Fields.InValid_ruled_for_against((SALT39.StrType)le.ruled_for_against),
    Fields.InValid_judgmt_type_code((SALT39.StrType)le.judgmt_type_code),
    Fields.InValid_judgmt_type((SALT39.StrType)le.judgmt_type),
    Fields.InValid_judgmt_disposition_date((SALT39.StrType)le.judgmt_disposition_date),
    Fields.InValid_judgmt_disposition_code((SALT39.StrType)le.judgmt_disposition_code),
    Fields.InValid_judgmt_disposition((SALT39.StrType)le.judgmt_disposition),
    Fields.InValid_disposition_code((SALT39.StrType)le.disposition_code),
    Fields.InValid_disposition_description((SALT39.StrType)le.disposition_description),
    Fields.InValid_disposition_date((SALT39.StrType)le.disposition_date),
    Fields.InValid_suit_amount((SALT39.StrType)le.suit_amount),
    Fields.InValid_award_amount((SALT39.StrType)le.award_amount),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,34,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Fields.InValidMessage_case_key(TotalErrors.ErrorNum),Fields.InValidMessage_parent_case_key(TotalErrors.ErrorNum),Fields.InValidMessage_court_code(TotalErrors.ErrorNum),Fields.InValidMessage_court(TotalErrors.ErrorNum),Fields.InValidMessage_case_number(TotalErrors.ErrorNum),Fields.InValidMessage_case_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_case_type(TotalErrors.ErrorNum),Fields.InValidMessage_case_title(TotalErrors.ErrorNum),Fields.InValidMessage_case_cause_code(TotalErrors.ErrorNum),Fields.InValidMessage_case_cause(TotalErrors.ErrorNum),Fields.InValidMessage_manner_of_filing_code(TotalErrors.ErrorNum),Fields.InValidMessage_manner_of_filing(TotalErrors.ErrorNum),Fields.InValidMessage_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_manner_of_judgmt_code(TotalErrors.ErrorNum),Fields.InValidMessage_manner_of_judgmt(TotalErrors.ErrorNum),Fields.InValidMessage_judgmt_date(TotalErrors.ErrorNum),Fields.InValidMessage_ruled_for_against_code(TotalErrors.ErrorNum),Fields.InValidMessage_ruled_for_against(TotalErrors.ErrorNum),Fields.InValidMessage_judgmt_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_judgmt_type(TotalErrors.ErrorNum),Fields.InValidMessage_judgmt_disposition_date(TotalErrors.ErrorNum),Fields.InValidMessage_judgmt_disposition_code(TotalErrors.ErrorNum),Fields.InValidMessage_judgmt_disposition(TotalErrors.ErrorNum),Fields.InValidMessage_disposition_code(TotalErrors.ErrorNum),Fields.InValidMessage_disposition_description(TotalErrors.ErrorNum),Fields.InValidMessage_disposition_date(TotalErrors.ErrorNum),Fields.InValidMessage_suit_amount(TotalErrors.ErrorNum),Fields.InValidMessage_award_amount(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Civil_Court, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
