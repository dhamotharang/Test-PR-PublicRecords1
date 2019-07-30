﻿IMPORT SALT311;
IMPORT Scrubs_Thrive,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_PD_Fields := MODULE
 
EXPORT NumFields := 15;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_fname','invalid_mname','invalid_lname','invalid_addr','invalid_city','invalid_state','invalid_zip5','invalid_zip4','invalid_hmphone','invalid_cellphone','invalid_wrkphone','invalid_email','invalid_dob','invalid_employer','invalid_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_fname' => 1,'invalid_mname' => 2,'invalid_lname' => 3,'invalid_addr' => 4,'invalid_city' => 5,'invalid_state' => 6,'invalid_zip5' => 7,'invalid_zip4' => 8,'invalid_hmphone' => 9,'invalid_cellphone' => 10,'invalid_wrkphone' => 11,'invalid_email' => 12,'invalid_dob' => 13,'invalid_employer' => 14,'invalid_date' => 15,0);
 
EXPORT MakeFT_invalid_fname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_fname(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '))));
EXPORT InValidMessageFT_invalid_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_mname(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz '))));
EXPORT InValidMessageFT_invalid_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lname(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'1234AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_lname(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'1234AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '))));
EXPORT InValidMessageFT_invalid_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('1234AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_addr(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\'#/ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\'#/ '))),~Scrubs_Thrive.Functions.fn_invalid_addr(s)>0);
EXPORT InValidMessageFT_invalid_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\'#/ '),SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_invalid_addr'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.\' '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_Valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_zip(s)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_hmphone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_hmphone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_phone(s,TRUE)>0);
EXPORT InValidMessageFT_invalid_hmphone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cellphone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cellphone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_phone(s,TRUE)>0);
EXPORT InValidMessageFT_invalid_cellphone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wrkphone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_wrkphone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_phone(s,TRUE)>0);
EXPORT InValidMessageFT_invalid_wrkphone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dob(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dob(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_pastDate'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_employer(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-_,;\'&./+()#!:%& '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_employer(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-_,;\'&./+()#!:%& '))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_employer(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-_,;\'&./+()#!:%& '),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs_Thrive.Functions.fn_invalid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_invalid_date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_fname','orig_mname','orig_lname','orig_addr','orig_city','orig_state','orig_zip5','orig_zip4','phone_home','phone_cell','phone_work','email','dob','employer','dt');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_fname','orig_mname','orig_lname','orig_addr','orig_city','orig_state','orig_zip5','orig_zip4','phone_home','phone_cell','phone_work','email','dob','employer','dt');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'orig_fname' => 0,'orig_mname' => 1,'orig_lname' => 2,'orig_addr' => 3,'orig_city' => 4,'orig_state' => 5,'orig_zip5' => 6,'orig_zip4' => 7,'phone_home' => 8,'phone_cell' => 9,'phone_work' => 10,'email' => 11,'dob' => 12,'employer' => 13,'dt' => 14,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW','LENGTHS'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_orig_fname(SALT311.StrType s0) := MakeFT_invalid_fname(s0);
EXPORT InValid_orig_fname(SALT311.StrType s) := InValidFT_invalid_fname(s);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_fname(wh);
 
EXPORT Make_orig_mname(SALT311.StrType s0) := MakeFT_invalid_mname(s0);
EXPORT InValid_orig_mname(SALT311.StrType s) := InValidFT_invalid_mname(s);
EXPORT InValidMessage_orig_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_mname(wh);
 
EXPORT Make_orig_lname(SALT311.StrType s0) := MakeFT_invalid_lname(s0);
EXPORT InValid_orig_lname(SALT311.StrType s) := InValidFT_invalid_lname(s);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_lname(wh);
 
EXPORT Make_orig_addr(SALT311.StrType s0) := MakeFT_invalid_addr(s0);
EXPORT InValid_orig_addr(SALT311.StrType s) := InValidFT_invalid_addr(s);
EXPORT InValidMessage_orig_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_addr(wh);
 
EXPORT Make_orig_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_orig_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_orig_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_orig_zip5(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_orig_zip5(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_orig_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_orig_zip4(SALT311.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_orig_zip4(SALT311.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_phone_home(SALT311.StrType s0) := MakeFT_invalid_hmphone(s0);
EXPORT InValid_phone_home(SALT311.StrType s) := InValidFT_invalid_hmphone(s);
EXPORT InValidMessage_phone_home(UNSIGNED1 wh) := InValidMessageFT_invalid_hmphone(wh);
 
EXPORT Make_phone_cell(SALT311.StrType s0) := MakeFT_invalid_cellphone(s0);
EXPORT InValid_phone_cell(SALT311.StrType s) := InValidFT_invalid_cellphone(s);
EXPORT InValidMessage_phone_cell(UNSIGNED1 wh) := InValidMessageFT_invalid_cellphone(wh);
 
EXPORT Make_phone_work(SALT311.StrType s0) := MakeFT_invalid_wrkphone(s0);
EXPORT InValid_phone_work(SALT311.StrType s) := InValidFT_invalid_wrkphone(s);
EXPORT InValidMessage_phone_work(UNSIGNED1 wh) := InValidMessageFT_invalid_wrkphone(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_invalid_dob(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_invalid_dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_dob(wh);
 
EXPORT Make_employer(SALT311.StrType s0) := MakeFT_invalid_employer(s0);
EXPORT InValid_employer(SALT311.StrType s) := InValidFT_invalid_employer(s);
EXPORT InValidMessage_employer(UNSIGNED1 wh) := InValidMessageFT_invalid_employer(wh);
 
EXPORT Make_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Thrive;
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
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mname;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_addr;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip5;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_phone_home;
    BOOLEAN Diff_phone_cell;
    BOOLEAN Diff_phone_work;
    BOOLEAN Diff_email;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_employer;
    BOOLEAN Diff_dt;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mname := le.orig_mname <> ri.orig_mname;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_addr := le.orig_addr <> ri.orig_addr;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip5 := le.orig_zip5 <> ri.orig_zip5;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_phone_home := le.phone_home <> ri.phone_home;
    SELF.Diff_phone_cell := le.phone_cell <> ri.phone_cell;
    SELF.Diff_phone_work := le.phone_work <> ri.phone_work;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_employer := le.employer <> ri.employer;
    SELF.Diff_dt := le.dt <> ri.dt;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_addr,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip5,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_phone_home,1,0)+ IF( SELF.Diff_phone_cell,1,0)+ IF( SELF.Diff_phone_work,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_employer,1,0)+ IF( SELF.Diff_dt,1,0);
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
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mname := COUNT(GROUP,%Closest%.Diff_orig_mname);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_addr := COUNT(GROUP,%Closest%.Diff_orig_addr);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip5 := COUNT(GROUP,%Closest%.Diff_orig_zip5);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_phone_home := COUNT(GROUP,%Closest%.Diff_phone_home);
    Count_Diff_phone_cell := COUNT(GROUP,%Closest%.Diff_phone_cell);
    Count_Diff_phone_work := COUNT(GROUP,%Closest%.Diff_phone_work);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_employer := COUNT(GROUP,%Closest%.Diff_employer);
    Count_Diff_dt := COUNT(GROUP,%Closest%.Diff_dt);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
