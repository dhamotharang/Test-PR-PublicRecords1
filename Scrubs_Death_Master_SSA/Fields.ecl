IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_date','invalid_rec_type','invalid_ssn','invalid_vorp_code','invalid_name','invalid_st_country_code','invalid_zip','invalid_state','invalid_fipscounty','invalid_name_score');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_date' => 1,'invalid_rec_type' => 2,'invalid_ssn' => 3,'invalid_vorp_code' => 4,'invalid_name' => 5,'invalid_st_country_code' => 6,'invalid_zip' => 7,'invalid_state' => 8,'invalid_fipscounty' => 9,'invalid_name_score' => 10,0);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('8,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_rec_type(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rec_type(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['A','C','D',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('A|C|D|'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ssn(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ssn(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('9,4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_vorp_code(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vorp_code(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['V','P',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_vorp_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('V|P|'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©\' -.()'); // Only allow valid symbols
  s2 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s1,' -.()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©\' -.()'))),~(LENGTH(TRIM(s)) >= 0));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©\' -.()'),SALT30.HygieneErrors.NotLength('0..'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_st_country_code(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_st_country_code(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_st_country_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('5,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_fipscounty(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_fipscounty(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_fipscounty(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('3,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_name_score(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_name_score(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_name_score(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'filedate','rec_type','rec_type_orig','ssn','lname','name_suffix','fname','mname','vorp_code','dod8','dob8','st_country_code','zip_lastres','zip_lastpayment','state','fipscounty','clean_title','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score','crlf');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'filedate' => 1,'rec_type' => 2,'rec_type_orig' => 3,'ssn' => 4,'lname' => 5,'name_suffix' => 6,'fname' => 7,'mname' => 8,'vorp_code' => 9,'dod8' => 10,'dob8' => 11,'st_country_code' => 12,'zip_lastres' => 13,'zip_lastpayment' => 14,'state' => 15,'fipscounty' => 16,'clean_title' => 17,'clean_fname' => 18,'clean_mname' => 19,'clean_lname' => 20,'clean_name_suffix' => 21,'clean_name_score' => 22,'crlf' => 23,0);
//Individual field level validation
EXPORT Make_filedate(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_filedate(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_filedate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_rec_type(SALT30.StrType s0) := MakeFT_invalid_rec_type(s0);
EXPORT InValid_rec_type(SALT30.StrType s) := InValidFT_invalid_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_rec_type(wh);
EXPORT Make_rec_type_orig(SALT30.StrType s0) := MakeFT_invalid_rec_type(s0);
EXPORT InValid_rec_type_orig(SALT30.StrType s) := InValidFT_invalid_rec_type(s);
EXPORT InValidMessage_rec_type_orig(UNSIGNED1 wh) := InValidMessageFT_invalid_rec_type(wh);
EXPORT Make_ssn(SALT30.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT30.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
EXPORT Make_lname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_name_suffix(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name_suffix(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_fname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_mname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_mname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_vorp_code(SALT30.StrType s0) := MakeFT_invalid_vorp_code(s0);
EXPORT InValid_vorp_code(SALT30.StrType s) := InValidFT_invalid_vorp_code(s);
EXPORT InValidMessage_vorp_code(UNSIGNED1 wh) := InValidMessageFT_invalid_vorp_code(wh);
EXPORT Make_dod8(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dod8(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dod8(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_dob8(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob8(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob8(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_st_country_code(SALT30.StrType s0) := MakeFT_invalid_st_country_code(s0);
EXPORT InValid_st_country_code(SALT30.StrType s) := InValidFT_invalid_st_country_code(s);
EXPORT InValidMessage_st_country_code(UNSIGNED1 wh) := InValidMessageFT_invalid_st_country_code(wh);
EXPORT Make_zip_lastres(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip_lastres(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip_lastres(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_zip_lastpayment(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip_lastpayment(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip_lastpayment(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_state(SALT30.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT30.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_fipscounty(SALT30.StrType s0) := MakeFT_invalid_fipscounty(s0);
EXPORT InValid_fipscounty(SALT30.StrType s) := InValidFT_invalid_fipscounty(s);
EXPORT InValidMessage_fipscounty(UNSIGNED1 wh) := InValidMessageFT_invalid_fipscounty(wh);
EXPORT Make_clean_title(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_clean_title(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_clean_title(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_clean_fname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_clean_fname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_clean_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_clean_mname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_clean_mname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_clean_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_clean_lname(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_clean_lname(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_clean_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_clean_name_suffix(SALT30.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_clean_name_suffix(SALT30.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
EXPORT Make_clean_name_score(SALT30.StrType s0) := MakeFT_invalid_name_score(s0);
EXPORT InValid_clean_name_score(SALT30.StrType s) := InValidFT_invalid_name_score(s);
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := InValidMessageFT_invalid_name_score(wh);
EXPORT Make_crlf(SALT30.StrType s0) := s0;
EXPORT InValid_crlf(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_Death_Master_SSA;
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
    BOOLEAN Diff_filedate;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_rec_type_orig;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_vorp_code;
    BOOLEAN Diff_dod8;
    BOOLEAN Diff_dob8;
    BOOLEAN Diff_st_country_code;
    BOOLEAN Diff_zip_lastres;
    BOOLEAN Diff_zip_lastpayment;
    BOOLEAN Diff_state;
    BOOLEAN Diff_fipscounty;
    BOOLEAN Diff_clean_title;
    BOOLEAN Diff_clean_fname;
    BOOLEAN Diff_clean_mname;
    BOOLEAN Diff_clean_lname;
    BOOLEAN Diff_clean_name_suffix;
    BOOLEAN Diff_clean_name_score;
    BOOLEAN Diff_crlf;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_filedate := le.filedate <> ri.filedate;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_rec_type_orig := le.rec_type_orig <> ri.rec_type_orig;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_vorp_code := le.vorp_code <> ri.vorp_code;
    SELF.Diff_dod8 := le.dod8 <> ri.dod8;
    SELF.Diff_dob8 := le.dob8 <> ri.dob8;
    SELF.Diff_st_country_code := le.st_country_code <> ri.st_country_code;
    SELF.Diff_zip_lastres := le.zip_lastres <> ri.zip_lastres;
    SELF.Diff_zip_lastpayment := le.zip_lastpayment <> ri.zip_lastpayment;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_fipscounty := le.fipscounty <> ri.fipscounty;
    SELF.Diff_clean_title := le.clean_title <> ri.clean_title;
    SELF.Diff_clean_fname := le.clean_fname <> ri.clean_fname;
    SELF.Diff_clean_mname := le.clean_mname <> ri.clean_mname;
    SELF.Diff_clean_lname := le.clean_lname <> ri.clean_lname;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
    SELF.Diff_clean_name_score := le.clean_name_score <> ri.clean_name_score;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.rec_type;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_filedate,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_rec_type_orig,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_vorp_code,1,0)+ IF( SELF.Diff_dod8,1,0)+ IF( SELF.Diff_dob8,1,0)+ IF( SELF.Diff_st_country_code,1,0)+ IF( SELF.Diff_zip_lastres,1,0)+ IF( SELF.Diff_zip_lastpayment,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_fipscounty,1,0)+ IF( SELF.Diff_clean_title,1,0)+ IF( SELF.Diff_clean_fname,1,0)+ IF( SELF.Diff_clean_mname,1,0)+ IF( SELF.Diff_clean_lname,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0)+ IF( SELF.Diff_crlf,1,0);
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
    Count_Diff_filedate := COUNT(GROUP,%Closest%.Diff_filedate);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_rec_type_orig := COUNT(GROUP,%Closest%.Diff_rec_type_orig);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_vorp_code := COUNT(GROUP,%Closest%.Diff_vorp_code);
    Count_Diff_dod8 := COUNT(GROUP,%Closest%.Diff_dod8);
    Count_Diff_dob8 := COUNT(GROUP,%Closest%.Diff_dob8);
    Count_Diff_st_country_code := COUNT(GROUP,%Closest%.Diff_st_country_code);
    Count_Diff_zip_lastres := COUNT(GROUP,%Closest%.Diff_zip_lastres);
    Count_Diff_zip_lastpayment := COUNT(GROUP,%Closest%.Diff_zip_lastpayment);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_fipscounty := COUNT(GROUP,%Closest%.Diff_fipscounty);
    Count_Diff_clean_title := COUNT(GROUP,%Closest%.Diff_clean_title);
    Count_Diff_clean_fname := COUNT(GROUP,%Closest%.Diff_clean_fname);
    Count_Diff_clean_mname := COUNT(GROUP,%Closest%.Diff_clean_mname);
    Count_Diff_clean_lname := COUNT(GROUP,%Closest%.Diff_clean_lname);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
    Count_Diff_clean_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_score);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
