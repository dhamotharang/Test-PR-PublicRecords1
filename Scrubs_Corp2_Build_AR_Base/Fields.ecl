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
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'bdid','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','ar_year','ar_mailed_dt','ar_due_dt','ar_filed_dt','ar_report_dt','ar_report_nbr','ar_franchise_tax_paid_dt','ar_delinquent_dt','ar_tax_factor','ar_tax_amount_paid','ar_annual_report_cap','ar_illinois_capital','ar_roll','ar_frame','ar_extension','ar_microfilm_nbr','ar_comment','ar_type','record_type');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'bdid' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'dt_vendor_first_reported' => 4,'dt_vendor_last_reported' => 5,'corp_key' => 6,'corp_vendor' => 7,'corp_vendor_county' => 8,'corp_vendor_subcode' => 9,'corp_state_origin' => 10,'corp_process_date' => 11,'corp_sos_charter_nbr' => 12,'ar_year' => 13,'ar_mailed_dt' => 14,'ar_due_dt' => 15,'ar_filed_dt' => 16,'ar_report_dt' => 17,'ar_report_nbr' => 18,'ar_franchise_tax_paid_dt' => 19,'ar_delinquent_dt' => 20,'ar_tax_factor' => 21,'ar_tax_amount_paid' => 22,'ar_annual_report_cap' => 23,'ar_illinois_capital' => 24,'ar_roll' => 25,'ar_frame' => 26,'ar_extension' => 27,'ar_microfilm_nbr' => 28,'ar_comment' => 29,'ar_type' => 30,'record_type' => 31,0);
 
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
 
EXPORT Make_ar_year(SALT30.StrType s0) := s0;
EXPORT InValid_ar_year(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_year(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_mailed_dt(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ar_mailed_dt(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ar_mailed_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_ar_due_dt(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ar_due_dt(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ar_due_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_ar_filed_dt(SALT30.StrType s0) := s0;
EXPORT InValid_ar_filed_dt(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_filed_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_report_dt(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ar_report_dt(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ar_report_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_ar_report_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_ar_report_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_report_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_franchise_tax_paid_dt(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ar_franchise_tax_paid_dt(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ar_franchise_tax_paid_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_ar_delinquent_dt(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ar_delinquent_dt(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ar_delinquent_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_ar_tax_factor(SALT30.StrType s0) := s0;
EXPORT InValid_ar_tax_factor(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_tax_factor(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_tax_amount_paid(SALT30.StrType s0) := s0;
EXPORT InValid_ar_tax_amount_paid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_tax_amount_paid(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_annual_report_cap(SALT30.StrType s0) := s0;
EXPORT InValid_ar_annual_report_cap(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_annual_report_cap(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_illinois_capital(SALT30.StrType s0) := s0;
EXPORT InValid_ar_illinois_capital(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_illinois_capital(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_roll(SALT30.StrType s0) := s0;
EXPORT InValid_ar_roll(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_roll(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_frame(SALT30.StrType s0) := s0;
EXPORT InValid_ar_frame(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_frame(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_extension(SALT30.StrType s0) := s0;
EXPORT InValid_ar_extension(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_extension(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_microfilm_nbr(SALT30.StrType s0) := s0;
EXPORT InValid_ar_microfilm_nbr(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_microfilm_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_comment(SALT30.StrType s0) := s0;
EXPORT InValid_ar_comment(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_comment(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_type(SALT30.StrType s0) := s0;
EXPORT InValid_ar_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ar_type(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT30.StrType s0) := s0;
EXPORT InValid_record_type(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Corp2_Build_AR_Base;
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
    BOOLEAN Diff_ar_year;
    BOOLEAN Diff_ar_mailed_dt;
    BOOLEAN Diff_ar_due_dt;
    BOOLEAN Diff_ar_filed_dt;
    BOOLEAN Diff_ar_report_dt;
    BOOLEAN Diff_ar_report_nbr;
    BOOLEAN Diff_ar_franchise_tax_paid_dt;
    BOOLEAN Diff_ar_delinquent_dt;
    BOOLEAN Diff_ar_tax_factor;
    BOOLEAN Diff_ar_tax_amount_paid;
    BOOLEAN Diff_ar_annual_report_cap;
    BOOLEAN Diff_ar_illinois_capital;
    BOOLEAN Diff_ar_roll;
    BOOLEAN Diff_ar_frame;
    BOOLEAN Diff_ar_extension;
    BOOLEAN Diff_ar_microfilm_nbr;
    BOOLEAN Diff_ar_comment;
    BOOLEAN Diff_ar_type;
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
    SELF.Diff_ar_year := le.ar_year <> ri.ar_year;
    SELF.Diff_ar_mailed_dt := le.ar_mailed_dt <> ri.ar_mailed_dt;
    SELF.Diff_ar_due_dt := le.ar_due_dt <> ri.ar_due_dt;
    SELF.Diff_ar_filed_dt := le.ar_filed_dt <> ri.ar_filed_dt;
    SELF.Diff_ar_report_dt := le.ar_report_dt <> ri.ar_report_dt;
    SELF.Diff_ar_report_nbr := le.ar_report_nbr <> ri.ar_report_nbr;
    SELF.Diff_ar_franchise_tax_paid_dt := le.ar_franchise_tax_paid_dt <> ri.ar_franchise_tax_paid_dt;
    SELF.Diff_ar_delinquent_dt := le.ar_delinquent_dt <> ri.ar_delinquent_dt;
    SELF.Diff_ar_tax_factor := le.ar_tax_factor <> ri.ar_tax_factor;
    SELF.Diff_ar_tax_amount_paid := le.ar_tax_amount_paid <> ri.ar_tax_amount_paid;
    SELF.Diff_ar_annual_report_cap := le.ar_annual_report_cap <> ri.ar_annual_report_cap;
    SELF.Diff_ar_illinois_capital := le.ar_illinois_capital <> ri.ar_illinois_capital;
    SELF.Diff_ar_roll := le.ar_roll <> ri.ar_roll;
    SELF.Diff_ar_frame := le.ar_frame <> ri.ar_frame;
    SELF.Diff_ar_extension := le.ar_extension <> ri.ar_extension;
    SELF.Diff_ar_microfilm_nbr := le.ar_microfilm_nbr <> ri.ar_microfilm_nbr;
    SELF.Diff_ar_comment := le.ar_comment <> ri.ar_comment;
    SELF.Diff_ar_type := le.ar_type <> ri.ar_type;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_ar_year,1,0)+ IF( SELF.Diff_ar_mailed_dt,1,0)+ IF( SELF.Diff_ar_due_dt,1,0)+ IF( SELF.Diff_ar_filed_dt,1,0)+ IF( SELF.Diff_ar_report_dt,1,0)+ IF( SELF.Diff_ar_report_nbr,1,0)+ IF( SELF.Diff_ar_franchise_tax_paid_dt,1,0)+ IF( SELF.Diff_ar_delinquent_dt,1,0)+ IF( SELF.Diff_ar_tax_factor,1,0)+ IF( SELF.Diff_ar_tax_amount_paid,1,0)+ IF( SELF.Diff_ar_annual_report_cap,1,0)+ IF( SELF.Diff_ar_illinois_capital,1,0)+ IF( SELF.Diff_ar_roll,1,0)+ IF( SELF.Diff_ar_frame,1,0)+ IF( SELF.Diff_ar_extension,1,0)+ IF( SELF.Diff_ar_microfilm_nbr,1,0)+ IF( SELF.Diff_ar_comment,1,0)+ IF( SELF.Diff_ar_type,1,0)+ IF( SELF.Diff_record_type,1,0);
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
    Count_Diff_ar_year := COUNT(GROUP,%Closest%.Diff_ar_year);
    Count_Diff_ar_mailed_dt := COUNT(GROUP,%Closest%.Diff_ar_mailed_dt);
    Count_Diff_ar_due_dt := COUNT(GROUP,%Closest%.Diff_ar_due_dt);
    Count_Diff_ar_filed_dt := COUNT(GROUP,%Closest%.Diff_ar_filed_dt);
    Count_Diff_ar_report_dt := COUNT(GROUP,%Closest%.Diff_ar_report_dt);
    Count_Diff_ar_report_nbr := COUNT(GROUP,%Closest%.Diff_ar_report_nbr);
    Count_Diff_ar_franchise_tax_paid_dt := COUNT(GROUP,%Closest%.Diff_ar_franchise_tax_paid_dt);
    Count_Diff_ar_delinquent_dt := COUNT(GROUP,%Closest%.Diff_ar_delinquent_dt);
    Count_Diff_ar_tax_factor := COUNT(GROUP,%Closest%.Diff_ar_tax_factor);
    Count_Diff_ar_tax_amount_paid := COUNT(GROUP,%Closest%.Diff_ar_tax_amount_paid);
    Count_Diff_ar_annual_report_cap := COUNT(GROUP,%Closest%.Diff_ar_annual_report_cap);
    Count_Diff_ar_illinois_capital := COUNT(GROUP,%Closest%.Diff_ar_illinois_capital);
    Count_Diff_ar_roll := COUNT(GROUP,%Closest%.Diff_ar_roll);
    Count_Diff_ar_frame := COUNT(GROUP,%Closest%.Diff_ar_frame);
    Count_Diff_ar_extension := COUNT(GROUP,%Closest%.Diff_ar_extension);
    Count_Diff_ar_microfilm_nbr := COUNT(GROUP,%Closest%.Diff_ar_microfilm_nbr);
    Count_Diff_ar_comment := COUNT(GROUP,%Closest%.Diff_ar_comment);
    Count_Diff_ar_type := COUNT(GROUP,%Closest%.Diff_ar_type);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
