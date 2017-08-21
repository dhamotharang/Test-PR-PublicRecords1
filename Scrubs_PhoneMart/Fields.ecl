IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_phone','invalid_number','invalid_date','invalid_record_type','invalid_ssn','invalid_alpha','invalid_alpha_numeric','invalid_state','invalid_zip5','invalid_history_flag');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_phone' => 1,'invalid_number' => 2,'invalid_date' => 3,'invalid_record_type' => 4,'invalid_ssn' => 5,'invalid_alpha' => 6,'invalid_alpha_numeric' => 7,'invalid_state' => 8,'invalid_zip5' => 9,'invalid_history_flag' => 10,0);
EXPORT MakeFT_invalid_phone(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('10'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789 '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_record_type(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['1','2','4'],~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('1|2|4'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ssn(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('9,4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' ,.-',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha_numeric(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.-'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' ,.-',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha_numeric(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.-'))));
EXPORT InValidMessageFT_invalid_alpha_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.-'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_invalid_state(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip5(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip5(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_history_flag(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_history_flag(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_history_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'phone','did','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','cid_number','csd_ref_number','ssn','address','city','state','zipcode','history_flag','title','fname','mname','lname','name_suffix');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'phone' => 1,'did' => 2,'dt_vendor_first_reported' => 3,'dt_vendor_last_reported' => 4,'dt_first_seen' => 5,'dt_last_seen' => 6,'record_type' => 7,'cid_number' => 8,'csd_ref_number' => 9,'ssn' => 10,'address' => 11,'city' => 12,'state' => 13,'zipcode' => 14,'history_flag' => 15,'title' => 16,'fname' => 17,'mname' => 18,'lname' => 19,'name_suffix' => 20,0);
//Individual field level validation
EXPORT Make_phone(SALT30.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT30.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
EXPORT Make_did(SALT30.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_did(SALT30.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
EXPORT Make_dt_vendor_first_reported(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_dt_vendor_last_reported(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_dt_first_seen(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_first_seen(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_dt_last_seen(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_last_seen(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_record_type(SALT30.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT30.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
EXPORT Make_cid_number(SALT30.StrType s0) := MakeFT_invalid_alpha_numeric(s0);
EXPORT InValid_cid_number(SALT30.StrType s) := InValidFT_invalid_alpha_numeric(s);
EXPORT InValidMessage_cid_number(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_numeric(wh);
EXPORT Make_csd_ref_number(SALT30.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_csd_ref_number(SALT30.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_csd_ref_number(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
EXPORT Make_ssn(SALT30.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT30.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
EXPORT Make_address(SALT30.StrType s0) := s0;
EXPORT InValid_address(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
EXPORT Make_city(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_city(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_state(SALT30.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT30.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_zipcode(SALT30.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zipcode(SALT30.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
EXPORT Make_history_flag(SALT30.StrType s0) := MakeFT_invalid_history_flag(s0);
EXPORT InValid_history_flag(SALT30.StrType s) := InValidFT_invalid_history_flag(s);
EXPORT InValidMessage_history_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_history_flag(wh);
EXPORT Make_title(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_title(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_fname(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_fname(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_mname(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_mname(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_lname(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_lname(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_name_suffix(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_name_suffix(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_PhoneMart;
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
    BOOLEAN Diff_phone;
    BOOLEAN Diff_did;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_cid_number;
    BOOLEAN Diff_csd_ref_number;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_history_flag;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_cid_number := le.cid_number <> ri.cid_number;
    SELF.Diff_csd_ref_number := le.csd_ref_number <> ri.csd_ref_number;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_history_flag := le.history_flag <> ri.history_flag;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_cid_number,1,0)+ IF( SELF.Diff_csd_ref_number,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_history_flag,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0);
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
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_cid_number := COUNT(GROUP,%Closest%.Diff_cid_number);
    Count_Diff_csd_ref_number := COUNT(GROUP,%Closest%.Diff_csd_ref_number);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_history_flag := COUNT(GROUP,%Closest%.Diff_history_flag);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
