IMPORT ut,SALT30;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alphaNum','invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_numeric','invalid_alphaOnly','invalid_alphaRequired','invalid_date');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_alphaNum' => 1,'invalid_corp_key' => 2,'invalid_corp_vendor' => 3,'invalid_state_origin' => 4,'invalid_numeric' => 5,'invalid_alphaOnly' => 6,'invalid_alphaRequired' => 7,'invalid_date' => 8,0);
 
EXPORT MakeFT_invalid_alphaNum(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.@%&*()\'#\\/,`:$! <>{}[]-^=!+&,./#()'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphaNum(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.@%&*()\'#\\/,`:$! <>{}[]-^=!+&,./#()'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_alphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;"-.@%&*()\'#\\/,`:$! <>{}[]-^=!+&,./#()'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_key(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_key(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('4..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('2'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state_origin(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT30.HygieneErrors.NotLength('2'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaOnly(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaOnly(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alphaOnly(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaRequired(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaRequired(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_alphaRequired(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT30.HygieneErrors.NotLength('0..8'),SALT30.HygieneErrors.Good);
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'bdid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','stock_ticker_symbol','stock_exchange','stock_type','stock_class','stock_shares_issued','stock_authorized_nbr','stock_par_value','stock_nbr_par_shares','stock_change_ind','stock_change_date','stock_voting_rights_ind','stock_convert_ind','stock_convert_date','stock_change_in_cap','stock_tax_capital','stock_total_capital','stock_addl_info','record_type');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'bdid' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'dt_vendor_first_reported' => 4,'dt_vendor_last_reported' => 5,'corp_key' => 6,'corp_vendor' => 7,'corp_vendor_county' => 8,'corp_vendor_subcode' => 9,'corp_state_origin' => 10,'corp_process_date' => 11,'corp_sos_charter_nbr' => 12,'stock_ticker_symbol' => 13,'stock_exchange' => 14,'stock_type' => 15,'stock_class' => 16,'stock_shares_issued' => 17,'stock_authorized_nbr' => 18,'stock_par_value' => 19,'stock_nbr_par_shares' => 20,'stock_change_ind' => 21,'stock_change_date' => 22,'stock_voting_rights_ind' => 23,'stock_convert_ind' => 24,'stock_convert_date' => 25,'stock_change_in_cap' => 26,'stock_tax_capital' => 27,'stock_total_capital' => 28,'stock_addl_info' => 29,'record_type' => 30,0);
 
//Individual field level validation
 
EXPORT Make_bdid(SALT30.StrType s0) := s0;
EXPORT InValid_bdid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT30.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT30.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_corp_sos_charter_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_corp_sos_charter_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_sos_charter_nbr(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_stock_shares_issued(SALT30.StrType s0) := s0;
EXPORT InValid_stock_shares_issued(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_stock_shares_issued(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_record_type(SALT30.StrType s0) := s0;
EXPORT InValid_record_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Build_Stock_Base;
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
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
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
    BOOLEAN Diff_record_type;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
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
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_stock_ticker_symbol,1,0)+ IF( SELF.Diff_stock_exchange,1,0)+ IF( SELF.Diff_stock_type,1,0)+ IF( SELF.Diff_stock_class,1,0)+ IF( SELF.Diff_stock_shares_issued,1,0)+ IF( SELF.Diff_stock_authorized_nbr,1,0)+ IF( SELF.Diff_stock_par_value,1,0)+ IF( SELF.Diff_stock_nbr_par_shares,1,0)+ IF( SELF.Diff_stock_change_ind,1,0)+ IF( SELF.Diff_stock_change_date,1,0)+ IF( SELF.Diff_stock_voting_rights_ind,1,0)+ IF( SELF.Diff_stock_convert_ind,1,0)+ IF( SELF.Diff_stock_convert_date,1,0)+ IF( SELF.Diff_stock_change_in_cap,1,0)+ IF( SELF.Diff_stock_tax_capital,1,0)+ IF( SELF.Diff_stock_total_capital,1,0)+ IF( SELF.Diff_stock_addl_info,1,0)+ IF( SELF.Diff_record_type,1,0);
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
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
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
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
