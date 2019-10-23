IMPORT SALT311;
EXPORT MasterIdIndTypeIncl_Fields := MODULE
 
EXPORT NumFields := 10;
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'fdn_ind_type_gc_id_inclusion','fdn_file_info_id','ind_type','inclusion_id','inclusion_type','status','date_added','user_added','date_changed','user_changed');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'fdn_ind_type_gc_id_inclusion','fdn_file_info_id','ind_type','inclusion_id','inclusion_type','status','date_added','user_added','date_changed','user_changed');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'fdn_ind_type_gc_id_inclusion' => 0,'fdn_file_info_id' => 1,'ind_type' => 2,'inclusion_id' => 3,'inclusion_type' => 4,'status' => 5,'date_added' => 6,'user_added' => 7,'date_changed' => 8,'user_changed' => 9,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],['LEFTTRIM','ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_fdn_ind_type_gc_id_inclusion(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fdn_ind_type_gc_id_inclusion(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fdn_ind_type_gc_id_inclusion(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fdn_file_info_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fdn_file_info_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fdn_file_info_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ind_type(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ind_type(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ind_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_inclusion_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_inclusion_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_inclusion_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_inclusion_type(SALT311.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_inclusion_type(SALT311.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_inclusion_type(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_status(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_status(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_user_added(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_user_added(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_user_added(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_date_changed(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_changed(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_changed(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_user_changed(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_user_changed(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_user_changed(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
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
    BOOLEAN Diff_fdn_ind_type_gc_id_inclusion;
    BOOLEAN Diff_fdn_file_info_id;
    BOOLEAN Diff_ind_type;
    BOOLEAN Diff_inclusion_id;
    BOOLEAN Diff_inclusion_type;
    BOOLEAN Diff_status;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_user_added;
    BOOLEAN Diff_date_changed;
    BOOLEAN Diff_user_changed;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_fdn_ind_type_gc_id_inclusion := le.fdn_ind_type_gc_id_inclusion <> ri.fdn_ind_type_gc_id_inclusion;
    SELF.Diff_fdn_file_info_id := le.fdn_file_info_id <> ri.fdn_file_info_id;
    SELF.Diff_ind_type := le.ind_type <> ri.ind_type;
    SELF.Diff_inclusion_id := le.inclusion_id <> ri.inclusion_id;
    SELF.Diff_inclusion_type := le.inclusion_type <> ri.inclusion_type;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_user_added := le.user_added <> ri.user_added;
    SELF.Diff_date_changed := le.date_changed <> ri.date_changed;
    SELF.Diff_user_changed := le.user_changed <> ri.user_changed;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_fdn_ind_type_gc_id_inclusion,1,0)+ IF( SELF.Diff_fdn_file_info_id,1,0)+ IF( SELF.Diff_ind_type,1,0)+ IF( SELF.Diff_inclusion_id,1,0)+ IF( SELF.Diff_inclusion_type,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_user_added,1,0)+ IF( SELF.Diff_date_changed,1,0)+ IF( SELF.Diff_user_changed,1,0);
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
    Count_Diff_fdn_ind_type_gc_id_inclusion := COUNT(GROUP,%Closest%.Diff_fdn_ind_type_gc_id_inclusion);
    Count_Diff_fdn_file_info_id := COUNT(GROUP,%Closest%.Diff_fdn_file_info_id);
    Count_Diff_ind_type := COUNT(GROUP,%Closest%.Diff_ind_type);
    Count_Diff_inclusion_id := COUNT(GROUP,%Closest%.Diff_inclusion_id);
    Count_Diff_inclusion_type := COUNT(GROUP,%Closest%.Diff_inclusion_type);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_user_added := COUNT(GROUP,%Closest%.Diff_user_added);
    Count_Diff_date_changed := COUNT(GROUP,%Closest%.Diff_date_changed);
    Count_Diff_user_changed := COUNT(GROUP,%Closest%.Diff_user_changed);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
