IMPORT ut,SALT32;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_key','invalid_charter','invalid_mandatory','invalid_date','invalid_optional_date','invalid_corp_vendor','invalid_state_origin','invalid_trademark_status');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'invalid_corp_key' => 1,'invalid_charter' => 2,'invalid_mandatory' => 3,'invalid_date' => 4,'invalid_optional_date' => 5,'invalid_corp_vendor' => 6,'invalid_state_origin' => 7,'invalid_trademark_status' => 8,0);
 
EXPORT MakeFT_invalid_corp_key(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) >= 4 AND LENGTH(TRIM(s)) <= 15));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT32.HygieneErrors.NotLength('4..15'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 12));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT32.HygieneErrors.NotLength('1..12'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT32.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotLength('1..'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT32.HygieneErrors.NotLength('8'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_optional_date(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_optional_date(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_optional_date(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT32.HygieneErrors.NotLength('0,1,8'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['12']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('12'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['FL']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('FL'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_trademark_status(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_trademark_status(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['I','A',' ']);
EXPORT InValidMessageFT_invalid_trademark_status(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('I|A| '),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'corp_key','corp_orig_sos_charter_nbr','corp_legal_name','dt_first_seen','dt_last_seen','corp_process_date','corp_ra_dt_first_seen','corp_ra_dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_expiration_date','corp_trademark_filing_date','corp_vendor','corp_state_origin','corp_inc_state','corp_trademark_status');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'corp_key' => 0,'corp_orig_sos_charter_nbr' => 1,'corp_legal_name' => 2,'dt_first_seen' => 3,'dt_last_seen' => 4,'corp_process_date' => 5,'corp_ra_dt_first_seen' => 6,'corp_ra_dt_last_seen' => 7,'dt_vendor_first_reported' => 8,'dt_vendor_last_reported' => 9,'corp_trademark_first_use_date' => 10,'corp_trademark_first_use_date_in_state' => 11,'corp_trademark_expiration_date' => 12,'corp_trademark_filing_date' => 13,'corp_vendor' => 14,'corp_state_origin' => 15,'corp_inc_state' => 16,'corp_trademark_status' => 17,0);
 
//Individual field level validation
 
EXPORT Make_corp_key(SALT32.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT32.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT32.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_corp_orig_sos_charter_nbr(SALT32.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
 
EXPORT Make_corp_legal_name(SALT32.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT32.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_dt_first_seen(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_first_seen(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_last_seen(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_last_seen(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_process_date(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_first_seen(SALT32.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_ra_dt_first_seen(SALT32.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_ra_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_ra_dt_last_seen(SALT32.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_ra_dt_last_seen(SALT32.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_ra_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT32.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT32.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT32.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT32.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_trademark_first_use_date(SALT32.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_trademark_first_use_date(SALT32.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_trademark_first_use_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_trademark_first_use_date_in_state(SALT32.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_trademark_first_use_date_in_state(SALT32.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_trademark_first_use_date_in_state(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_trademark_expiration_date(SALT32.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_trademark_expiration_date(SALT32.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_trademark_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_trademark_filing_date(SALT32.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_trademark_filing_date(SALT32.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_trademark_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_vendor(SALT32.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT32.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_state_origin(SALT32.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT32.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_inc_state(SALT32.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_inc_state(SALT32.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_trademark_status(SALT32.StrType s0) := MakeFT_invalid_trademark_status(s0);
EXPORT InValid_corp_trademark_status(SALT32.StrType s) := InValidFT_invalid_trademark_status(s);
EXPORT InValidMessage_corp_trademark_status(UNSIGNED1 wh) := InValidMessageFT_invalid_trademark_status(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,Scrubs_Corp2_Mapping_FLTM_Main;
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
    BOOLEAN Diff_corp_orig_sos_charter_nbr;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_ra_dt_first_seen;
    BOOLEAN Diff_corp_ra_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_corp_trademark_first_use_date;
    BOOLEAN Diff_corp_trademark_first_use_date_in_state;
    BOOLEAN Diff_corp_trademark_expiration_date;
    BOOLEAN Diff_corp_trademark_filing_date;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_inc_state;
    BOOLEAN Diff_corp_trademark_status;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr <> ri.corp_orig_sos_charter_nbr;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_ra_dt_first_seen := le.corp_ra_dt_first_seen <> ri.corp_ra_dt_first_seen;
    SELF.Diff_corp_ra_dt_last_seen := le.corp_ra_dt_last_seen <> ri.corp_ra_dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_corp_trademark_first_use_date := le.corp_trademark_first_use_date <> ri.corp_trademark_first_use_date;
    SELF.Diff_corp_trademark_first_use_date_in_state := le.corp_trademark_first_use_date_in_state <> ri.corp_trademark_first_use_date_in_state;
    SELF.Diff_corp_trademark_expiration_date := le.corp_trademark_expiration_date <> ri.corp_trademark_expiration_date;
    SELF.Diff_corp_trademark_filing_date := le.corp_trademark_filing_date <> ri.corp_trademark_filing_date;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_inc_state := le.corp_inc_state <> ri.corp_inc_state;
    SELF.Diff_corp_trademark_status := le.corp_trademark_status <> ri.corp_trademark_status;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_ra_dt_first_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_corp_trademark_first_use_date,1,0)+ IF( SELF.Diff_corp_trademark_first_use_date_in_state,1,0)+ IF( SELF.Diff_corp_trademark_expiration_date,1,0)+ IF( SELF.Diff_corp_trademark_filing_date,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_inc_state,1,0)+ IF( SELF.Diff_corp_trademark_status,1,0);
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
    Count_Diff_corp_orig_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_orig_sos_charter_nbr);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_ra_dt_first_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_first_seen);
    Count_Diff_corp_ra_dt_last_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_corp_trademark_first_use_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_first_use_date);
    Count_Diff_corp_trademark_first_use_date_in_state := COUNT(GROUP,%Closest%.Diff_corp_trademark_first_use_date_in_state);
    Count_Diff_corp_trademark_expiration_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_expiration_date);
    Count_Diff_corp_trademark_filing_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_filing_date);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_inc_state := COUNT(GROUP,%Closest%.Diff_corp_inc_state);
    Count_Diff_corp_trademark_status := COUNT(GROUP,%Closest%.Diff_corp_trademark_status);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
