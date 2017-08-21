IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Scrubs_Corp2_Build_Stock_Base.in_file) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_vendor_county_pcnt := AVE(GROUP,IF(h.corp_vendor_county = (TYPEOF(h.corp_vendor_county))'',0,100));
    maxlength_corp_vendor_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor_county)));
    avelength_corp_vendor_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor_county)),h.corp_vendor_county<>(typeof(h.corp_vendor_county))'');
    populated_corp_vendor_subcode_pcnt := AVE(GROUP,IF(h.corp_vendor_subcode = (TYPEOF(h.corp_vendor_subcode))'',0,100));
    maxlength_corp_vendor_subcode := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor_subcode)));
    avelength_corp_vendor_subcode := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_vendor_subcode)),h.corp_vendor_subcode<>(typeof(h.corp_vendor_subcode))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_sos_charter_nbr = (TYPEOF(h.corp_sos_charter_nbr))'',0,100));
    maxlength_corp_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_sos_charter_nbr)));
    avelength_corp_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corp_sos_charter_nbr)),h.corp_sos_charter_nbr<>(typeof(h.corp_sos_charter_nbr))'');
    populated_stock_ticker_symbol_pcnt := AVE(GROUP,IF(h.stock_ticker_symbol = (TYPEOF(h.stock_ticker_symbol))'',0,100));
    maxlength_stock_ticker_symbol := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_ticker_symbol)));
    avelength_stock_ticker_symbol := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_ticker_symbol)),h.stock_ticker_symbol<>(typeof(h.stock_ticker_symbol))'');
    populated_stock_exchange_pcnt := AVE(GROUP,IF(h.stock_exchange = (TYPEOF(h.stock_exchange))'',0,100));
    maxlength_stock_exchange := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_exchange)));
    avelength_stock_exchange := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_exchange)),h.stock_exchange<>(typeof(h.stock_exchange))'');
    populated_stock_type_pcnt := AVE(GROUP,IF(h.stock_type = (TYPEOF(h.stock_type))'',0,100));
    maxlength_stock_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_type)));
    avelength_stock_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_type)),h.stock_type<>(typeof(h.stock_type))'');
    populated_stock_class_pcnt := AVE(GROUP,IF(h.stock_class = (TYPEOF(h.stock_class))'',0,100));
    maxlength_stock_class := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_class)));
    avelength_stock_class := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_class)),h.stock_class<>(typeof(h.stock_class))'');
    populated_stock_shares_issued_pcnt := AVE(GROUP,IF(h.stock_shares_issued = (TYPEOF(h.stock_shares_issued))'',0,100));
    maxlength_stock_shares_issued := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_shares_issued)));
    avelength_stock_shares_issued := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_shares_issued)),h.stock_shares_issued<>(typeof(h.stock_shares_issued))'');
    populated_stock_authorized_nbr_pcnt := AVE(GROUP,IF(h.stock_authorized_nbr = (TYPEOF(h.stock_authorized_nbr))'',0,100));
    maxlength_stock_authorized_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_authorized_nbr)));
    avelength_stock_authorized_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_authorized_nbr)),h.stock_authorized_nbr<>(typeof(h.stock_authorized_nbr))'');
    populated_stock_par_value_pcnt := AVE(GROUP,IF(h.stock_par_value = (TYPEOF(h.stock_par_value))'',0,100));
    maxlength_stock_par_value := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_par_value)));
    avelength_stock_par_value := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_par_value)),h.stock_par_value<>(typeof(h.stock_par_value))'');
    populated_stock_nbr_par_shares_pcnt := AVE(GROUP,IF(h.stock_nbr_par_shares = (TYPEOF(h.stock_nbr_par_shares))'',0,100));
    maxlength_stock_nbr_par_shares := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_nbr_par_shares)));
    avelength_stock_nbr_par_shares := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_nbr_par_shares)),h.stock_nbr_par_shares<>(typeof(h.stock_nbr_par_shares))'');
    populated_stock_change_ind_pcnt := AVE(GROUP,IF(h.stock_change_ind = (TYPEOF(h.stock_change_ind))'',0,100));
    maxlength_stock_change_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_change_ind)));
    avelength_stock_change_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_change_ind)),h.stock_change_ind<>(typeof(h.stock_change_ind))'');
    populated_stock_change_date_pcnt := AVE(GROUP,IF(h.stock_change_date = (TYPEOF(h.stock_change_date))'',0,100));
    maxlength_stock_change_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_change_date)));
    avelength_stock_change_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_change_date)),h.stock_change_date<>(typeof(h.stock_change_date))'');
    populated_stock_voting_rights_ind_pcnt := AVE(GROUP,IF(h.stock_voting_rights_ind = (TYPEOF(h.stock_voting_rights_ind))'',0,100));
    maxlength_stock_voting_rights_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_voting_rights_ind)));
    avelength_stock_voting_rights_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_voting_rights_ind)),h.stock_voting_rights_ind<>(typeof(h.stock_voting_rights_ind))'');
    populated_stock_convert_ind_pcnt := AVE(GROUP,IF(h.stock_convert_ind = (TYPEOF(h.stock_convert_ind))'',0,100));
    maxlength_stock_convert_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_convert_ind)));
    avelength_stock_convert_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_convert_ind)),h.stock_convert_ind<>(typeof(h.stock_convert_ind))'');
    populated_stock_convert_date_pcnt := AVE(GROUP,IF(h.stock_convert_date = (TYPEOF(h.stock_convert_date))'',0,100));
    maxlength_stock_convert_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_convert_date)));
    avelength_stock_convert_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_convert_date)),h.stock_convert_date<>(typeof(h.stock_convert_date))'');
    populated_stock_change_in_cap_pcnt := AVE(GROUP,IF(h.stock_change_in_cap = (TYPEOF(h.stock_change_in_cap))'',0,100));
    maxlength_stock_change_in_cap := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_change_in_cap)));
    avelength_stock_change_in_cap := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_change_in_cap)),h.stock_change_in_cap<>(typeof(h.stock_change_in_cap))'');
    populated_stock_tax_capital_pcnt := AVE(GROUP,IF(h.stock_tax_capital = (TYPEOF(h.stock_tax_capital))'',0,100));
    maxlength_stock_tax_capital := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_tax_capital)));
    avelength_stock_tax_capital := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_tax_capital)),h.stock_tax_capital<>(typeof(h.stock_tax_capital))'');
    populated_stock_total_capital_pcnt := AVE(GROUP,IF(h.stock_total_capital = (TYPEOF(h.stock_total_capital))'',0,100));
    maxlength_stock_total_capital := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_total_capital)));
    avelength_stock_total_capital := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_total_capital)),h.stock_total_capital<>(typeof(h.stock_total_capital))'');
    populated_stock_addl_info_pcnt := AVE(GROUP,IF(h.stock_addl_info = (TYPEOF(h.stock_addl_info))'',0,100));
    maxlength_stock_addl_info := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_addl_info)));
    avelength_stock_addl_info := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.stock_addl_info)),h.stock_addl_info<>(typeof(h.stock_addl_info))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_vendor_county_pcnt *   0.00 / 100 + T.Populated_corp_vendor_subcode_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_stock_ticker_symbol_pcnt *   0.00 / 100 + T.Populated_stock_exchange_pcnt *   0.00 / 100 + T.Populated_stock_type_pcnt *   0.00 / 100 + T.Populated_stock_class_pcnt *   0.00 / 100 + T.Populated_stock_shares_issued_pcnt *   0.00 / 100 + T.Populated_stock_authorized_nbr_pcnt *   0.00 / 100 + T.Populated_stock_par_value_pcnt *   0.00 / 100 + T.Populated_stock_nbr_par_shares_pcnt *   0.00 / 100 + T.Populated_stock_change_ind_pcnt *   0.00 / 100 + T.Populated_stock_change_date_pcnt *   0.00 / 100 + T.Populated_stock_voting_rights_ind_pcnt *   0.00 / 100 + T.Populated_stock_convert_ind_pcnt *   0.00 / 100 + T.Populated_stock_convert_date_pcnt *   0.00 / 100 + T.Populated_stock_change_in_cap_pcnt *   0.00 / 100 + T.Populated_stock_tax_capital_pcnt *   0.00 / 100 + T.Populated_stock_total_capital_pcnt *   0.00 / 100 + T.Populated_stock_addl_info_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'bdid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','stock_ticker_symbol','stock_exchange','stock_type','stock_class','stock_shares_issued','stock_authorized_nbr','stock_par_value','stock_nbr_par_shares','stock_change_ind','stock_change_date','stock_voting_rights_ind','stock_convert_ind','stock_convert_date','stock_change_in_cap','stock_tax_capital','stock_total_capital','stock_addl_info','record_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_bdid_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_corp_key_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_vendor_county_pcnt,le.populated_corp_vendor_subcode_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_sos_charter_nbr_pcnt,le.populated_stock_ticker_symbol_pcnt,le.populated_stock_exchange_pcnt,le.populated_stock_type_pcnt,le.populated_stock_class_pcnt,le.populated_stock_shares_issued_pcnt,le.populated_stock_authorized_nbr_pcnt,le.populated_stock_par_value_pcnt,le.populated_stock_nbr_par_shares_pcnt,le.populated_stock_change_ind_pcnt,le.populated_stock_change_date_pcnt,le.populated_stock_voting_rights_ind_pcnt,le.populated_stock_convert_ind_pcnt,le.populated_stock_convert_date_pcnt,le.populated_stock_change_in_cap_pcnt,le.populated_stock_tax_capital_pcnt,le.populated_stock_total_capital_pcnt,le.populated_stock_addl_info_pcnt,le.populated_record_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_bdid,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_corp_key,le.maxlength_corp_vendor,le.maxlength_corp_vendor_county,le.maxlength_corp_vendor_subcode,le.maxlength_corp_state_origin,le.maxlength_corp_process_date,le.maxlength_corp_sos_charter_nbr,le.maxlength_stock_ticker_symbol,le.maxlength_stock_exchange,le.maxlength_stock_type,le.maxlength_stock_class,le.maxlength_stock_shares_issued,le.maxlength_stock_authorized_nbr,le.maxlength_stock_par_value,le.maxlength_stock_nbr_par_shares,le.maxlength_stock_change_ind,le.maxlength_stock_change_date,le.maxlength_stock_voting_rights_ind,le.maxlength_stock_convert_ind,le.maxlength_stock_convert_date,le.maxlength_stock_change_in_cap,le.maxlength_stock_tax_capital,le.maxlength_stock_total_capital,le.maxlength_stock_addl_info,le.maxlength_record_type);
  SELF.avelength := CHOOSE(C,le.avelength_bdid,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_corp_key,le.avelength_corp_vendor,le.avelength_corp_vendor_county,le.avelength_corp_vendor_subcode,le.avelength_corp_state_origin,le.avelength_corp_process_date,le.avelength_corp_sos_charter_nbr,le.avelength_stock_ticker_symbol,le.avelength_stock_exchange,le.avelength_stock_type,le.avelength_stock_class,le.avelength_stock_shares_issued,le.avelength_stock_authorized_nbr,le.avelength_stock_par_value,le.avelength_stock_nbr_par_shares,le.avelength_stock_change_ind,le.avelength_stock_change_date,le.avelength_stock_voting_rights_ind,le.avelength_stock_convert_ind,le.avelength_stock_convert_date,le.avelength_stock_change_in_cap,le.avelength_stock_tax_capital,le.avelength_stock_total_capital,le.avelength_stock_addl_info,le.avelength_record_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 30, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.stock_ticker_symbol),TRIM((SALT30.StrType)le.stock_exchange),TRIM((SALT30.StrType)le.stock_type),TRIM((SALT30.StrType)le.stock_class),TRIM((SALT30.StrType)le.stock_shares_issued),TRIM((SALT30.StrType)le.stock_authorized_nbr),TRIM((SALT30.StrType)le.stock_par_value),TRIM((SALT30.StrType)le.stock_nbr_par_shares),TRIM((SALT30.StrType)le.stock_change_ind),TRIM((SALT30.StrType)le.stock_change_date),TRIM((SALT30.StrType)le.stock_voting_rights_ind),TRIM((SALT30.StrType)le.stock_convert_ind),TRIM((SALT30.StrType)le.stock_convert_date),TRIM((SALT30.StrType)le.stock_change_in_cap),TRIM((SALT30.StrType)le.stock_tax_capital),TRIM((SALT30.StrType)le.stock_total_capital),TRIM((SALT30.StrType)le.stock_addl_info),TRIM((SALT30.StrType)le.record_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,30,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 30);
  SELF.FldNo2 := 1 + (C % 30);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.stock_ticker_symbol),TRIM((SALT30.StrType)le.stock_exchange),TRIM((SALT30.StrType)le.stock_type),TRIM((SALT30.StrType)le.stock_class),TRIM((SALT30.StrType)le.stock_shares_issued),TRIM((SALT30.StrType)le.stock_authorized_nbr),TRIM((SALT30.StrType)le.stock_par_value),TRIM((SALT30.StrType)le.stock_nbr_par_shares),TRIM((SALT30.StrType)le.stock_change_ind),TRIM((SALT30.StrType)le.stock_change_date),TRIM((SALT30.StrType)le.stock_voting_rights_ind),TRIM((SALT30.StrType)le.stock_convert_ind),TRIM((SALT30.StrType)le.stock_convert_date),TRIM((SALT30.StrType)le.stock_change_in_cap),TRIM((SALT30.StrType)le.stock_tax_capital),TRIM((SALT30.StrType)le.stock_total_capital),TRIM((SALT30.StrType)le.stock_addl_info),TRIM((SALT30.StrType)le.record_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.corp_key),TRIM((SALT30.StrType)le.corp_vendor),TRIM((SALT30.StrType)le.corp_vendor_county),TRIM((SALT30.StrType)le.corp_vendor_subcode),TRIM((SALT30.StrType)le.corp_state_origin),TRIM((SALT30.StrType)le.corp_process_date),TRIM((SALT30.StrType)le.corp_sos_charter_nbr),TRIM((SALT30.StrType)le.stock_ticker_symbol),TRIM((SALT30.StrType)le.stock_exchange),TRIM((SALT30.StrType)le.stock_type),TRIM((SALT30.StrType)le.stock_class),TRIM((SALT30.StrType)le.stock_shares_issued),TRIM((SALT30.StrType)le.stock_authorized_nbr),TRIM((SALT30.StrType)le.stock_par_value),TRIM((SALT30.StrType)le.stock_nbr_par_shares),TRIM((SALT30.StrType)le.stock_change_ind),TRIM((SALT30.StrType)le.stock_change_date),TRIM((SALT30.StrType)le.stock_voting_rights_ind),TRIM((SALT30.StrType)le.stock_convert_ind),TRIM((SALT30.StrType)le.stock_convert_date),TRIM((SALT30.StrType)le.stock_change_in_cap),TRIM((SALT30.StrType)le.stock_tax_capital),TRIM((SALT30.StrType)le.stock_total_capital),TRIM((SALT30.StrType)le.stock_addl_info),TRIM((SALT30.StrType)le.record_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),30*30,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'bdid'}
      ,{2,'dt_first_seen'}
      ,{3,'dt_last_seen'}
      ,{4,'dt_vendor_first_reported'}
      ,{5,'dt_vendor_last_reported'}
      ,{6,'corp_key'}
      ,{7,'corp_vendor'}
      ,{8,'corp_vendor_county'}
      ,{9,'corp_vendor_subcode'}
      ,{10,'corp_state_origin'}
      ,{11,'corp_process_date'}
      ,{12,'corp_sos_charter_nbr'}
      ,{13,'stock_ticker_symbol'}
      ,{14,'stock_exchange'}
      ,{15,'stock_type'}
      ,{16,'stock_class'}
      ,{17,'stock_shares_issued'}
      ,{18,'stock_authorized_nbr'}
      ,{19,'stock_par_value'}
      ,{20,'stock_nbr_par_shares'}
      ,{21,'stock_change_ind'}
      ,{22,'stock_change_date'}
      ,{23,'stock_voting_rights_ind'}
      ,{24,'stock_convert_ind'}
      ,{25,'stock_convert_date'}
      ,{26,'stock_change_in_cap'}
      ,{27,'stock_tax_capital'}
      ,{28,'stock_total_capital'}
      ,{29,'stock_addl_info'}
      ,{30,'record_type'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_bdid((SALT30.StrType)le.bdid),
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT30.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT30.StrType)le.dt_vendor_last_reported),
    Fields.InValid_corp_key((SALT30.StrType)le.corp_key),
    Fields.InValid_corp_vendor((SALT30.StrType)le.corp_vendor),
    Fields.InValid_corp_vendor_county((SALT30.StrType)le.corp_vendor_county),
    Fields.InValid_corp_vendor_subcode((SALT30.StrType)le.corp_vendor_subcode),
    Fields.InValid_corp_state_origin((SALT30.StrType)le.corp_state_origin),
    Fields.InValid_corp_process_date((SALT30.StrType)le.corp_process_date),
    Fields.InValid_corp_sos_charter_nbr((SALT30.StrType)le.corp_sos_charter_nbr),
    Fields.InValid_stock_ticker_symbol((SALT30.StrType)le.stock_ticker_symbol),
    Fields.InValid_stock_exchange((SALT30.StrType)le.stock_exchange),
    Fields.InValid_stock_type((SALT30.StrType)le.stock_type),
    Fields.InValid_stock_class((SALT30.StrType)le.stock_class),
    Fields.InValid_stock_shares_issued((SALT30.StrType)le.stock_shares_issued),
    Fields.InValid_stock_authorized_nbr((SALT30.StrType)le.stock_authorized_nbr),
    Fields.InValid_stock_par_value((SALT30.StrType)le.stock_par_value),
    Fields.InValid_stock_nbr_par_shares((SALT30.StrType)le.stock_nbr_par_shares),
    Fields.InValid_stock_change_ind((SALT30.StrType)le.stock_change_ind),
    Fields.InValid_stock_change_date((SALT30.StrType)le.stock_change_date),
    Fields.InValid_stock_voting_rights_ind((SALT30.StrType)le.stock_voting_rights_ind),
    Fields.InValid_stock_convert_ind((SALT30.StrType)le.stock_convert_ind),
    Fields.InValid_stock_convert_date((SALT30.StrType)le.stock_convert_date),
    Fields.InValid_stock_change_in_cap((SALT30.StrType)le.stock_change_in_cap),
    Fields.InValid_stock_tax_capital((SALT30.StrType)le.stock_tax_capital),
    Fields.InValid_stock_total_capital((SALT30.StrType)le.stock_total_capital),
    Fields.InValid_stock_addl_info((SALT30.StrType)le.stock_addl_info),
    Fields.InValid_record_type((SALT30.StrType)le.record_type),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,30,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','invalid_corp_key','invalid_corp_vendor','Unknown','Unknown','invalid_state_origin','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_subcode(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_stock_ticker_symbol(TotalErrors.ErrorNum),Fields.InValidMessage_stock_exchange(TotalErrors.ErrorNum),Fields.InValidMessage_stock_type(TotalErrors.ErrorNum),Fields.InValidMessage_stock_class(TotalErrors.ErrorNum),Fields.InValidMessage_stock_shares_issued(TotalErrors.ErrorNum),Fields.InValidMessage_stock_authorized_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_stock_par_value(TotalErrors.ErrorNum),Fields.InValidMessage_stock_nbr_par_shares(TotalErrors.ErrorNum),Fields.InValidMessage_stock_change_ind(TotalErrors.ErrorNum),Fields.InValidMessage_stock_change_date(TotalErrors.ErrorNum),Fields.InValidMessage_stock_voting_rights_ind(TotalErrors.ErrorNum),Fields.InValidMessage_stock_convert_ind(TotalErrors.ErrorNum),Fields.InValidMessage_stock_convert_date(TotalErrors.ErrorNum),Fields.InValidMessage_stock_change_in_cap(TotalErrors.ErrorNum),Fields.InValidMessage_stock_tax_capital(TotalErrors.ErrorNum),Fields.InValidMessage_stock_total_capital(TotalErrors.ErrorNum),Fields.InValidMessage_stock_addl_info(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
