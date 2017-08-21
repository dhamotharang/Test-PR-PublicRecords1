import ut,SALT20;
export Fields := MODULE
//Individual field level validation
export InValid_id(string s) := WHICH();
export InValidMessage_id(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_id(string s0) := FUNCTION
return s0;
end;
export InValid_fname(string s) := WHICH();
export InValidMessage_fname(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_fname(string s0) := FUNCTION
return s0;
end;
export InValid_lname(string s) := WHICH();
export InValidMessage_lname(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_lname(string s0) := FUNCTION
return s0;
end;
export InValid_dob(string s) := WHICH();
export InValidMessage_dob(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dob(string s0) := FUNCTION
return s0;
end;
export InValid_Own_Home(string s) := WHICH();
export InValidMessage_Own_Home(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_Own_Home(string s0) := FUNCTION
return s0;
end;
export InValid_dlnum(string s) := WHICH();
export InValidMessage_dlnum(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dlnum(string s0) := FUNCTION
return s0;
end;
export InValid_State_Of_License(string s) := WHICH();
export InValidMessage_State_Of_License(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_State_Of_License(string s0) := FUNCTION
return s0;
end;
export InValid_addr(string s) := WHICH();
export InValidMessage_addr(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_addr(string s0) := FUNCTION
return s0;
end;
export InValid_city(string s) := WHICH();
export InValidMessage_city(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_city(string s0) := FUNCTION
return s0;
end;
export InValid_st(string s) := WHICH();
export InValidMessage_st(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_st(string s0) := FUNCTION
return s0;
end;
export InValid_zip(string s) := WHICH();
export InValidMessage_zip(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_zip(string s0) := FUNCTION
return s0;
end;
export InValid_Phone_Home(string s) := WHICH();
export InValidMessage_Phone_Home(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_Phone_Home(string s0) := FUNCTION
return s0;
end;
export InValid_Phone_Cell(string s) := WHICH();
export InValidMessage_Phone_Cell(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_Phone_Cell(string s0) := FUNCTION
return s0;
end;
export InValid_Phone_Work(string s) := WHICH();
export InValidMessage_Phone_Work(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_Phone_Work(string s0) := FUNCTION
return s0;
end;
export InValid_EMAIL(string s) := WHICH();
export InValidMessage_EMAIL(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_EMAIL(string s0) := FUNCTION
return s0;
end;
export InValid_ip(string s) := WHICH();
export InValidMessage_ip(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_ip(string s0) := FUNCTION
return s0;
end;
export InValid_dt(string s) := WHICH();
export InValidMessage_dt(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dt(string s0) := FUNCTION
return s0;
end;
export InValid_INCOME_MONTHLY(string s) := WHICH();
export InValidMessage_INCOME_MONTHLY(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_INCOME_MONTHLY(string s0) := FUNCTION
return s0;
end;
export InValid_Weekly_BiWeekly(string s) := WHICH();
export InValidMessage_Weekly_BiWeekly(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_Weekly_BiWeekly(string s0) := FUNCTION
return s0;
end;
export InValid_MONTHSEMPLOYED(string s) := WHICH();
export InValidMessage_MONTHSEMPLOYED(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_MONTHSEMPLOYED(string s0) := FUNCTION
return s0;
end;
export InValid_MonthsAtBank(string s) := WHICH();
export InValidMessage_MonthsAtBank(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_MonthsAtBank(string s0) := FUNCTION
return s0;
end;
export InValid_employer(string s) := WHICH();
export InValidMessage_employer(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_employer(string s0) := FUNCTION
return s0;
end;
export InValid_Bank(string s) := WHICH();
export InValidMessage_Bank(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_Bank(string s0) := FUNCTION
return s0;
end;
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
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
    BOOLEAN Diff_id;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_Own_Home;
    BOOLEAN Diff_dlnum;
    BOOLEAN Diff_State_Of_License;
    BOOLEAN Diff_addr;
    BOOLEAN Diff_city;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_Phone_Home;
    BOOLEAN Diff_Phone_Cell;
    BOOLEAN Diff_Phone_Work;
    BOOLEAN Diff_EMAIL;
    BOOLEAN Diff_ip;
    BOOLEAN Diff_dt;
    BOOLEAN Diff_INCOME_MONTHLY;
    BOOLEAN Diff_Weekly_BiWeekly;
    BOOLEAN Diff_MONTHSEMPLOYED;
    BOOLEAN Diff_MonthsAtBank;
    BOOLEAN Diff_employer;
    BOOLEAN Diff_Bank;
    UNSIGNED Num_Diffs;
    STRING Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_id := le.id <> ri.id;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_Own_Home := le.Own_Home <> ri.Own_Home;
    SELF.Diff_dlnum := le.dlnum <> ri.dlnum;
    SELF.Diff_State_Of_License := le.State_Of_License <> ri.State_Of_License;
    SELF.Diff_addr := le.addr <> ri.addr;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_Phone_Home := le.Phone_Home <> ri.Phone_Home;
    SELF.Diff_Phone_Cell := le.Phone_Cell <> ri.Phone_Cell;
    SELF.Diff_Phone_Work := le.Phone_Work <> ri.Phone_Work;
    SELF.Diff_EMAIL := le.EMAIL <> ri.EMAIL;
    SELF.Diff_ip := le.ip <> ri.ip;
    SELF.Diff_dt := le.dt <> ri.dt;
    SELF.Diff_INCOME_MONTHLY := le.INCOME_MONTHLY <> ri.INCOME_MONTHLY;
    SELF.Diff_Weekly_BiWeekly := le.Weekly_BiWeekly <> ri.Weekly_BiWeekly;
    SELF.Diff_MONTHSEMPLOYED := le.MONTHSEMPLOYED <> ri.MONTHSEMPLOYED;
    SELF.Diff_MonthsAtBank := le.MonthsAtBank <> ri.MonthsAtBank;
    SELF.Diff_employer := le.employer <> ri.employer;
    SELF.Diff_Bank := le.Bank <> ri.Bank;
    SELF.Val := (STRING)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_id,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_Own_Home,1,0)+ IF( SELF.Diff_dlnum,1,0)+ IF( SELF.Diff_State_Of_License,1,0)+ IF( SELF.Diff_addr,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_Phone_Home,1,0)+ IF( SELF.Diff_Phone_Cell,1,0)+ IF( SELF.Diff_Phone_Work,1,0)+ IF( SELF.Diff_EMAIL,1,0)+ IF( SELF.Diff_ip,1,0)+ IF( SELF.Diff_dt,1,0)+ IF( SELF.Diff_INCOME_MONTHLY,1,0)+ IF( SELF.Diff_Weekly_BiWeekly,1,0)+ IF( SELF.Diff_MONTHSEMPLOYED,1,0)+ IF( SELF.Diff_MonthsAtBank,1,0)+ IF( SELF.Diff_employer,1,0)+ IF( SELF.Diff_Bank,1,0);
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
    Count_Diff_id := COUNT(GROUP,%Closest%.Diff_id);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_Own_Home := COUNT(GROUP,%Closest%.Diff_Own_Home);
    Count_Diff_dlnum := COUNT(GROUP,%Closest%.Diff_dlnum);
    Count_Diff_State_Of_License := COUNT(GROUP,%Closest%.Diff_State_Of_License);
    Count_Diff_addr := COUNT(GROUP,%Closest%.Diff_addr);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_Phone_Home := COUNT(GROUP,%Closest%.Diff_Phone_Home);
    Count_Diff_Phone_Cell := COUNT(GROUP,%Closest%.Diff_Phone_Cell);
    Count_Diff_Phone_Work := COUNT(GROUP,%Closest%.Diff_Phone_Work);
    Count_Diff_EMAIL := COUNT(GROUP,%Closest%.Diff_EMAIL);
    Count_Diff_ip := COUNT(GROUP,%Closest%.Diff_ip);
    Count_Diff_dt := COUNT(GROUP,%Closest%.Diff_dt);
    Count_Diff_INCOME_MONTHLY := COUNT(GROUP,%Closest%.Diff_INCOME_MONTHLY);
    Count_Diff_Weekly_BiWeekly := COUNT(GROUP,%Closest%.Diff_Weekly_BiWeekly);
    Count_Diff_MONTHSEMPLOYED := COUNT(GROUP,%Closest%.Diff_MONTHSEMPLOYED);
    Count_Diff_MonthsAtBank := COUNT(GROUP,%Closest%.Diff_MonthsAtBank);
    Count_Diff_employer := COUNT(GROUP,%Closest%.Diff_employer);
    Count_Diff_Bank := COUNT(GROUP,%Closest%.Diff_Bank);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
