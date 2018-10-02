IMPORT SALT34;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 36;
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_mandatory','invalid_date','invalid_future_date','invalid_charter_nbr','invalid_numeric');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_corp_key' => 1,'invalid_corp_vendor' => 2,'invalid_state_origin' => 3,'invalid_mandatory' => 4,'invalid_date' => 5,'invalid_future_date' => 6,'invalid_charter_nbr' => 7,'invalid_numeric' => 8,0);
 
EXPORT MakeFT_invalid_corp_key(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.NotLength('4..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['26']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('26'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['MI']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('MI'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastdate(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_pastdate'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_future_date(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_future_date(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_generaldate(s)>0);
EXPORT InValidMessageFT_invalid_future_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_generaldate'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter_nbr(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter_nbr(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_charter_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','ar_year','ar_mailed_dt','ar_due_dt','ar_filed_dt','ar_report_dt','ar_report_nbr','ar_franchise_tax_paid_dt','ar_delinquent_dt','ar_tax_factor','ar_tax_amount_paid','ar_annual_report_cap','ar_illinois_capital','ar_roll','ar_frame','ar_extension','ar_microfilm_nbr','ar_comment','ar_type','ar_exempt','ar_license_tax_amount','ar_status','ar_paid_date','ar_prev_paid_date','ar_prev_tax_factor','ar_extension_date','ar_report_mail_date','ar_deliquent_report_mail_date','ar_report_filed_date','ar_year_and_month_due');
EXPORT SALT34.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'corp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','ar_year','ar_mailed_dt','ar_due_dt','ar_filed_dt','ar_report_dt','ar_report_nbr','ar_franchise_tax_paid_dt','ar_delinquent_dt','ar_tax_factor','ar_tax_amount_paid','ar_annual_report_cap','ar_illinois_capital','ar_roll','ar_frame','ar_extension','ar_microfilm_nbr','ar_comment','ar_type','ar_exempt','ar_license_tax_amount','ar_status','ar_paid_date','ar_prev_paid_date','ar_prev_tax_factor','ar_extension_date','ar_report_mail_date','ar_deliquent_report_mail_date','ar_report_filed_date','ar_year_and_month_due');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'corp_key' => 0,'corp_vendor' => 1,'corp_vendor_county' => 2,'corp_vendor_subcode' => 3,'corp_state_origin' => 4,'corp_process_date' => 5,'corp_sos_charter_nbr' => 6,'ar_year' => 7,'ar_mailed_dt' => 8,'ar_due_dt' => 9,'ar_filed_dt' => 10,'ar_report_dt' => 11,'ar_report_nbr' => 12,'ar_franchise_tax_paid_dt' => 13,'ar_delinquent_dt' => 14,'ar_tax_factor' => 15,'ar_tax_amount_paid' => 16,'ar_annual_report_cap' => 17,'ar_illinois_capital' => 18,'ar_roll' => 19,'ar_frame' => 20,'ar_extension' => 21,'ar_microfilm_nbr' => 22,'ar_comment' => 23,'ar_type' => 24,'ar_exempt' => 25,'ar_license_tax_amount' => 26,'ar_status' => 27,'ar_paid_date' => 28,'ar_prev_paid_date' => 29,'ar_prev_tax_factor' => 30,'ar_extension_date' => 31,'ar_report_mail_date' => 32,'ar_deliquent_report_mail_date' => 33,'ar_report_filed_date' => 34,'ar_year_and_month_due' => 35,0);
EXPORT SET OF SALT34.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['ENUM'],[],[],['ENUM'],['ALLOW','CUSTOM'],['ALLOW','LENGTHS'],['ALLOW'],[],[],['ALLOW','CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_corp_key(SALT34.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT34.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_vendor(SALT34.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT34.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_vendor_county(SALT34.StrType s0) := s0;
EXPORT InValid_corp_vendor_county(SALT34.StrType s) := 0;
EXPORT InValidMessage_corp_vendor_county(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_vendor_subcode(SALT34.StrType s0) := s0;
EXPORT InValid_corp_vendor_subcode(SALT34.StrType s) := 0;
EXPORT InValidMessage_corp_vendor_subcode(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_state_origin(SALT34.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT34.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_process_date(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_sos_charter_nbr(SALT34.StrType s0) := MakeFT_invalid_charter_nbr(s0);
EXPORT InValid_corp_sos_charter_nbr(SALT34.StrType s) := InValidFT_invalid_charter_nbr(s);
EXPORT InValidMessage_corp_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter_nbr(wh);
 
EXPORT Make_ar_year(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ar_year(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ar_year(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ar_mailed_dt(SALT34.StrType s0) := s0;
EXPORT InValid_ar_mailed_dt(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_mailed_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_due_dt(SALT34.StrType s0) := s0;
EXPORT InValid_ar_due_dt(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_due_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_filed_dt(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ar_filed_dt(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ar_filed_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_ar_report_dt(SALT34.StrType s0) := s0;
EXPORT InValid_ar_report_dt(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_report_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_report_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_ar_report_nbr(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_report_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_franchise_tax_paid_dt(SALT34.StrType s0) := s0;
EXPORT InValid_ar_franchise_tax_paid_dt(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_franchise_tax_paid_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_delinquent_dt(SALT34.StrType s0) := s0;
EXPORT InValid_ar_delinquent_dt(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_delinquent_dt(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_tax_factor(SALT34.StrType s0) := s0;
EXPORT InValid_ar_tax_factor(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_tax_factor(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_tax_amount_paid(SALT34.StrType s0) := s0;
EXPORT InValid_ar_tax_amount_paid(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_tax_amount_paid(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_annual_report_cap(SALT34.StrType s0) := s0;
EXPORT InValid_ar_annual_report_cap(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_annual_report_cap(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_illinois_capital(SALT34.StrType s0) := s0;
EXPORT InValid_ar_illinois_capital(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_illinois_capital(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_roll(SALT34.StrType s0) := s0;
EXPORT InValid_ar_roll(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_roll(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_frame(SALT34.StrType s0) := s0;
EXPORT InValid_ar_frame(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_frame(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_extension(SALT34.StrType s0) := s0;
EXPORT InValid_ar_extension(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_extension(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_microfilm_nbr(SALT34.StrType s0) := s0;
EXPORT InValid_ar_microfilm_nbr(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_microfilm_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_comment(SALT34.StrType s0) := s0;
EXPORT InValid_ar_comment(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_comment(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_type(SALT34.StrType s0) := s0;
EXPORT InValid_ar_type(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_exempt(SALT34.StrType s0) := s0;
EXPORT InValid_ar_exempt(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_exempt(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_license_tax_amount(SALT34.StrType s0) := s0;
EXPORT InValid_ar_license_tax_amount(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_license_tax_amount(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_status(SALT34.StrType s0) := s0;
EXPORT InValid_ar_status(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_status(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_paid_date(SALT34.StrType s0) := s0;
EXPORT InValid_ar_paid_date(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_paid_date(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_prev_paid_date(SALT34.StrType s0) := s0;
EXPORT InValid_ar_prev_paid_date(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_prev_paid_date(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_prev_tax_factor(SALT34.StrType s0) := s0;
EXPORT InValid_ar_prev_tax_factor(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_prev_tax_factor(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_extension_date(SALT34.StrType s0) := s0;
EXPORT InValid_ar_extension_date(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_extension_date(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_report_mail_date(SALT34.StrType s0) := s0;
EXPORT InValid_ar_report_mail_date(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_report_mail_date(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_deliquent_report_mail_date(SALT34.StrType s0) := s0;
EXPORT InValid_ar_deliquent_report_mail_date(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_deliquent_report_mail_date(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_report_filed_date(SALT34.StrType s0) := s0;
EXPORT InValid_ar_report_filed_date(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_report_filed_date(UNSIGNED1 wh) := '';
 
EXPORT Make_ar_year_and_month_due(SALT34.StrType s0) := s0;
EXPORT InValid_ar_year_and_month_due(SALT34.StrType s) := 0;
EXPORT InValidMessage_ar_year_and_month_due(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_MI_AR;
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
    BOOLEAN Diff_ar_exempt;
    BOOLEAN Diff_ar_license_tax_amount;
    BOOLEAN Diff_ar_status;
    BOOLEAN Diff_ar_paid_date;
    BOOLEAN Diff_ar_prev_paid_date;
    BOOLEAN Diff_ar_prev_tax_factor;
    BOOLEAN Diff_ar_extension_date;
    BOOLEAN Diff_ar_report_mail_date;
    BOOLEAN Diff_ar_deliquent_report_mail_date;
    BOOLEAN Diff_ar_report_filed_date;
    BOOLEAN Diff_ar_year_and_month_due;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
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
    SELF.Diff_ar_exempt := le.ar_exempt <> ri.ar_exempt;
    SELF.Diff_ar_license_tax_amount := le.ar_license_tax_amount <> ri.ar_license_tax_amount;
    SELF.Diff_ar_status := le.ar_status <> ri.ar_status;
    SELF.Diff_ar_paid_date := le.ar_paid_date <> ri.ar_paid_date;
    SELF.Diff_ar_prev_paid_date := le.ar_prev_paid_date <> ri.ar_prev_paid_date;
    SELF.Diff_ar_prev_tax_factor := le.ar_prev_tax_factor <> ri.ar_prev_tax_factor;
    SELF.Diff_ar_extension_date := le.ar_extension_date <> ri.ar_extension_date;
    SELF.Diff_ar_report_mail_date := le.ar_report_mail_date <> ri.ar_report_mail_date;
    SELF.Diff_ar_deliquent_report_mail_date := le.ar_deliquent_report_mail_date <> ri.ar_deliquent_report_mail_date;
    SELF.Diff_ar_report_filed_date := le.ar_report_filed_date <> ri.ar_report_filed_date;
    SELF.Diff_ar_year_and_month_due := le.ar_year_and_month_due <> ri.ar_year_and_month_due;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_vendor_county,1,0)+ IF( SELF.Diff_corp_vendor_subcode,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_sos_charter_nbr,1,0)+ IF( SELF.Diff_ar_year,1,0)+ IF( SELF.Diff_ar_mailed_dt,1,0)+ IF( SELF.Diff_ar_due_dt,1,0)+ IF( SELF.Diff_ar_filed_dt,1,0)+ IF( SELF.Diff_ar_report_dt,1,0)+ IF( SELF.Diff_ar_report_nbr,1,0)+ IF( SELF.Diff_ar_franchise_tax_paid_dt,1,0)+ IF( SELF.Diff_ar_delinquent_dt,1,0)+ IF( SELF.Diff_ar_tax_factor,1,0)+ IF( SELF.Diff_ar_tax_amount_paid,1,0)+ IF( SELF.Diff_ar_annual_report_cap,1,0)+ IF( SELF.Diff_ar_illinois_capital,1,0)+ IF( SELF.Diff_ar_roll,1,0)+ IF( SELF.Diff_ar_frame,1,0)+ IF( SELF.Diff_ar_extension,1,0)+ IF( SELF.Diff_ar_microfilm_nbr,1,0)+ IF( SELF.Diff_ar_comment,1,0)+ IF( SELF.Diff_ar_type,1,0)+ IF( SELF.Diff_ar_exempt,1,0)+ IF( SELF.Diff_ar_license_tax_amount,1,0)+ IF( SELF.Diff_ar_status,1,0)+ IF( SELF.Diff_ar_paid_date,1,0)+ IF( SELF.Diff_ar_prev_paid_date,1,0)+ IF( SELF.Diff_ar_prev_tax_factor,1,0)+ IF( SELF.Diff_ar_extension_date,1,0)+ IF( SELF.Diff_ar_report_mail_date,1,0)+ IF( SELF.Diff_ar_deliquent_report_mail_date,1,0)+ IF( SELF.Diff_ar_report_filed_date,1,0)+ IF( SELF.Diff_ar_year_and_month_due,1,0);
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
    Count_Diff_ar_exempt := COUNT(GROUP,%Closest%.Diff_ar_exempt);
    Count_Diff_ar_license_tax_amount := COUNT(GROUP,%Closest%.Diff_ar_license_tax_amount);
    Count_Diff_ar_status := COUNT(GROUP,%Closest%.Diff_ar_status);
    Count_Diff_ar_paid_date := COUNT(GROUP,%Closest%.Diff_ar_paid_date);
    Count_Diff_ar_prev_paid_date := COUNT(GROUP,%Closest%.Diff_ar_prev_paid_date);
    Count_Diff_ar_prev_tax_factor := COUNT(GROUP,%Closest%.Diff_ar_prev_tax_factor);
    Count_Diff_ar_extension_date := COUNT(GROUP,%Closest%.Diff_ar_extension_date);
    Count_Diff_ar_report_mail_date := COUNT(GROUP,%Closest%.Diff_ar_report_mail_date);
    Count_Diff_ar_deliquent_report_mail_date := COUNT(GROUP,%Closest%.Diff_ar_deliquent_report_mail_date);
    Count_Diff_ar_report_filed_date := COUNT(GROUP,%Closest%.Diff_ar_report_filed_date);
    Count_Diff_ar_year_and_month_due := COUNT(GROUP,%Closest%.Diff_ar_year_and_month_due);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
