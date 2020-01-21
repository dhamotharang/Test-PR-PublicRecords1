IMPORT SALT311;
IMPORT Scrubs_Infutor_NARB,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 18;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_pastdate8','invalid_record_type','invalid_numeric','invalid_st','invalid_sic','invalid_url','invalid_address_type_code','invalid_norm_type','invalid_email');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_pastdate8' => 2,'invalid_record_type' => 3,'invalid_numeric' => 4,'invalid_st' => 5,'invalid_sic' => 6,'invalid_url' => 7,'invalid_address_type_code' => 8,'invalid_norm_type' => 9,'invalid_email' => 10,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT311.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|H'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_url(SALT311.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_url'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_type_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','G','H','P','R','S',' ']);
EXPORT InValidMessageFT_invalid_address_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|G|H|P|R|S| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_norm_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_norm_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','P','T']);
EXPORT InValidMessageFT_invalid_norm_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|P|T'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','pid','address_type_code','url','sic1','sic2','sic3','sic4','sic5','incorporation_state','email','contact_title','normcompany_type');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','pid','address_type_code','url','sic1','sic2','sic3','sic4','sic5','incorporation_state','email','contact_title','normcompany_type');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'process_date' => 4,'record_type' => 5,'pid' => 6,'address_type_code' => 7,'url' => 8,'sic1' => 9,'sic2' => 10,'sic3' => 11,'sic4' => 12,'sic5' => 13,'incorporation_state' => 14,'email' => 15,'contact_title' => 16,'normcompany_type' => 17,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['LENGTHS'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_pid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_pid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_pid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_address_type_code(SALT311.StrType s0) := MakeFT_invalid_address_type_code(s0);
EXPORT InValid_address_type_code(SALT311.StrType s) := InValidFT_invalid_address_type_code(s);
EXPORT InValidMessage_address_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_address_type_code(wh);
 
EXPORT Make_url(SALT311.StrType s0) := MakeFT_invalid_url(s0);
EXPORT InValid_url(SALT311.StrType s) := InValidFT_invalid_url(s);
EXPORT InValidMessage_url(UNSIGNED1 wh) := InValidMessageFT_invalid_url(wh);
 
EXPORT Make_sic1(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic1(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic3(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic3(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic5(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic5(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic5(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_incorporation_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_incorporation_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_incorporation_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_contact_title(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_contact_title(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_contact_title(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_normcompany_type(SALT311.StrType s0) := MakeFT_invalid_norm_type(s0);
EXPORT InValid_normcompany_type(SALT311.StrType s) := InValidFT_invalid_norm_type(s);
EXPORT InValidMessage_normcompany_type(UNSIGNED1 wh) := InValidMessageFT_invalid_norm_type(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Infutor_NARB;
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_pid;
    BOOLEAN Diff_address_type_code;
    BOOLEAN Diff_url;
    BOOLEAN Diff_sic1;
    BOOLEAN Diff_sic2;
    BOOLEAN Diff_sic3;
    BOOLEAN Diff_sic4;
    BOOLEAN Diff_sic5;
    BOOLEAN Diff_incorporation_state;
    BOOLEAN Diff_email;
    BOOLEAN Diff_contact_title;
    BOOLEAN Diff_normcompany_type;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_pid := le.pid <> ri.pid;
    SELF.Diff_address_type_code := le.address_type_code <> ri.address_type_code;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_sic1 := le.sic1 <> ri.sic1;
    SELF.Diff_sic2 := le.sic2 <> ri.sic2;
    SELF.Diff_sic3 := le.sic3 <> ri.sic3;
    SELF.Diff_sic4 := le.sic4 <> ri.sic4;
    SELF.Diff_sic5 := le.sic5 <> ri.sic5;
    SELF.Diff_incorporation_state := le.incorporation_state <> ri.incorporation_state;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_contact_title := le.contact_title <> ri.contact_title;
    SELF.Diff_normcompany_type := le.normcompany_type <> ri.normcompany_type;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_pid,1,0)+ IF( SELF.Diff_address_type_code,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_sic1,1,0)+ IF( SELF.Diff_sic2,1,0)+ IF( SELF.Diff_sic3,1,0)+ IF( SELF.Diff_sic4,1,0)+ IF( SELF.Diff_sic5,1,0)+ IF( SELF.Diff_incorporation_state,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_contact_title,1,0)+ IF( SELF.Diff_normcompany_type,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_pid := COUNT(GROUP,%Closest%.Diff_pid);
    Count_Diff_address_type_code := COUNT(GROUP,%Closest%.Diff_address_type_code);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_sic1 := COUNT(GROUP,%Closest%.Diff_sic1);
    Count_Diff_sic2 := COUNT(GROUP,%Closest%.Diff_sic2);
    Count_Diff_sic3 := COUNT(GROUP,%Closest%.Diff_sic3);
    Count_Diff_sic4 := COUNT(GROUP,%Closest%.Diff_sic4);
    Count_Diff_sic5 := COUNT(GROUP,%Closest%.Diff_sic5);
    Count_Diff_incorporation_state := COUNT(GROUP,%Closest%.Diff_incorporation_state);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_contact_title := COUNT(GROUP,%Closest%.Diff_contact_title);
    Count_Diff_normcompany_type := COUNT(GROUP,%Closest%.Diff_normcompany_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
