import ut,SALT20;
export Fields := MODULE
//Individual field level validation
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
export InValid_state(string s) := WHICH();
export InValidMessage_state(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_state(string s0) := FUNCTION
return s0;
end;
export InValid_zip(string s) := WHICH();
export InValidMessage_zip(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_zip(string s0) := FUNCTION
return s0;
end;
export InValid_zip4(string s) := WHICH();
export InValidMessage_zip4(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_zip4(string s0) := FUNCTION
return s0;
end;
export InValid_EMAIL(string s) := WHICH();
export InValidMessage_EMAIL(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_EMAIL(string s0) := FUNCTION
return s0;
end;
export InValid_phone(string s) := WHICH();
export InValidMessage_phone(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_phone(string s0) := FUNCTION
return s0;
end;
export InValid_LoanType(string s) := WHICH();
export InValidMessage_LoanType(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_LoanType(string s0) := FUNCTION
return s0;
end;
export InValid_BESTTIME(string s) := WHICH();
export InValidMessage_BESTTIME(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_BESTTIME(string s0) := FUNCTION
return s0;
end;
export InValid_MortRate(string s) := WHICH();
export InValidMessage_MortRate(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_MortRate(string s0) := FUNCTION
return s0;
end;
export InValid_PROPERTYTYPE(string s) := WHICH();
export InValidMessage_PROPERTYTYPE(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_PROPERTYTYPE(string s0) := FUNCTION
return s0;
end;
export InValid_RateType(string s) := WHICH();
export InValidMessage_RateType(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_RateType(string s0) := FUNCTION
return s0;
end;
export InValid_LTV(string s) := WHICH();
export InValidMessage_LTV(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_LTV(string s0) := FUNCTION
return s0;
end;
export InValid_YrsThere(string s) := WHICH();
export InValidMessage_YrsThere(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_YrsThere(string s0) := FUNCTION
return s0;
end;
export InValid_employer(string s) := WHICH();
export InValidMessage_employer(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_employer(string s0) := FUNCTION
return s0;
end;
export InValid_credit(string s) := WHICH();
export InValidMessage_credit(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_credit(string s0) := FUNCTION
return s0;
end;
export InValid_Income(string s) := WHICH();
export InValidMessage_Income(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_Income(string s0) := FUNCTION
return s0;
end;
export InValid_LoanAmt(string s) := WHICH();
export InValidMessage_LoanAmt(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_LoanAmt(string s0) := FUNCTION
return s0;
end;
export InValid_dt(string s) := WHICH();
export InValidMessage_dt(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_dt(string s0) := FUNCTION
return s0;
end;
export InValid_ip(string s) := WHICH();
export InValidMessage_ip(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.Good);
export Make_ip(string s0) := FUNCTION
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
    BOOLEAN Diff_fname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_addr;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_EMAIL;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_LoanType;
    BOOLEAN Diff_BESTTIME;
    BOOLEAN Diff_MortRate;
    BOOLEAN Diff_PROPERTYTYPE;
    BOOLEAN Diff_RateType;
    BOOLEAN Diff_LTV;
    BOOLEAN Diff_YrsThere;
    BOOLEAN Diff_employer;
    BOOLEAN Diff_credit;
    BOOLEAN Diff_Income;
    BOOLEAN Diff_LoanAmt;
    BOOLEAN Diff_dt;
    BOOLEAN Diff_ip;
    UNSIGNED Num_Diffs;
    STRING Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_addr := le.addr <> ri.addr;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_EMAIL := le.EMAIL <> ri.EMAIL;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_LoanType := le.LoanType <> ri.LoanType;
    SELF.Diff_BESTTIME := le.BESTTIME <> ri.BESTTIME;
    SELF.Diff_MortRate := le.MortRate <> ri.MortRate;
    SELF.Diff_PROPERTYTYPE := le.PROPERTYTYPE <> ri.PROPERTYTYPE;
    SELF.Diff_RateType := le.RateType <> ri.RateType;
    SELF.Diff_LTV := le.LTV <> ri.LTV;
    SELF.Diff_YrsThere := le.YrsThere <> ri.YrsThere;
    SELF.Diff_employer := le.employer <> ri.employer;
    SELF.Diff_credit := le.credit <> ri.credit;
    SELF.Diff_Income := le.Income <> ri.Income;
    SELF.Diff_LoanAmt := le.LoanAmt <> ri.LoanAmt;
    SELF.Diff_dt := le.dt <> ri.dt;
    SELF.Diff_ip := le.ip <> ri.ip;
    SELF.Val := (STRING)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_addr,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_EMAIL,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_LoanType,1,0)+ IF( SELF.Diff_BESTTIME,1,0)+ IF( SELF.Diff_MortRate,1,0)+ IF( SELF.Diff_PROPERTYTYPE,1,0)+ IF( SELF.Diff_RateType,1,0)+ IF( SELF.Diff_LTV,1,0)+ IF( SELF.Diff_YrsThere,1,0)+ IF( SELF.Diff_employer,1,0)+ IF( SELF.Diff_credit,1,0)+ IF( SELF.Diff_Income,1,0)+ IF( SELF.Diff_LoanAmt,1,0)+ IF( SELF.Diff_dt,1,0)+ IF( SELF.Diff_ip,1,0);
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
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_addr := COUNT(GROUP,%Closest%.Diff_addr);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_EMAIL := COUNT(GROUP,%Closest%.Diff_EMAIL);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_LoanType := COUNT(GROUP,%Closest%.Diff_LoanType);
    Count_Diff_BESTTIME := COUNT(GROUP,%Closest%.Diff_BESTTIME);
    Count_Diff_MortRate := COUNT(GROUP,%Closest%.Diff_MortRate);
    Count_Diff_PROPERTYTYPE := COUNT(GROUP,%Closest%.Diff_PROPERTYTYPE);
    Count_Diff_RateType := COUNT(GROUP,%Closest%.Diff_RateType);
    Count_Diff_LTV := COUNT(GROUP,%Closest%.Diff_LTV);
    Count_Diff_YrsThere := COUNT(GROUP,%Closest%.Diff_YrsThere);
    Count_Diff_employer := COUNT(GROUP,%Closest%.Diff_employer);
    Count_Diff_credit := COUNT(GROUP,%Closest%.Diff_credit);
    Count_Diff_Income := COUNT(GROUP,%Closest%.Diff_Income);
    Count_Diff_LoanAmt := COUNT(GROUP,%Closest%.Diff_LoanAmt);
    Count_Diff_dt := COUNT(GROUP,%Closest%.Diff_dt);
    Count_Diff_ip := COUNT(GROUP,%Closest%.Diff_ip);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
