IMPORT ut,SALT30;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_mandatory','invalid_date','invalid_future_date','invalid_charter_nbr','invalid_Y_N','invalid_numeric');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_corp_key' => 1,'invalid_corp_vendor' => 2,'invalid_state_origin' => 3,'invalid_mandatory' => 4,'invalid_date' => 5,'invalid_future_date' => 6,'invalid_charter_nbr' => 7,'invalid_Y_N' => 8,'invalid_numeric' => 9,0);
 
EXPORT MakeFT_invalid_corp_key(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'-0123456789'))),~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('-0123456789'),SALT30.HygieneErrors.NotLength('4..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['20']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('20'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['KS']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('KS'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_future_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_future_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0);
EXPORT InValidMessageFT_invalid_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter_nbr(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter_nbr(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_charter_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Y_N(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Y_N(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['Y','N']);
EXPORT InValidMessageFT_invalid_Y_N(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('Y|N'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.Good);
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','stock_ticker_symbol','stock_exchange','stock_type','stock_class','stock_shares_issued','stock_authorized_nbr','stock_par_value','stock_nbr_par_shares','stock_change_ind','stock_change_date','stock_voting_rights_ind','stock_convert_ind','stock_convert_date','stock_change_in_cap','stock_tax_capital','stock_total_capital','stock_addl_info','stock_stock_description','stock_stock_series','stock_non_par_value_flag','stock_additional_stock','stock_shares_proportion_to_ohio_for_foreign_license','stock_share_credits','stock_authorized_capital','stock_stock_paid_in_capital','stock_pay_higher_stock_fees','stock_actual_amt_invested_in_state','stock_share_exchange_during_merger','stock_date_stock_limit_approved','stock_number_of_shares_paid_for','stock_total_value_of_shares_paid_for','stock_sharesofbeneficialinterest','stock_beneficialsharevalue');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'corp_key' => 1,'corp_vendor' => 2,'corp_vendor_county' => 3,'corp_vendor_subcode' => 4,'corp_state_origin' => 5,'corp_process_date' => 6,'corp_sos_charter_nbr' => 7,'stock_ticker_symbol' => 8,'stock_exchange' => 9,'stock_type' => 10,'stock_class' => 11,'stock_shares_issued' => 12,'stock_authorized_nbr' => 13,'stock_par_value' => 14,'stock_nbr_par_shares' => 15,'stock_change_ind' => 16,'stock_change_date' => 17,'stock_voting_rights_ind' => 18,'stock_convert_ind' => 19,'stock_convert_date' => 20,'stock_change_in_cap' => 21,'stock_tax_capital' => 22,'stock_total_capital' => 23,'stock_addl_info' => 24,'stock_stock_description' => 25,'stock_stock_series' => 26,'stock_non_par_value_flag' => 27,'stock_additional_stock' => 28,'stock_shares_proportion_to_ohio_for_foreign_license' => 29,'stock_share_credits' => 30,'stock_authorized_capital' => 31,'stock_stock_paid_in_capital' => 32,'stock_pay_higher_stock_fees' => 33,'stock_actual_amt_invested_in_state' => 34,'stock_share_exchange_during_merger' => 35,'stock_date_stock_limit_approved' => 36,'stock_number_of_shares_paid_for' => 37,'stock_total_value_of_shares_paid_for' => 38,'stock_sharesofbeneficialinterest' => 39,'stock_beneficialsharevalue' => 40,0);
 
//Individual field level validation
 
EXPORT Make_corp_key(SALT30.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT30.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_vendor(SALT30.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT30.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_vendor_county(SALT30.StrType s0) := s0;
EXPORT InValid_corp_vendor_county(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_vendor_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_vendor_subcode(SALT30.StrType s0) := s0;
EXPORT InValid_corp_vendor_subcode(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_vendor_subcode(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_state_origin(SALT30.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT30.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_process_date(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_sos_charter_nbr(SALT30.StrType s0) := MakeFT_invalid_charter_nbr(s0);
EXPORT InValid_corp_sos_charter_nbr(SALT30.StrType s) := InValidFT_invalid_charter_nbr(s);
EXPORT InValidMessage_corp_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter_nbr(wh);
 
EXPORT Make_stock_ticker_symbol(SALT30.StrType s0) := s0;
EXPORT InValid_stock_ticker_symbol(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_ticker_symbol(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_exchange(SALT30.StrType s0) := s0;
EXPORT InValid_stock_exchange(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_exchange(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_type(SALT30.StrType s0) := s0;
EXPORT InValid_stock_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_type(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_class(SALT30.StrType s0) := s0;
EXPORT InValid_stock_class(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_class(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_shares_issued(SALT30.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_stock_shares_issued(SALT30.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_stock_shares_issued(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_stock_authorized_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_stock_authorized_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_authorized_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_par_value(SALT30.StrType s0) := s0;
EXPORT InValid_stock_par_value(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_par_value(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_nbr_par_shares(SALT30.StrType s0) := s0;
EXPORT InValid_stock_nbr_par_shares(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_nbr_par_shares(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_change_ind(SALT30.StrType s0) := s0;
EXPORT InValid_stock_change_ind(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_change_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_change_date(SALT30.StrType s0) := s0;
EXPORT InValid_stock_change_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_change_date(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_voting_rights_ind(SALT30.StrType s0) := s0;
EXPORT InValid_stock_voting_rights_ind(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_voting_rights_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_convert_ind(SALT30.StrType s0) := s0;
EXPORT InValid_stock_convert_ind(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_convert_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_convert_date(SALT30.StrType s0) := s0;
EXPORT InValid_stock_convert_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_convert_date(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_change_in_cap(SALT30.StrType s0) := s0;
EXPORT InValid_stock_change_in_cap(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_change_in_cap(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_tax_capital(SALT30.StrType s0) := s0;
EXPORT InValid_stock_tax_capital(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_tax_capital(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_total_capital(SALT30.StrType s0) := s0;
EXPORT InValid_stock_total_capital(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_total_capital(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_addl_info(SALT30.StrType s0) := s0;
EXPORT InValid_stock_addl_info(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_addl_info(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_stock_description(SALT30.StrType s0) := s0;
EXPORT InValid_stock_stock_description(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_stock_description(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_stock_series(SALT30.StrType s0) := s0;
EXPORT InValid_stock_stock_series(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_stock_series(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_non_par_value_flag(SALT30.StrType s0) := s0;
EXPORT InValid_stock_non_par_value_flag(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_non_par_value_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_additional_stock(SALT30.StrType s0) := s0;
EXPORT InValid_stock_additional_stock(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_additional_stock(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_shares_proportion_to_ohio_for_foreign_license(SALT30.StrType s0) := s0;
EXPORT InValid_stock_shares_proportion_to_ohio_for_foreign_license(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_shares_proportion_to_ohio_for_foreign_license(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_share_credits(SALT30.StrType s0) := s0;
EXPORT InValid_stock_share_credits(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_share_credits(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_authorized_capital(SALT30.StrType s0) := s0;
EXPORT InValid_stock_authorized_capital(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_authorized_capital(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_stock_paid_in_capital(SALT30.StrType s0) := s0;
EXPORT InValid_stock_stock_paid_in_capital(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_stock_paid_in_capital(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_pay_higher_stock_fees(SALT30.StrType s0) := s0;
EXPORT InValid_stock_pay_higher_stock_fees(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_pay_higher_stock_fees(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_actual_amt_invested_in_state(SALT30.StrType s0) := s0;
EXPORT InValid_stock_actual_amt_invested_in_state(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_actual_amt_invested_in_state(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_share_exchange_during_merger(SALT30.StrType s0) := s0;
EXPORT InValid_stock_share_exchange_during_merger(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_share_exchange_during_merger(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_date_stock_limit_approved(SALT30.StrType s0) := s0;
EXPORT InValid_stock_date_stock_limit_approved(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_date_stock_limit_approved(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_number_of_shares_paid_for(SALT30.StrType s0) := s0;
EXPORT InValid_stock_number_of_shares_paid_for(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_number_of_shares_paid_for(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_total_value_of_shares_paid_for(SALT30.StrType s0) := s0;
EXPORT InValid_stock_total_value_of_shares_paid_for(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_total_value_of_shares_paid_for(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_sharesofbeneficialinterest(SALT30.StrType s0) := s0;
EXPORT InValid_stock_sharesofbeneficialinterest(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_sharesofbeneficialinterest(UNSIGNED1 wh) := '';
 
EXPORT Make_stock_beneficialsharevalue(SALT30.StrType s0) := s0;
EXPORT InValid_stock_beneficialsharevalue(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_beneficialsharevalue(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Mapping_KS_Stock;
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
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_vendor_county;
    BOOLEAN Diff_corp_vendor_subcode;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_sos_charter_nbr;
    BOOLEAN Diff_stock_ticker_symbol;
    BOOLEAN Diff_stock_exchange;
    BOOLEAN Diff_stock_type;
    BOOLEAN Diff_stock_class;
    BOOLEAN Diff_stock_shares_issued;
    BOOLEAN Diff_stock_authorized_nbr;
    BOOLEAN Diff_stock_par_value;
    BOOLEAN Diff_stock_nbr_par_shares;
    BOOLEAN Diff_stock_change_ind;
    BOOLEAN Diff_stock_change_date;
    BOOLEAN Diff_stock_voting_rights_ind;
    BOOLEAN Diff_stock_convert_ind;
    BOOLEAN Diff_stock_convert_date;
    BOOLEAN Diff_stock_change_in_cap;
    BOOLEAN Diff_stock_tax_capital;
    BOOLEAN Diff_stock_total_capital;
    BOOLEAN Diff_stock_addl_info;
    BOOLEAN Diff_stock_stock_description;
    BOOLEAN Diff_stock_stock_series;
    BOOLEAN Diff_stock_non_par_value_flag;
    BOOLEAN Diff_stock_additional_stock;
    BOOLEAN Diff_stock_shares_proportion_to_ohio_for_foreign_license;
    BOOLEAN Diff_stock_share_credits;
    BOOLEAN Diff_stock_authorized_capital;
    BOOLEAN Diff_stock_stock_paid_in_capital;
    BOOLEAN Diff_stock_pay_higher_stock_fees;
    BOOLEAN Diff_stock_actual_amt_invested_in_state;
    BOOLEAN Diff_stock_share_exchange_during_merger;
    BOOLEAN Diff_stock_date_stock_limit_approved;
    BOOLEAN Diff_stock_number_of_shares_paid_for;
    BOOLEAN Diff_stock_total_value_of_shares_paid_for;
    BOOLEAN Diff_stock_sharesofbeneficialinterest;
    BOOLEAN Diff_stock_beneficialsharevalue;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_vendor_county := le.corp_vendor_county <> ri.corp_vendor_county;
    SELF.Diff_corp_vendor_subcode := le.corp_vendor_subcode <> ri.corp_vendor_subcode;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_sos_charter_nbr := le.corp_sos_charter_nbr <> ri.corp_sos_charter_nbr;
    SELF.Diff_stock_ticker_symbol := le.stock_ticker_symbol <> ri.stock_ticker_symbol;
    SELF.Diff_stock_exchange := le.stock_exchange <> ri.stock_exchange;
    SELF.Diff_stock_type := le.stock_type <> ri.stock_type;
    SELF.Diff_stock_class := le.stock_class <> ri.stock_class;
    SELF.Diff_stock_shares_issued := le.stock_shares_issued <> ri.stock_shares_issued;
    SELF.Diff_stock_authorized_nbr := le.stock_authorized_nbr <> ri.stock_authorized_nbr;
    SELF.Diff_stock_par_value := le.stock_par_value <> ri.stock_par_value;
    SELF.Diff_stock_nbr_par_shares := le.stock_nbr_par_shares <> ri.stock_nbr_par_shares;
    SELF.Diff_stock_change_ind := le.stock_change_ind <> ri.stock_change_ind;
    SELF.Diff_stock_change_date := le.stock_change_date <> ri.stock_change_date;
    SELF.Diff_stock_voting_rights_ind := le.stock_voting_rights_ind <> ri.stock_voting_rights_ind;
    SELF.Diff_stock_convert_ind := le.stock_convert_ind <> ri.stock_convert_ind;
    SELF.Diff_stock_convert_date := le.stock_convert_date <> ri.stock_convert_date;
    SELF.Diff_stock_change_in_cap := le.stock_change_in_cap <> ri.stock_change_in_cap;
    SELF.Diff_stock_tax_capital := le.stock_tax_capital <> ri.stock_tax_capital;
    SELF.Diff_stock_total_capital := le.stock_total_capital <> ri.stock_total_capital;
    SELF.Diff_stock_addl_info := le.stock_addl_info <> ri.stock_addl_info;
    SELF.Diff_stock_stock_description := le.stock_stock_description <> ri.stock_stock_description;
    SELF.Diff_stock_stock_series := le.stock_stock_series <> ri.stock_stock_series;
    SELF.Diff_stock_non_par_value_flag := le.stock_non_par_value_flag <> ri.stock_non_par_value_flag;
    SELF.Diff_stock_additional_stock := le.stock_additional_stock <> ri.stock_additional_stock;
    SELF.Diff_stock_shares_proportion_to_ohio_for_foreign_license := le.stock_shares_proportion_to_ohio_for_foreign_license <> ri.stock_shares_proportion_to_ohio_for_foreign_license;
    SELF.Diff_stock_share_credits := le.stock_share_credits <> ri.stock_share_credits;
    SELF.Diff_stock_authorized_capital := le.stock_authorized_capital <> ri.stock_authorized_capital;
    SELF.Diff_stock_stock_paid_in_capital := le.stock_stock_paid_in_capital <> ri.stock_stock_paid_in_capital;
    SELF.Diff_stock_pay_higher_stock_fees := le.stock_pay_higher_stock_fees <> ri.stock_pay_higher_stock_fees;
    SELF.Diff_stock_actual_amt_invested_in_state := le.stock_actual_amt_invested_in_state <> ri.stock_actual_amt_invested_in_state;
    SELF.Diff_stock_share_exchange_during_merger := le.stock_share_exchange_during_merger <> ri.stock_share_exchange_during_merger;
    SELF.Diff_stock_date_stock_limit_approved := le.stock_date_stock_limit_approved <> ri.stock_date_stock_limit_approved;
    SELF.Diff_stock_number_of_shares_paid_for := le.stock_number_of_shares_paid_for <> ri.stock_number_of_shares_paid_for;
    SELF.Diff_stock_total_value_of_shares_paid_for := le.stock_total_value_of_shares_paid_for <> ri.stock_total_value_of_shares_paid_for;
    SELF.Diff_stock_sharesofbeneficialinterest := le.stock_sharesofbeneficialinterest <> ri.stock_sharesofbeneficialinterest;
    SELF.Diff_stock_beneficialsharevalue := le.stock_beneficialsharevalue <> ri.stock_beneficialsharevalue;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_stock_ticker_symbol,1,0)+ IF( SELF.Diff_stock_exchange,1,0)+ IF( SELF.Diff_stock_type,1,0)+ IF( SELF.Diff_stock_class,1,0)+ IF( SELF.Diff_stock_shares_issued,1,0)+ IF( SELF.Diff_stock_authorized_nbr,1,0)+ IF( SELF.Diff_stock_par_value,1,0)+ IF( SELF.Diff_stock_nbr_par_shares,1,0)+ IF( SELF.Diff_stock_change_ind,1,0)+ IF( SELF.Diff_stock_change_date,1,0)+ IF( SELF.Diff_stock_voting_rights_ind,1,0)+ IF( SELF.Diff_stock_convert_ind,1,0)+ IF( SELF.Diff_stock_convert_date,1,0)+ IF( SELF.Diff_stock_change_in_cap,1,0)+ IF( SELF.Diff_stock_tax_capital,1,0)+ IF( SELF.Diff_stock_total_capital,1,0)+ IF( SELF.Diff_stock_addl_info,1,0)+ IF( SELF.Diff_stock_stock_description,1,0)+ IF( SELF.Diff_stock_stock_series,1,0)+ IF( SELF.Diff_stock_non_par_value_flag,1,0)+ IF( SELF.Diff_stock_additional_stock,1,0)+ IF( SELF.Diff_stock_shares_proportion_to_ohio_for_foreign_license,1,0)+ IF( SELF.Diff_stock_share_credits,1,0)+ IF( SELF.Diff_stock_authorized_capital,1,0)+ IF( SELF.Diff_stock_stock_paid_in_capital,1,0)+ IF( SELF.Diff_stock_pay_higher_stock_fees,1,0)+ IF( SELF.Diff_stock_actual_amt_invested_in_state,1,0)+ IF( SELF.Diff_stock_share_exchange_during_merger,1,0)+ IF( SELF.Diff_stock_date_stock_limit_approved,1,0)+ IF( SELF.Diff_stock_number_of_shares_paid_for,1,0)+ IF( SELF.Diff_stock_total_value_of_shares_paid_for,1,0)+ IF( SELF.Diff_stock_sharesofbeneficialinterest,1,0)+ IF( SELF.Diff_stock_beneficialsharevalue,1,0);
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
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_vendor_county := COUNT(GROUP,%Closest%.Diff_corp_vendor_county);
    Count_Diff_corp_vendor_subcode := COUNT(GROUP,%Closest%.Diff_corp_vendor_subcode);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_sos_charter_nbr);
    Count_Diff_stock_ticker_symbol := COUNT(GROUP,%Closest%.Diff_stock_ticker_symbol);
    Count_Diff_stock_exchange := COUNT(GROUP,%Closest%.Diff_stock_exchange);
    Count_Diff_stock_type := COUNT(GROUP,%Closest%.Diff_stock_type);
    Count_Diff_stock_class := COUNT(GROUP,%Closest%.Diff_stock_class);
    Count_Diff_stock_shares_issued := COUNT(GROUP,%Closest%.Diff_stock_shares_issued);
    Count_Diff_stock_authorized_nbr := COUNT(GROUP,%Closest%.Diff_stock_authorized_nbr);
    Count_Diff_stock_par_value := COUNT(GROUP,%Closest%.Diff_stock_par_value);
    Count_Diff_stock_nbr_par_shares := COUNT(GROUP,%Closest%.Diff_stock_nbr_par_shares);
    Count_Diff_stock_change_ind := COUNT(GROUP,%Closest%.Diff_stock_change_ind);
    Count_Diff_stock_change_date := COUNT(GROUP,%Closest%.Diff_stock_change_date);
    Count_Diff_stock_voting_rights_ind := COUNT(GROUP,%Closest%.Diff_stock_voting_rights_ind);
    Count_Diff_stock_convert_ind := COUNT(GROUP,%Closest%.Diff_stock_convert_ind);
    Count_Diff_stock_convert_date := COUNT(GROUP,%Closest%.Diff_stock_convert_date);
    Count_Diff_stock_change_in_cap := COUNT(GROUP,%Closest%.Diff_stock_change_in_cap);
    Count_Diff_stock_tax_capital := COUNT(GROUP,%Closest%.Diff_stock_tax_capital);
    Count_Diff_stock_total_capital := COUNT(GROUP,%Closest%.Diff_stock_total_capital);
    Count_Diff_stock_addl_info := COUNT(GROUP,%Closest%.Diff_stock_addl_info);
    Count_Diff_stock_stock_description := COUNT(GROUP,%Closest%.Diff_stock_stock_description);
    Count_Diff_stock_stock_series := COUNT(GROUP,%Closest%.Diff_stock_stock_series);
    Count_Diff_stock_non_par_value_flag := COUNT(GROUP,%Closest%.Diff_stock_non_par_value_flag);
    Count_Diff_stock_additional_stock := COUNT(GROUP,%Closest%.Diff_stock_additional_stock);
    Count_Diff_stock_shares_proportion_to_ohio_for_foreign_license := COUNT(GROUP,%Closest%.Diff_stock_shares_proportion_to_ohio_for_foreign_license);
    Count_Diff_stock_share_credits := COUNT(GROUP,%Closest%.Diff_stock_share_credits);
    Count_Diff_stock_authorized_capital := COUNT(GROUP,%Closest%.Diff_stock_authorized_capital);
    Count_Diff_stock_stock_paid_in_capital := COUNT(GROUP,%Closest%.Diff_stock_stock_paid_in_capital);
    Count_Diff_stock_pay_higher_stock_fees := COUNT(GROUP,%Closest%.Diff_stock_pay_higher_stock_fees);
    Count_Diff_stock_actual_amt_invested_in_state := COUNT(GROUP,%Closest%.Diff_stock_actual_amt_invested_in_state);
    Count_Diff_stock_share_exchange_during_merger := COUNT(GROUP,%Closest%.Diff_stock_share_exchange_during_merger);
    Count_Diff_stock_date_stock_limit_approved := COUNT(GROUP,%Closest%.Diff_stock_date_stock_limit_approved);
    Count_Diff_stock_number_of_shares_paid_for := COUNT(GROUP,%Closest%.Diff_stock_number_of_shares_paid_for);
    Count_Diff_stock_total_value_of_shares_paid_for := COUNT(GROUP,%Closest%.Diff_stock_total_value_of_shares_paid_for);
    Count_Diff_stock_sharesofbeneficialinterest := COUNT(GROUP,%Closest%.Diff_stock_sharesofbeneficialinterest);
    Count_Diff_stock_beneficialsharevalue := COUNT(GROUP,%Closest%.Diff_stock_beneficialsharevalue);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
