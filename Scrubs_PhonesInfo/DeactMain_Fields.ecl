IMPORT SALT38;
EXPORT DeactMain_Fields := MODULE

EXPORT NumFields := 19;

// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Action_Code','Invalid_Deact_Code','Invalid_Num','Invalid_Num_Blank','Invalid_Filename','Invalid_IS');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Action_Code' => 1,'Invalid_Deact_Code' => 2,'Invalid_Num' => 3,'Invalid_Num_Blank' => 4,'Invalid_Filename' => 5,'Invalid_IS' => 6,0);

EXPORT MakeFT_Invalid_Action_Code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Action_Code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['DE','SW','SU','RE'],~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Action_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('DE|SW|SU|RE'),SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Deact_Code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Deact_Code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['DE','SU',' ']);
EXPORT InValidMessageFT_Invalid_Deact_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('DE|SU| '),SALT38.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Num_Blank(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num_Blank(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Filename(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Filename(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'))));
EXPORT InValidMessageFT_Invalid_Filename(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'),SALT38.HygieneErrors.Good);

EXPORT MakeFT_Invalid_IS(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'YNP '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_IS(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'YNP '))));
EXPORT InValidMessageFT_Invalid_IS(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('YNP '),SALT38.HygieneErrors.Good);


EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'vendor_first_reported_dt','vendor_last_reported_dt','action_code','timestamp','phone','phone_swap','filename','carrier_name','filedate','swap_start_dt','swap_end_dt','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'vendor_first_reported_dt','vendor_last_reported_dt','action_code','timestamp','phone','phone_swap','filename','carrier_name','filedate','swap_start_dt','swap_end_dt','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'vendor_first_reported_dt' => 0,'vendor_last_reported_dt' => 1,'action_code' => 2,'timestamp' => 3,'phone' => 4,'phone_swap' => 5,'filename' => 6,'carrier_name' => 7,'filedate' => 8,'swap_start_dt' => 9,'swap_end_dt' => 10,'deact_code' => 11,'deact_start_dt' => 12,'deact_end_dt' => 13,'react_start_dt' => 14,'react_end_dt' => 15,'is_react' => 16,'is_deact' => 17,'porting_dt' => 18,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ENUM','LENGTH'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_vendor_first_reported_dt(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor_first_reported_dt(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor_first_reported_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_vendor_last_reported_dt(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor_last_reported_dt(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor_last_reported_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_action_code(SALT38.StrType s0) := MakeFT_Invalid_Action_Code(s0);
EXPORT InValid_action_code(SALT38.StrType s) := InValidFT_Invalid_Action_Code(s);
EXPORT InValidMessage_action_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Action_Code(wh);


EXPORT Make_timestamp(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_timestamp(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_timestamp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_phone(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_phone_swap(SALT38.StrType s0) := MakeFT_Invalid_Num_Blank(s0);
EXPORT InValid_phone_swap(SALT38.StrType s) := InValidFT_Invalid_Num_Blank(s);
EXPORT InValidMessage_phone_swap(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Blank(wh);


EXPORT Make_filename(SALT38.StrType s0) := MakeFT_Invalid_Filename(s0);
EXPORT InValid_filename(SALT38.StrType s) := InValidFT_Invalid_Filename(s);
EXPORT InValidMessage_filename(UNSIGNED1 wh) := InValidMessageFT_Invalid_Filename(wh);


EXPORT Make_carrier_name(SALT38.StrType s0) := s0;
EXPORT InValid_carrier_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := '';


EXPORT Make_filedate(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_filedate(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_filedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_swap_start_dt(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_swap_start_dt(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_swap_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_swap_end_dt(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_swap_end_dt(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_swap_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_deact_code(SALT38.StrType s0) := MakeFT_Invalid_Deact_Code(s0);
EXPORT InValid_deact_code(SALT38.StrType s) := InValidFT_Invalid_Deact_Code(s);
EXPORT InValidMessage_deact_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Deact_Code(wh);


EXPORT Make_deact_start_dt(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_deact_start_dt(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_deact_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_deact_end_dt(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_deact_end_dt(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_deact_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_react_start_dt(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_react_start_dt(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_react_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_react_end_dt(SALT38.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_react_end_dt(SALT38.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_react_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_is_react(SALT38.StrType s0) := MakeFT_Invalid_IS(s0);
EXPORT InValid_is_react(SALT38.StrType s) := InValidFT_Invalid_IS(s);
EXPORT InValidMessage_is_react(UNSIGNED1 wh) := InValidMessageFT_Invalid_IS(wh);


EXPORT Make_is_deact(SALT38.StrType s0) := MakeFT_Invalid_IS(s0);
EXPORT InValid_is_deact(SALT38.StrType s) := InValidFT_Invalid_IS(s);
EXPORT InValidMessage_is_deact(UNSIGNED1 wh) := InValidMessageFT_Invalid_IS(wh);


EXPORT Make_porting_dt(SALT38.StrType s0) := MakeFT_Invalid_Num_Blank(s0);
EXPORT InValid_porting_dt(SALT38.StrType s) := InValidFT_Invalid_Num_Blank(s);
EXPORT InValidMessage_porting_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Blank(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_vendor_first_reported_dt;
    BOOLEAN Diff_vendor_last_reported_dt;
    BOOLEAN Diff_action_code;
    BOOLEAN Diff_timestamp;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phone_swap;
    BOOLEAN Diff_filename;
    BOOLEAN Diff_carrier_name;
    BOOLEAN Diff_filedate;
    BOOLEAN Diff_swap_start_dt;
    BOOLEAN Diff_swap_end_dt;
    BOOLEAN Diff_deact_code;
    BOOLEAN Diff_deact_start_dt;
    BOOLEAN Diff_deact_end_dt;
    BOOLEAN Diff_react_start_dt;
    BOOLEAN Diff_react_end_dt;
    BOOLEAN Diff_is_react;
    BOOLEAN Diff_is_deact;
    BOOLEAN Diff_porting_dt;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_vendor_first_reported_dt := le.vendor_first_reported_dt <> ri.vendor_first_reported_dt;
    SELF.Diff_vendor_last_reported_dt := le.vendor_last_reported_dt <> ri.vendor_last_reported_dt;
    SELF.Diff_action_code := le.action_code <> ri.action_code;
    SELF.Diff_timestamp := le.timestamp <> ri.timestamp;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phone_swap := le.phone_swap <> ri.phone_swap;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Diff_carrier_name := le.carrier_name <> ri.carrier_name;
    SELF.Diff_filedate := le.filedate <> ri.filedate;
    SELF.Diff_swap_start_dt := le.swap_start_dt <> ri.swap_start_dt;
    SELF.Diff_swap_end_dt := le.swap_end_dt <> ri.swap_end_dt;
    SELF.Diff_deact_code := le.deact_code <> ri.deact_code;
    SELF.Diff_deact_start_dt := le.deact_start_dt <> ri.deact_start_dt;
    SELF.Diff_deact_end_dt := le.deact_end_dt <> ri.deact_end_dt;
    SELF.Diff_react_start_dt := le.react_start_dt <> ri.react_start_dt;
    SELF.Diff_react_end_dt := le.react_end_dt <> ri.react_end_dt;
    SELF.Diff_is_react := le.is_react <> ri.is_react;
    SELF.Diff_is_deact := le.is_deact <> ri.is_deact;
    SELF.Diff_porting_dt := le.porting_dt <> ri.porting_dt;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_vendor_first_reported_dt,1,0)+ IF( SELF.Diff_vendor_last_reported_dt,1,0)+ IF( SELF.Diff_action_code,1,0)+ IF( SELF.Diff_timestamp,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_swap,1,0)+ IF( SELF.Diff_filename,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_filedate,1,0)+ IF( SELF.Diff_swap_start_dt,1,0)+ IF( SELF.Diff_swap_end_dt,1,0)+ IF( SELF.Diff_deact_code,1,0)+ IF( SELF.Diff_deact_start_dt,1,0)+ IF( SELF.Diff_deact_end_dt,1,0)+ IF( SELF.Diff_react_start_dt,1,0)+ IF( SELF.Diff_react_end_dt,1,0)+ IF( SELF.Diff_is_react,1,0)+ IF( SELF.Diff_is_deact,1,0)+ IF( SELF.Diff_porting_dt,1,0);
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
    Count_Diff_vendor_first_reported_dt := COUNT(GROUP,%Closest%.Diff_vendor_first_reported_dt);
    Count_Diff_vendor_last_reported_dt := COUNT(GROUP,%Closest%.Diff_vendor_last_reported_dt);
    Count_Diff_action_code := COUNT(GROUP,%Closest%.Diff_action_code);
    Count_Diff_timestamp := COUNT(GROUP,%Closest%.Diff_timestamp);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phone_swap := COUNT(GROUP,%Closest%.Diff_phone_swap);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
    Count_Diff_carrier_name := COUNT(GROUP,%Closest%.Diff_carrier_name);
    Count_Diff_filedate := COUNT(GROUP,%Closest%.Diff_filedate);
    Count_Diff_swap_start_dt := COUNT(GROUP,%Closest%.Diff_swap_start_dt);
    Count_Diff_swap_end_dt := COUNT(GROUP,%Closest%.Diff_swap_end_dt);
    Count_Diff_deact_code := COUNT(GROUP,%Closest%.Diff_deact_code);
    Count_Diff_deact_start_dt := COUNT(GROUP,%Closest%.Diff_deact_start_dt);
    Count_Diff_deact_end_dt := COUNT(GROUP,%Closest%.Diff_deact_end_dt);
    Count_Diff_react_start_dt := COUNT(GROUP,%Closest%.Diff_react_start_dt);
    Count_Diff_react_end_dt := COUNT(GROUP,%Closest%.Diff_react_end_dt);
    Count_Diff_is_react := COUNT(GROUP,%Closest%.Diff_is_react);
    Count_Diff_is_deact := COUNT(GROUP,%Closest%.Diff_is_deact);
    Count_Diff_porting_dt := COUNT(GROUP,%Closest%.Diff_porting_dt);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
