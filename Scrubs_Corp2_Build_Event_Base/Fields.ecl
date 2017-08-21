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
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'bdid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','event_filing_reference_nbr','event_amendment_nbr','event_filing_date','event_date_type_cd','event_date_type_desc','event_filing_cd','event_filing_desc','event_corp_nbr','event_corp_nbr_cd','event_corp_nbr_desc','event_roll','event_frame','event_start','event_end','event_microfilm_nbr','event_desc','record_type');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'bdid' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'dt_vendor_first_reported' => 4,'dt_vendor_last_reported' => 5,'corp_key' => 6,'corp_supp_key' => 7,'corp_vendor' => 8,'corp_vendor_county' => 9,'corp_vendor_subcode' => 10,'corp_state_origin' => 11,'corp_process_date' => 12,'corp_sos_charter_nbr' => 13,'event_filing_reference_nbr' => 14,'event_amendment_nbr' => 15,'event_filing_date' => 16,'event_date_type_cd' => 17,'event_date_type_desc' => 18,'event_filing_cd' => 19,'event_filing_desc' => 20,'event_corp_nbr' => 21,'event_corp_nbr_cd' => 22,'event_corp_nbr_desc' => 23,'event_roll' => 24,'event_frame' => 25,'event_start' => 26,'event_end' => 27,'event_microfilm_nbr' => 28,'event_desc' => 29,'record_type' => 30,0);
 
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
 
EXPORT Make_corp_supp_key(SALT30.StrType s0) := s0;
EXPORT InValid_corp_supp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_supp_key(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_event_filing_reference_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_event_filing_reference_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_filing_reference_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_amendment_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_event_amendment_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_amendment_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_filing_date(SALT30.StrType s0) := s0;
EXPORT InValid_event_filing_date(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_filing_date(UNSIGNED1 wh) := '';
 
EXPORT Make_event_date_type_cd(SALT30.StrType s0) := s0;
EXPORT InValid_event_date_type_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_date_type_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_event_date_type_desc(SALT30.StrType s0) := s0;
EXPORT InValid_event_date_type_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_date_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_event_filing_cd(SALT30.StrType s0) := s0;
EXPORT InValid_event_filing_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_filing_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_event_filing_desc(SALT30.StrType s0) := s0;
EXPORT InValid_event_filing_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_filing_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_event_corp_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_event_corp_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_corp_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_corp_nbr_cd(SALT30.StrType s0) := s0;
EXPORT InValid_event_corp_nbr_cd(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_corp_nbr_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_event_corp_nbr_desc(SALT30.StrType s0) := s0;
EXPORT InValid_event_corp_nbr_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_corp_nbr_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_event_roll(SALT30.StrType s0) := s0;
EXPORT InValid_event_roll(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_roll(UNSIGNED1 wh) := '';
 
EXPORT Make_event_frame(SALT30.StrType s0) := s0;
EXPORT InValid_event_frame(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_frame(UNSIGNED1 wh) := '';
 
EXPORT Make_event_start(SALT30.StrType s0) := s0;
EXPORT InValid_event_start(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_start(UNSIGNED1 wh) := '';
 
EXPORT Make_event_end(SALT30.StrType s0) := s0;
EXPORT InValid_event_end(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_end(UNSIGNED1 wh) := '';
 
EXPORT Make_event_microfilm_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_event_microfilm_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_microfilm_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_event_desc(SALT30.StrType s0) := s0;
EXPORT InValid_event_desc(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_event_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT30.StrType s0) := s0;
EXPORT InValid_record_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Build_Event_Base;
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
    BOOLEAN Diff_corp_supp_key;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_vendor_county;
    BOOLEAN Diff_corp_vendor_subcode;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_sos_charter_nbr;
    BOOLEAN Diff_event_filing_reference_nbr;
    BOOLEAN Diff_event_amendment_nbr;
    BOOLEAN Diff_event_filing_date;
    BOOLEAN Diff_event_date_type_cd;
    BOOLEAN Diff_event_date_type_desc;
    BOOLEAN Diff_event_filing_cd;
    BOOLEAN Diff_event_filing_desc;
    BOOLEAN Diff_event_corp_nbr;
    BOOLEAN Diff_event_corp_nbr_cd;
    BOOLEAN Diff_event_corp_nbr_desc;
    BOOLEAN Diff_event_roll;
    BOOLEAN Diff_event_frame;
    BOOLEAN Diff_event_start;
    BOOLEAN Diff_event_end;
    BOOLEAN Diff_event_microfilm_nbr;
    BOOLEAN Diff_event_desc;
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
    SELF.Diff_corp_supp_key := le.corp_supp_key <> ri.corp_supp_key;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_vendor_county := le.corp_vendor_county <> ri.corp_vendor_county;
    SELF.Diff_corp_vendor_subcode := le.corp_vendor_subcode <> ri.corp_vendor_subcode;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_sos_charter_nbr := le.corp_sos_charter_nbr <> ri.corp_sos_charter_nbr;
    SELF.Diff_event_filing_reference_nbr := le.event_filing_reference_nbr <> ri.event_filing_reference_nbr;
    SELF.Diff_event_amendment_nbr := le.event_amendment_nbr <> ri.event_amendment_nbr;
    SELF.Diff_event_filing_date := le.event_filing_date <> ri.event_filing_date;
    SELF.Diff_event_date_type_cd := le.event_date_type_cd <> ri.event_date_type_cd;
    SELF.Diff_event_date_type_desc := le.event_date_type_desc <> ri.event_date_type_desc;
    SELF.Diff_event_filing_cd := le.event_filing_cd <> ri.event_filing_cd;
    SELF.Diff_event_filing_desc := le.event_filing_desc <> ri.event_filing_desc;
    SELF.Diff_event_corp_nbr := le.event_corp_nbr <> ri.event_corp_nbr;
    SELF.Diff_event_corp_nbr_cd := le.event_corp_nbr_cd <> ri.event_corp_nbr_cd;
    SELF.Diff_event_corp_nbr_desc := le.event_corp_nbr_desc <> ri.event_corp_nbr_desc;
    SELF.Diff_event_roll := le.event_roll <> ri.event_roll;
    SELF.Diff_event_frame := le.event_frame <> ri.event_frame;
    SELF.Diff_event_start := le.event_start <> ri.event_start;
    SELF.Diff_event_end := le.event_end <> ri.event_end;
    SELF.Diff_event_microfilm_nbr := le.event_microfilm_nbr <> ri.event_microfilm_nbr;
    SELF.Diff_event_desc := le.event_desc <> ri.event_desc;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_supp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_event_filing_reference_nbr,1,0)+ IF( SELF.Diff_event_amendment_nbr,1,0)+ IF( SELF.Diff_event_filing_date,1,0)+ IF( SELF.Diff_event_date_type_cd,1,0)+ IF( SELF.Diff_event_date_type_desc,1,0)+ IF( SELF.Diff_event_filing_cd,1,0)+ IF( SELF.Diff_event_filing_desc,1,0)+ IF( SELF.Diff_event_corp_nbr,1,0)+ IF( SELF.Diff_event_corp_nbr_cd,1,0)+ IF( SELF.Diff_event_corp_nbr_desc,1,0)+ IF( SELF.Diff_event_roll,1,0)+ IF( SELF.Diff_event_frame,1,0)+ IF( SELF.Diff_event_start,1,0)+ IF( SELF.Diff_event_end,1,0)+ IF( SELF.Diff_event_microfilm_nbr,1,0)+ IF( SELF.Diff_event_desc,1,0)+ IF( SELF.Diff_record_type,1,0);
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
    Count_Diff_corp_supp_key := COUNT(GROUP,%Closest%.Diff_corp_supp_key);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_vendor_county := COUNT(GROUP,%Closest%.Diff_corp_vendor_county);
    Count_Diff_corp_vendor_subcode := COUNT(GROUP,%Closest%.Diff_corp_vendor_subcode);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_sos_charter_nbr);
    Count_Diff_event_filing_reference_nbr := COUNT(GROUP,%Closest%.Diff_event_filing_reference_nbr);
    Count_Diff_event_amendment_nbr := COUNT(GROUP,%Closest%.Diff_event_amendment_nbr);
    Count_Diff_event_filing_date := COUNT(GROUP,%Closest%.Diff_event_filing_date);
    Count_Diff_event_date_type_cd := COUNT(GROUP,%Closest%.Diff_event_date_type_cd);
    Count_Diff_event_date_type_desc := COUNT(GROUP,%Closest%.Diff_event_date_type_desc);
    Count_Diff_event_filing_cd := COUNT(GROUP,%Closest%.Diff_event_filing_cd);
    Count_Diff_event_filing_desc := COUNT(GROUP,%Closest%.Diff_event_filing_desc);
    Count_Diff_event_corp_nbr := COUNT(GROUP,%Closest%.Diff_event_corp_nbr);
    Count_Diff_event_corp_nbr_cd := COUNT(GROUP,%Closest%.Diff_event_corp_nbr_cd);
    Count_Diff_event_corp_nbr_desc := COUNT(GROUP,%Closest%.Diff_event_corp_nbr_desc);
    Count_Diff_event_roll := COUNT(GROUP,%Closest%.Diff_event_roll);
    Count_Diff_event_frame := COUNT(GROUP,%Closest%.Diff_event_frame);
    Count_Diff_event_start := COUNT(GROUP,%Closest%.Diff_event_start);
    Count_Diff_event_end := COUNT(GROUP,%Closest%.Diff_event_end);
    Count_Diff_event_microfilm_nbr := COUNT(GROUP,%Closest%.Diff_event_microfilm_nbr);
    Count_Diff_event_desc := COUNT(GROUP,%Closest%.Diff_event_desc);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
