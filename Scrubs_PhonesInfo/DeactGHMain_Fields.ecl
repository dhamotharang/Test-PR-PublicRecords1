IMPORT SALT36;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT DeactGHMain_Fields := MODULE


// Processing for each FieldType
EXPORT SALT36.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_DeactCode','Invalid_YN','Invalid_Date');
EXPORT FieldTypeNum(SALT36.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_DeactCode' => 2,'Invalid_YN' => 3,'Invalid_Date' => 4,0);

EXPORT MakeFT_Invalid_Num(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('-0123456789 '),SALT36.HygieneErrors.Good);

EXPORT MakeFT_Invalid_DeactCode(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DeactCode(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN ['DE','']);
EXPORT InValidMessageFT_Invalid_DeactCode(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('DE|'),SALT36.HygieneErrors.Good);

EXPORT MakeFT_Invalid_YN(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_YN(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN ['Y','N','P']);
EXPORT InValidMessageFT_Invalid_YN(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('Y|N|P'),SALT36.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Date(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT36.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT36.HygieneErrors.Good);


EXPORT SALT36.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'groupid','vendor_first_reported_dt','vendor_last_reported_dt','action_code','timestamp','phone','phone_swap','filename','carrier_name','filedate','swap_start_dt','swap_end_dt','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt','pk_carrier_name','days_apart');
EXPORT FieldNum(SALT36.StrType fn) := CASE(fn,'groupid' => 0,'vendor_first_reported_dt' => 1,'vendor_last_reported_dt' => 2,'action_code' => 3,'timestamp' => 4,'phone' => 5,'phone_swap' => 6,'filename' => 7,'carrier_name' => 8,'filedate' => 9,'swap_start_dt' => 10,'swap_end_dt' => 11,'deact_code' => 12,'deact_start_dt' => 13,'deact_end_dt' => 14,'react_start_dt' => 15,'react_end_dt' => 16,'is_react' => 17,'is_deact' => 18,'porting_dt' => 19,'pk_carrier_name' => 20,'days_apart' => 21,0);

//Individual field level validation


EXPORT Make_groupid(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_groupid(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_groupid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_vendor_first_reported_dt(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_vendor_first_reported_dt(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_vendor_first_reported_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_vendor_last_reported_dt(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_vendor_last_reported_dt(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_vendor_last_reported_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_action_code(SALT36.StrType s0) := s0;
EXPORT InValid_action_code(SALT36.StrType s) := 0;
EXPORT InValidMessage_action_code(UNSIGNED1 wh) := '';


EXPORT Make_timestamp(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_timestamp(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_timestamp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_phone(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_phone_swap(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_swap(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_swap(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);


EXPORT Make_filename(SALT36.StrType s0) := s0;
EXPORT InValid_filename(SALT36.StrType s) := 0;
EXPORT InValidMessage_filename(UNSIGNED1 wh) := '';


EXPORT Make_carrier_name(SALT36.StrType s0) := s0;
EXPORT InValid_carrier_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := '';


EXPORT Make_filedate(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_filedate(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_filedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_swap_start_dt(SALT36.StrType s0) := s0;
EXPORT InValid_swap_start_dt(SALT36.StrType s) := 0;
EXPORT InValidMessage_swap_start_dt(UNSIGNED1 wh) := '';


EXPORT Make_swap_end_dt(SALT36.StrType s0) := s0;
EXPORT InValid_swap_end_dt(SALT36.StrType s) := 0;
EXPORT InValidMessage_swap_end_dt(UNSIGNED1 wh) := '';


EXPORT Make_deact_code(SALT36.StrType s0) := MakeFT_Invalid_DeactCode(s0);
EXPORT InValid_deact_code(SALT36.StrType s) := InValidFT_Invalid_DeactCode(s);
EXPORT InValidMessage_deact_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_DeactCode(wh);


EXPORT Make_deact_start_dt(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_deact_start_dt(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_deact_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_deact_end_dt(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_deact_end_dt(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_deact_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_react_start_dt(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_react_start_dt(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_react_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_react_end_dt(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_react_end_dt(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_react_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_is_react(SALT36.StrType s0) := MakeFT_Invalid_YN(s0);
EXPORT InValid_is_react(SALT36.StrType s) := InValidFT_Invalid_YN(s);
EXPORT InValidMessage_is_react(UNSIGNED1 wh) := InValidMessageFT_Invalid_YN(wh);


EXPORT Make_is_deact(SALT36.StrType s0) := MakeFT_Invalid_YN(s0);
EXPORT InValid_is_deact(SALT36.StrType s) := InValidFT_Invalid_YN(s);
EXPORT InValidMessage_is_deact(UNSIGNED1 wh) := InValidMessageFT_Invalid_YN(wh);


EXPORT Make_porting_dt(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_porting_dt(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_porting_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);


EXPORT Make_pk_carrier_name(SALT36.StrType s0) := s0;
EXPORT InValid_pk_carrier_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_pk_carrier_name(UNSIGNED1 wh) := '';


EXPORT Make_days_apart(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_days_apart(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_days_apart(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT36,Scrubs_Phonesinfo;
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
    BOOLEAN Diff_groupid;
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
    BOOLEAN Diff_pk_carrier_name;
    BOOLEAN Diff_days_apart;
    UNSIGNED Num_Diffs;
    SALT36.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_groupid := le.groupid <> ri.groupid;
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
    SELF.Diff_pk_carrier_name := le.pk_carrier_name <> ri.pk_carrier_name;
    SELF.Diff_days_apart := le.days_apart <> ri.days_apart;
    SELF.Val := (SALT36.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_groupid,1,0)+ IF( SELF.Diff_vendor_first_reported_dt,1,0)+ IF( SELF.Diff_vendor_last_reported_dt,1,0)+ IF( SELF.Diff_action_code,1,0)+ IF( SELF.Diff_timestamp,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_swap,1,0)+ IF( SELF.Diff_filename,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_filedate,1,0)+ IF( SELF.Diff_swap_start_dt,1,0)+ IF( SELF.Diff_swap_end_dt,1,0)+ IF( SELF.Diff_deact_code,1,0)+ IF( SELF.Diff_deact_start_dt,1,0)+ IF( SELF.Diff_deact_end_dt,1,0)+ IF( SELF.Diff_react_start_dt,1,0)+ IF( SELF.Diff_react_end_dt,1,0)+ IF( SELF.Diff_is_react,1,0)+ IF( SELF.Diff_is_deact,1,0)+ IF( SELF.Diff_porting_dt,1,0)+ IF( SELF.Diff_pk_carrier_name,1,0)+ IF( SELF.Diff_days_apart,1,0);
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
    Count_Diff_groupid := COUNT(GROUP,%Closest%.Diff_groupid);
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
    Count_Diff_pk_carrier_name := COUNT(GROUP,%Closest%.Diff_pk_carrier_name);
    Count_Diff_days_apart := COUNT(GROUP,%Closest%.Diff_days_apart);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
