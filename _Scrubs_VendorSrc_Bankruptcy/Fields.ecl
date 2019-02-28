IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 9;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_courtcode','Invalid_court_name','Invalid_address','Invalid_city','Invalid_state','Invalid_numbers');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_courtcode' => 1,'Invalid_court_name' => 2,'Invalid_address' => 3,'Invalid_city' => 4,'Invalid_state' => 5,'Invalid_numbers' => 6,0);
 
EXPORT MakeFT_Invalid_courtcode(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'.123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_courtcode(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'.123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_courtcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('.123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_court_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_court_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_court_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_address(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' #&-,.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_address(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' #&-,.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_address(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' #&-,.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_numbers(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_numbers(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_numbers(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'lncourtcode','rmscourt_code','court_name','address1','address2','city','state','zip','phone');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'lncourtcode','rmscourt_code','court_name','address1','address2','city','state','zip','phone');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'lncourtcode' => 0,'rmscourt_code' => 1,'court_name' => 2,'address1' => 3,'address2' => 4,'city' => 5,'state' => 6,'zip' => 7,'phone' => 8,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_lncourtcode(SALT311.StrType s0) := MakeFT_Invalid_courtcode(s0);
EXPORT InValid_lncourtcode(SALT311.StrType s) := InValidFT_Invalid_courtcode(s);
EXPORT InValidMessage_lncourtcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_courtcode(wh);
 
EXPORT Make_rmscourt_code(SALT311.StrType s0) := MakeFT_Invalid_courtcode(s0);
EXPORT InValid_rmscourt_code(SALT311.StrType s) := InValidFT_Invalid_courtcode(s);
EXPORT InValidMessage_rmscourt_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_courtcode(wh);
 
EXPORT Make_court_name(SALT311.StrType s0) := MakeFT_Invalid_court_name(s0);
EXPORT InValid_court_name(SALT311.StrType s) := InValidFT_Invalid_court_name(s);
EXPORT InValidMessage_court_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_court_name(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_Invalid_address(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_Invalid_address(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_address(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := MakeFT_Invalid_address(s0);
EXPORT InValid_address2(SALT311.StrType s) := InValidFT_Invalid_address(s);
EXPORT InValidMessage_address2(UNSIGNED1 wh) := InValidMessageFT_Invalid_address(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_city(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_city(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_state(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_Invalid_numbers(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_Invalid_numbers(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_numbers(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_numbers(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_numbers(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_numbers(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,_Scrubs_VendorSrc_Bankruptcy;
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
    BOOLEAN Diff_lncourtcode;
    BOOLEAN Diff_rmscourt_code;
    BOOLEAN Diff_court_name;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_phone;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_lncourtcode := le.lncourtcode <> ri.lncourtcode;
    SELF.Diff_rmscourt_code := le.rmscourt_code <> ri.rmscourt_code;
    SELF.Diff_court_name := le.court_name <> ri.court_name;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_lncourtcode,1,0)+ IF( SELF.Diff_rmscourt_code,1,0)+ IF( SELF.Diff_court_name,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_phone,1,0);
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
    Count_Diff_lncourtcode := COUNT(GROUP,%Closest%.Diff_lncourtcode);
    Count_Diff_rmscourt_code := COUNT(GROUP,%Closest%.Diff_rmscourt_code);
    Count_Diff_court_name := COUNT(GROUP,%Closest%.Diff_court_name);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
