IMPORT SALT311;
EXPORT MarketAppend_Fields := MODULE
 
EXPORT NumFields := 7;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_email','invalid_date','invalid_numeric','invalid_numeric_string','invalid_real','invalid_real_string','invalid_zip','invalid_state','invalid_ssn','invalid_phone','invalid_ip','invalid_name');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_email' => 3,'invalid_date' => 4,'invalid_numeric' => 5,'invalid_numeric_string' => 6,'invalid_real' => 7,'invalid_real_string' => 8,'invalid_zip' => 9,'invalid_state' => 10,'invalid_ssn' => 11,'invalid_phone' => 12,'invalid_ip' => 13,'invalid_name' => 14,0);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_?'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_?',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_?'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_?'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N0123456789 ./:-'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' ./:-',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N0123456789 ./:-'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N0123456789 ./:-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_string(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N-0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_string(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N-0123456789'))));
EXPORT InValidMessageFT_invalid_numeric_string(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\N-0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_real(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'-.,0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_real(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'-.,0123456789'))));
EXPORT InValidMessageFT_invalid_real(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('-.,0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_real_string(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N-.,0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_real_string(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N-.,0123456789'))));
EXPORT InValidMessageFT_invalid_real_string(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\N-.,0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N-0123456789 -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N-0123456789 -'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N-0123456789 -'),SALT311.HygieneErrors.NotLength('2,5,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.NotLength('2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ssn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N0123456789 -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ssn(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N0123456789 -'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) >= 9));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N0123456789 -'),SALT311.HygieneErrors.NotLength('2,9..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N0123456789 +#()-'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' +#()-',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N0123456789 +#()-'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) >= 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N0123456789 +#()-'),SALT311.HygieneErrors.NotLength('2,10..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\N.x0123456789 .'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' .',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_ip(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\N.x0123456789 .'))));
EXPORT InValidMessageFT_invalid_ip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\N.x0123456789 .'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \''); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' \'',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \''))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.NotInChars('\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \''),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'company_id','app_type','market','sub_market','vertical','main_country_code','bill_country_code');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'company_id','app_type','market','sub_market','vertical','main_country_code','bill_country_code');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'company_id' => 0,'app_type' => 1,'market' => 2,'sub_market' => 3,'vertical' => 4,'main_country_code' => 5,'bill_country_code' => 6,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_company_id(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_company_id(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_company_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_app_type(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_app_type(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_app_type(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_market(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_market(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_market(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_sub_market(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_sub_market(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_sub_market(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_vertical(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_vertical(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_vertical(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_main_country_code(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_main_country_code(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_main_country_code(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_bill_country_code(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_bill_country_code(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_bill_country_code(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_MBS;
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
    BOOLEAN Diff_company_id;
    BOOLEAN Diff_app_type;
    BOOLEAN Diff_market;
    BOOLEAN Diff_sub_market;
    BOOLEAN Diff_vertical;
    BOOLEAN Diff_main_country_code;
    BOOLEAN Diff_bill_country_code;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_company_id := le.company_id <> ri.company_id;
    SELF.Diff_app_type := le.app_type <> ri.app_type;
    SELF.Diff_market := le.market <> ri.market;
    SELF.Diff_sub_market := le.sub_market <> ri.sub_market;
    SELF.Diff_vertical := le.vertical <> ri.vertical;
    SELF.Diff_main_country_code := le.main_country_code <> ri.main_country_code;
    SELF.Diff_bill_country_code := le.bill_country_code <> ri.bill_country_code;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_company_id,1,0)+ IF( SELF.Diff_app_type,1,0)+ IF( SELF.Diff_market,1,0)+ IF( SELF.Diff_sub_market,1,0)+ IF( SELF.Diff_vertical,1,0)+ IF( SELF.Diff_main_country_code,1,0)+ IF( SELF.Diff_bill_country_code,1,0);
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
    Count_Diff_company_id := COUNT(GROUP,%Closest%.Diff_company_id);
    Count_Diff_app_type := COUNT(GROUP,%Closest%.Diff_app_type);
    Count_Diff_market := COUNT(GROUP,%Closest%.Diff_market);
    Count_Diff_sub_market := COUNT(GROUP,%Closest%.Diff_sub_market);
    Count_Diff_vertical := COUNT(GROUP,%Closest%.Diff_vertical);
    Count_Diff_main_country_code := COUNT(GROUP,%Closest%.Diff_main_country_code);
    Count_Diff_bill_country_code := COUNT(GROUP,%Closest%.Diff_bill_country_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
