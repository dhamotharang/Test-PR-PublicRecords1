export Delta := MODULE//Routines to compute the differences between two instances of a file
export Differences(dataset(Layout_files().input.used)old_s, dataset(Layout_files().input.used) new_s) := function
  Diff_Layout := RECORD(layout_files().input.used)
    boolean  Added;
    boolean Deleted;
  END;
  Diff_Layout Take_Record(old_s le, new_s ri) := transform
    boolean left_null := le.id=(typeof(le.id))'' AND le.fname=(typeof(le.fname))'' AND le.lname=(typeof(le.lname))'' AND le.dob=(typeof(le.dob))'' AND le.Own_Home=(typeof(le.Own_Home))'' AND le.dlnum=(typeof(le.dlnum))'' AND le.State_Of_License=(typeof(le.State_Of_License))'' AND le.addr=(typeof(le.addr))'' AND le.city=(typeof(le.city))'' AND le.st=(typeof(le.st))'' AND le.zip=(typeof(le.zip))'' AND le.Phone_Home=(typeof(le.Phone_Home))'' AND le.Phone_Cell=(typeof(le.Phone_Cell))'' AND le.Phone_Work=(typeof(le.Phone_Work))'' AND le.EMAIL=(typeof(le.EMAIL))'' AND le.ip=(typeof(le.ip))'' AND le.dt=(typeof(le.dt))'' AND le.INCOME_MONTHLY=(typeof(le.INCOME_MONTHLY))'' AND le.Weekly_BiWeekly=(typeof(le.Weekly_BiWeekly))'' AND le.MONTHSEMPLOYED=(typeof(le.MONTHSEMPLOYED))'' AND le.MonthsAtBank=(typeof(le.MonthsAtBank))'' AND le.employer=(typeof(le.employer))'' AND le.Bank=(typeof(le.Bank))'';
    boolean right_null := ri.id=(typeof(ri.id))'' AND ri.fname=(typeof(ri.fname))'' AND ri.lname=(typeof(ri.lname))'' AND ri.dob=(typeof(ri.dob))'' AND ri.Own_Home=(typeof(ri.Own_Home))'' AND ri.dlnum=(typeof(ri.dlnum))'' AND ri.State_Of_License=(typeof(ri.State_Of_License))'' AND ri.addr=(typeof(ri.addr))'' AND ri.city=(typeof(ri.city))'' AND ri.st=(typeof(ri.st))'' AND ri.zip=(typeof(ri.zip))'' AND ri.Phone_Home=(typeof(ri.Phone_Home))'' AND ri.Phone_Cell=(typeof(ri.Phone_Cell))'' AND ri.Phone_Work=(typeof(ri.Phone_Work))'' AND ri.EMAIL=(typeof(ri.EMAIL))'' AND ri.ip=(typeof(ri.ip))'' AND ri.dt=(typeof(ri.dt))'' AND ri.INCOME_MONTHLY=(typeof(ri.INCOME_MONTHLY))'' AND ri.Weekly_BiWeekly=(typeof(ri.Weekly_BiWeekly))'' AND ri.MONTHSEMPLOYED=(typeof(ri.MONTHSEMPLOYED))'' AND ri.MonthsAtBank=(typeof(ri.MonthsAtBank))'' AND ri.employer=(typeof(ri.employer))'' AND ri.Bank=(typeof(ri.Bank))'';
    self.Added := left_null;
    self.Deleted := right_null;
    self := if ( right_null, le, ri );
  end;
  return join(old_s,new_s,left.id=right.id AND left.fname=right.fname AND left.lname=right.lname AND left.dob=right.dob AND left.Own_Home=right.Own_Home AND left.dlnum=right.dlnum AND left.State_Of_License=right.State_Of_License AND left.addr=right.addr AND left.city=right.city AND left.st=right.st AND left.zip=right.zip AND left.Phone_Home=right.Phone_Home AND left.Phone_Cell=right.Phone_Cell AND left.Phone_Work=right.Phone_Work AND left.EMAIL=right.EMAIL AND left.ip=right.ip AND left.dt=right.dt AND left.INCOME_MONTHLY=right.INCOME_MONTHLY AND left.Weekly_BiWeekly=right.Weekly_BiWeekly AND left.MONTHSEMPLOYED=right.MONTHSEMPLOYED AND left.MonthsAtBank=right.MonthsAtBank AND left.employer=right.employer AND left.Bank=right.Bank,Take_Record(left,right),hash,full outer)(Added OR Deleted);
end;
export Difference_Summary(dataset(Layout_files().input.used)old_s, dataset(Layout_files().input.used) new_s) := function
  d := Differences(old_s,new_s);
  return  hygiene(old_s).Summary('Old')+ hygiene(new_s).Summary('New')+ hygiene(d(deleted)).Summary('Deletions')+ hygiene(d(added)).Summary('Additions');
end;
end;
