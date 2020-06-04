IMPORT SALT311;
IMPORT Scrubs_Thrive,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_LT_Fields := MODULE
 
EXPORT NumFields := 11;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_fname','invalid_lname','invalid_addr','invalid_city','invalid_state','invalid_zip5','invalid_zip4','invalid_email','invalid_phone','invalid_employer','invalid_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_fname' => 1,'invalid_lname' => 2,'invalid_addr' => 3,'invalid_city' => 4,'invalid_state' => 5,'invalid_zip5' => 6,'invalid_zip4' => 7,'invalid_email' => 8,'invalid_phone' => 9,'invalid_employer' => 10,'invalid_date' => 11,0);
 
EXPORT MakeFT_invalid_fname(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fname(SALT311.StrType s,SALT311.StrType orig_fname,SALT311.StrType orig_lname) := WHICH(~Scrubs_Thrive.Functions.fn_chk_blank_names(s,orig_fname,orig_lname)>0);
EXPORT InValidMessageFT_invalid_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_chk_blank_names'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lname(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lname(SALT311.StrType s,SALT311.StrType orig_fname,SALT311.StrType orig_lname) := WHICH(~Scrubs_Thrive.Functions.fn_chk_blank_names(s,orig_fname,orig_lname)>0);
EXPORT InValidMessageFT_invalid_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_chk_blank_names'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_addr(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_addr(SALT311.StrType s) := WHICH(~Scrubs_Thrive.Functions.fn_invalid_addr(s)>0);
EXPORT InValidMessageFT_invalid_addr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_invalid_addr'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s) := WHICH(~Scrubs_Thrive.Functions.fn_chk_city(s)>0);
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_chk_city'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(~Scrubs_Thrive.Functions.fn_chk_email(s)>0);
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_chk_email'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_phone(s,TRUE)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_employer(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_employer(SALT311.StrType s) := WHICH(~Scrubs_Thrive.Functions.fn_chk_employer(s)>0);
EXPORT InValidMessageFT_invalid_employer(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_chk_employer'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs_Thrive.Functions.fn_invalid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Thrive.Functions.fn_invalid_date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_fname','orig_lname','orig_addr','orig_city','orig_zip4','orig_state','orig_zip5','email','phone','employer','dt');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_fname','orig_lname','orig_addr','orig_city','orig_zip4','orig_state','orig_zip5','email','phone','employer','dt');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'orig_fname' => 0,'orig_lname' => 1,'orig_addr' => 2,'orig_city' => 3,'orig_zip4' => 4,'orig_state' => 5,'orig_zip5' => 6,'email' => 7,'phone' => 8,'employer' => 9,'dt' => 10,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_orig_fname(SALT311.StrType s0) := MakeFT_invalid_fname(s0);
EXPORT InValid_orig_fname(SALT311.StrType s,SALT311.StrType orig_fname,SALT311.StrType orig_lname) := InValidFT_invalid_fname(s,orig_fname,orig_lname);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_fname(wh);
 
EXPORT Make_orig_lname(SALT311.StrType s0) := MakeFT_invalid_lname(s0);
EXPORT InValid_orig_lname(SALT311.StrType s,SALT311.StrType orig_fname,SALT311.StrType orig_lname) := InValidFT_invalid_lname(s,orig_fname,orig_lname);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_lname(wh);
 
EXPORT Make_orig_addr(SALT311.StrType s0) := MakeFT_invalid_addr(s0);
EXPORT InValid_orig_addr(SALT311.StrType s) := InValidFT_invalid_addr(s);
EXPORT InValidMessage_orig_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_addr(wh);
 
EXPORT Make_orig_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_orig_city(SALT311.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_orig_zip4(SALT311.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_orig_zip4(SALT311.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_orig_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_orig_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_orig_zip5(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_orig_zip5(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_orig_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
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
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_addr;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_zip4;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip5;
    BOOLEAN Diff_email;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_employer;
    BOOLEAN Diff_dt;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_addr := le.orig_addr <> ri.orig_addr;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_zip4 := le.orig_zip4 <> ri.orig_zip4;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip5 := le.orig_zip5 <> ri.orig_zip5;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_employer := le.employer <> ri.employer;
    SELF.Diff_dt := le.dt <> ri.dt;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_addr,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_zip4,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip5,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_employer,1,0)+ IF( SELF.Diff_dt,1,0);
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
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_addr := COUNT(GROUP,%Closest%.Diff_orig_addr);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_zip4 := COUNT(GROUP,%Closest%.Diff_orig_zip4);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip5 := COUNT(GROUP,%Closest%.Diff_orig_zip5);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_employer := COUNT(GROUP,%Closest%.Diff_employer);
    Count_Diff_dt := COUNT(GROUP,%Closest%.Diff_dt);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
