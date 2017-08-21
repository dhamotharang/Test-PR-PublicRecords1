export Delta := MODULE//Routines to compute the differences between two instances of a file
export Differences(dataset(Layout_files().input.used)old_s, dataset(Layout_files().input.used) new_s) := function
  Diff_Layout := RECORD(layout_files().input.used)
    boolean  Added;
    boolean Deleted;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := transform
    boolean left_null := le.fname=(typeof(le.fname))'' AND le.lname=(typeof(le.lname))'' AND le.addr=(typeof(le.addr))'' AND le.city=(typeof(le.city))'' AND le.state=(typeof(le.state))'' AND le.zip=(typeof(le.zip))'' AND le.zip4=(typeof(le.zip4))'' AND le.EMAIL=(typeof(le.EMAIL))'' AND le.phone=(typeof(le.phone))'' AND le.LoanType=(typeof(le.LoanType))'' AND le.BESTTIME=(typeof(le.BESTTIME))'' AND le.MortRate=(typeof(le.MortRate))'' AND le.PROPERTYTYPE=(typeof(le.PROPERTYTYPE))'' AND le.RateType=(typeof(le.RateType))'' AND le.LTV=(typeof(le.LTV))'' AND le.YrsThere=(typeof(le.YrsThere))'' AND le.employer=(typeof(le.employer))'' AND le.credit=(typeof(le.credit))'' AND le.Income=(typeof(le.Income))'' AND le.LoanAmt=(typeof(le.LoanAmt))'' AND le.dt=(typeof(le.dt))'' AND le.ip=(typeof(le.ip))'';
    boolean right_null := ri.fname=(typeof(ri.fname))'' AND ri.lname=(typeof(ri.lname))'' AND ri.addr=(typeof(ri.addr))'' AND ri.city=(typeof(ri.city))'' AND ri.state=(typeof(ri.state))'' AND ri.zip=(typeof(ri.zip))'' AND ri.zip4=(typeof(ri.zip4))'' AND ri.EMAIL=(typeof(ri.EMAIL))'' AND ri.phone=(typeof(ri.phone))'' AND ri.LoanType=(typeof(ri.LoanType))'' AND ri.BESTTIME=(typeof(ri.BESTTIME))'' AND ri.MortRate=(typeof(ri.MortRate))'' AND ri.PROPERTYTYPE=(typeof(ri.PROPERTYTYPE))'' AND ri.RateType=(typeof(ri.RateType))'' AND ri.LTV=(typeof(ri.LTV))'' AND ri.YrsThere=(typeof(ri.YrsThere))'' AND ri.employer=(typeof(ri.employer))'' AND ri.credit=(typeof(ri.credit))'' AND ri.Income=(typeof(ri.Income))'' AND ri.LoanAmt=(typeof(ri.LoanAmt))'' AND ri.dt=(typeof(ri.dt))'' AND ri.ip=(typeof(ri.ip))'';
    self.Added := left_null;
    self.Deleted := right_null;
    self := if ( right_null, le, ri );
  end;
  return join(old_s,new_s,left.fname=right.fname AND left.lname=right.lname AND left.addr=right.addr AND left.city=right.city AND left.state=right.state AND left.zip=right.zip AND left.zip4=right.zip4 AND left.EMAIL=right.EMAIL AND left.phone=right.phone AND left.LoanType=right.LoanType AND left.BESTTIME=right.BESTTIME AND left.MortRate=right.MortRate AND left.PROPERTYTYPE=right.PROPERTYTYPE AND left.RateType=right.RateType AND left.LTV=right.LTV AND left.YrsThere=right.YrsThere AND left.employer=right.employer AND left.credit=right.credit AND left.Income=right.Income AND left.LoanAmt=right.LoanAmt AND left.dt=right.dt AND left.ip=right.ip,Take_Record(left,right),hash,full outer)(Added OR Deleted);
end;
export Difference_Summary(dataset(Layout_files().input.used)old_s, dataset(Layout_files().input.used) new_s) := function
  d := Differences(old_s,new_s);
  return  hygiene(old_s).Summary('Old')+ hygiene(new_s).Summary('New')+ hygiene(d(deleted)).Summary('Deletions')+ hygiene(d(added)).Summary('Additions');
end;
end;
