IMPORT ut,SALT32;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_activity','invalid_alpha','invalid_alphanumeric','invalid_date','invalid_drug_schedules','invalid_exp_of_payment_indicator','invalid_numeric');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'invalid_activity' => 1,'invalid_alpha' => 2,'invalid_alphanumeric' => 3,'invalid_date' => 4,'invalid_drug_schedules' => 5,'invalid_exp_of_payment_indicator' => 6,'invalid_numeric' => 7,0);
 
EXPORT MakeFT_invalid_activity(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_invalid_activity(SALT32.StrType s) := WHICH(SALT32.stringtouppercase(s)<>s,((SALT32.StrType) s) NOT IN ['ACTIVE','INACTIVE']);
EXPORT InValidMessageFT_invalid_activity(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotCaps,SALT32.HygieneErrors.NotInEnum('ACTIVE|INACTIVE'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_drug_schedules(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,' 12345LN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_drug_schedules(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,' 12345LN'))));
EXPORT InValidMessageFT_invalid_drug_schedules(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars(' 12345LN'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_exp_of_payment_indicator(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_exp_of_payment_indicator(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN ['E','P']);
EXPORT InValidMessageFT_invalid_exp_of_payment_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('E|P'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dea_registration_number','business_activity_code','drug_schedules','expiration_date','address1','address2','address3','address4','address5','state','zip_code','bus_activity_sub_code','exp_of_payment_indicator','activity','crlf');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'dea_registration_number' => 0,'business_activity_code' => 1,'drug_schedules' => 2,'expiration_date' => 3,'address1' => 4,'address2' => 5,'address3' => 6,'address4' => 7,'address5' => 8,'state' => 9,'zip_code' => 10,'bus_activity_sub_code' => 11,'exp_of_payment_indicator' => 12,'activity' => 13,'crlf' => 14,0);
 
//Individual field level validation
 
EXPORT Make_dea_registration_number(SALT32.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_dea_registration_number(SALT32.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_dea_registration_number(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_business_activity_code(SALT32.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_business_activity_code(SALT32.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_business_activity_code(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_drug_schedules(SALT32.StrType s0) := MakeFT_invalid_drug_schedules(s0);
EXPORT InValid_drug_schedules(SALT32.StrType s) := InValidFT_invalid_drug_schedules(s);
EXPORT InValidMessage_drug_schedules(UNSIGNED1 wh) := InValidMessageFT_invalid_drug_schedules(wh);
 
EXPORT Make_expiration_date(SALT32.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_expiration_date(SALT32.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_address1(SALT32.StrType s0) := s0;
EXPORT InValid_address1(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT32.StrType s0) := s0;
EXPORT InValid_address2(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_address3(SALT32.StrType s0) := s0;
EXPORT InValid_address3(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_address3(UNSIGNED1 wh) := '';
 
EXPORT Make_address4(SALT32.StrType s0) := s0;
EXPORT InValid_address4(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_address4(UNSIGNED1 wh) := '';
 
EXPORT Make_address5(SALT32.StrType s0) := s0;
EXPORT InValid_address5(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_address5(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT32.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_state(SALT32.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_zip_code(SALT32.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_zip_code(SALT32.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bus_activity_sub_code(SALT32.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_bus_activity_sub_code(SALT32.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_bus_activity_sub_code(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_exp_of_payment_indicator(SALT32.StrType s0) := MakeFT_invalid_exp_of_payment_indicator(s0);
EXPORT InValid_exp_of_payment_indicator(SALT32.StrType s) := InValidFT_invalid_exp_of_payment_indicator(s);
EXPORT InValidMessage_exp_of_payment_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_exp_of_payment_indicator(wh);
 
EXPORT Make_activity(SALT32.StrType s0) := MakeFT_invalid_activity(s0);
EXPORT InValid_activity(SALT32.StrType s) := InValidFT_invalid_activity(s);
EXPORT InValidMessage_activity(UNSIGNED1 wh) := InValidMessageFT_invalid_activity(wh);
 
EXPORT Make_crlf(SALT32.StrType s0) := s0;
EXPORT InValid_crlf(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,Scrubs_DEA;
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
    BOOLEAN Diff_dea_registration_number;
    BOOLEAN Diff_business_activity_code;
    BOOLEAN Diff_drug_schedules;
    BOOLEAN Diff_expiration_date;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_address3;
    BOOLEAN Diff_address4;
    BOOLEAN Diff_address5;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_bus_activity_sub_code;
    BOOLEAN Diff_exp_of_payment_indicator;
    BOOLEAN Diff_activity;
    BOOLEAN Diff_crlf;
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dea_registration_number := le.dea_registration_number <> ri.dea_registration_number;
    SELF.Diff_business_activity_code := le.business_activity_code <> ri.business_activity_code;
    SELF.Diff_drug_schedules := le.drug_schedules <> ri.drug_schedules;
    SELF.Diff_expiration_date := le.expiration_date <> ri.expiration_date;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_address3 := le.address3 <> ri.address3;
    SELF.Diff_address4 := le.address4 <> ri.address4;
    SELF.Diff_address5 := le.address5 <> ri.address5;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_bus_activity_sub_code := le.bus_activity_sub_code <> ri.bus_activity_sub_code;
    SELF.Diff_exp_of_payment_indicator := le.exp_of_payment_indicator <> ri.exp_of_payment_indicator;
    SELF.Diff_activity := le.activity <> ri.activity;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dea_registration_number,1,0)+ IF( SELF.Diff_business_activity_code,1,0)+ IF( SELF.Diff_drug_schedules,1,0)+ IF( SELF.Diff_expiration_date,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_address3,1,0)+ IF( SELF.Diff_address4,1,0)+ IF( SELF.Diff_address5,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_bus_activity_sub_code,1,0)+ IF( SELF.Diff_exp_of_payment_indicator,1,0)+ IF( SELF.Diff_activity,1,0)+ IF( SELF.Diff_crlf,1,0);
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
    Count_Diff_dea_registration_number := COUNT(GROUP,%Closest%.Diff_dea_registration_number);
    Count_Diff_business_activity_code := COUNT(GROUP,%Closest%.Diff_business_activity_code);
    Count_Diff_drug_schedules := COUNT(GROUP,%Closest%.Diff_drug_schedules);
    Count_Diff_expiration_date := COUNT(GROUP,%Closest%.Diff_expiration_date);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_address3 := COUNT(GROUP,%Closest%.Diff_address3);
    Count_Diff_address4 := COUNT(GROUP,%Closest%.Diff_address4);
    Count_Diff_address5 := COUNT(GROUP,%Closest%.Diff_address5);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_bus_activity_sub_code := COUNT(GROUP,%Closest%.Diff_bus_activity_sub_code);
    Count_Diff_exp_of_payment_indicator := COUNT(GROUP,%Closest%.Diff_exp_of_payment_indicator);
    Count_Diff_activity := COUNT(GROUP,%Closest%.Diff_activity);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
