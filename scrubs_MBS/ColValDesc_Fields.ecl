IMPORT SALT311;
EXPORT ColValDesc_Fields := MODULE
 
EXPORT NumFields := 5;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_text','invalid_alpha','invalid_alphanumeric','invalid_email','invalid_date','invalid_numeric','invalid_numeric_string','invalid_real','invalid_real_string','invalid_zip','invalid_state','invalid_ssn','invalid_phone','invalid_ip','invalid_name');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_text' => 1,'invalid_alpha' => 2,'invalid_alphanumeric' => 3,'invalid_email' => 4,'invalid_date' => 5,'invalid_numeric' => 6,'invalid_numeric_string' => 7,'invalid_real' => 8,'invalid_real_string' => 9,'invalid_zip' => 10,'invalid_state' => 11,'invalid_ssn' => 12,'invalid_phone' => 13,'invalid_ip' => 14,'invalid_name' => 15,0);
 
EXPORT MakeFT_invalid_text(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_:%,'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_:%,',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_text(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_:%,'))));
EXPORT InValidMessageFT_invalid_text(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_:%,'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\NABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=\'`!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('\\ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=\'`!+&,./#()_'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'column_value_desc_id','table_column_id','desc_value','status','description');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'column_value_desc_id','table_column_id','desc_value','status','description');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'column_value_desc_id' => 0,'table_column_id' => 1,'desc_value' => 2,'status' => 3,'description' => 4,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_column_value_desc_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_column_value_desc_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_column_value_desc_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_table_column_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_table_column_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_table_column_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_desc_value(SALT311.StrType s0) := MakeFT_invalid_text(s0);
EXPORT InValid_desc_value(SALT311.StrType s) := InValidFT_invalid_text(s);
EXPORT InValidMessage_desc_value(UNSIGNED1 wh) := InValidMessageFT_invalid_text(wh);
 
EXPORT Make_status(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_status(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_description(SALT311.StrType s0) := MakeFT_invalid_text(s0);
EXPORT InValid_description(SALT311.StrType s) := InValidFT_invalid_text(s);
EXPORT InValidMessage_description(UNSIGNED1 wh) := InValidMessageFT_invalid_text(wh);
 
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
    BOOLEAN Diff_column_value_desc_id;
    BOOLEAN Diff_table_column_id;
    BOOLEAN Diff_desc_value;
    BOOLEAN Diff_status;
    BOOLEAN Diff_description;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_column_value_desc_id := le.column_value_desc_id <> ri.column_value_desc_id;
    SELF.Diff_table_column_id := le.table_column_id <> ri.table_column_id;
    SELF.Diff_desc_value := le.desc_value <> ri.desc_value;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_description := le.description <> ri.description;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_column_value_desc_id,1,0)+ IF( SELF.Diff_table_column_id,1,0)+ IF( SELF.Diff_desc_value,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_description,1,0);
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
    Count_Diff_column_value_desc_id := COUNT(GROUP,%Closest%.Diff_column_value_desc_id);
    Count_Diff_table_column_id := COUNT(GROUP,%Closest%.Diff_table_column_id);
    Count_Diff_desc_value := COUNT(GROUP,%Closest%.Diff_desc_value);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_description := COUNT(GROUP,%Closest%.Diff_description);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
