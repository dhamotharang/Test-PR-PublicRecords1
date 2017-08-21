export Layout_Specificities := module
shared L := Layout_files().input.used;
export id_ChildRec := record
  typeof(l.id) id;
  unsigned8 cnt;
  unsigned4 id;
end;
export fname_ChildRec := record
  typeof(l.fname) fname;
  unsigned8 cnt;
  unsigned4 id;
end;
export lname_ChildRec := record
  typeof(l.lname) lname;
  unsigned8 cnt;
  unsigned4 id;
end;
export dob_ChildRec := record
  typeof(l.dob) dob;
  unsigned8 cnt;
  unsigned4 id;
end;
export Own_Home_ChildRec := record
  typeof(l.Own_Home) Own_Home;
  unsigned8 cnt;
  unsigned4 id;
end;
export dlnum_ChildRec := record
  typeof(l.dlnum) dlnum;
  unsigned8 cnt;
  unsigned4 id;
end;
export State_Of_License_ChildRec := record
  typeof(l.State_Of_License) State_Of_License;
  unsigned8 cnt;
  unsigned4 id;
end;
export addr_ChildRec := record
  typeof(l.addr) addr;
  unsigned8 cnt;
  unsigned4 id;
end;
export city_ChildRec := record
  typeof(l.city) city;
  unsigned8 cnt;
  unsigned4 id;
end;
export st_ChildRec := record
  typeof(l.st) st;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export Phone_Home_ChildRec := record
  typeof(l.Phone_Home) Phone_Home;
  unsigned8 cnt;
  unsigned4 id;
end;
export Phone_Cell_ChildRec := record
  typeof(l.Phone_Cell) Phone_Cell;
  unsigned8 cnt;
  unsigned4 id;
end;
export Phone_Work_ChildRec := record
  typeof(l.Phone_Work) Phone_Work;
  unsigned8 cnt;
  unsigned4 id;
end;
export EMAIL_ChildRec := record
  typeof(l.EMAIL) EMAIL;
  unsigned8 cnt;
  unsigned4 id;
end;
export ip_ChildRec := record
  typeof(l.ip) ip;
  unsigned8 cnt;
  unsigned4 id;
end;
export dt_ChildRec := record
  typeof(l.dt) dt;
  unsigned8 cnt;
  unsigned4 id;
end;
export INCOME_MONTHLY_ChildRec := record
  typeof(l.INCOME_MONTHLY) INCOME_MONTHLY;
  unsigned8 cnt;
  unsigned4 id;
end;
export Weekly_BiWeekly_ChildRec := record
  typeof(l.Weekly_BiWeekly) Weekly_BiWeekly;
  unsigned8 cnt;
  unsigned4 id;
end;
export MONTHSEMPLOYED_ChildRec := record
  typeof(l.MONTHSEMPLOYED) MONTHSEMPLOYED;
  unsigned8 cnt;
  unsigned4 id;
end;
export MonthsAtBank_ChildRec := record
  typeof(l.MonthsAtBank) MonthsAtBank;
  unsigned8 cnt;
  unsigned4 id;
end;
export employer_ChildRec := record
  typeof(l.employer) employer;
  unsigned8 cnt;
  unsigned4 id;
end;
export Bank_ChildRec := record
  typeof(l.Bank) Bank;
  unsigned8 cnt;
  unsigned4 id;
end;
export R := RECORD,MAXLENGTH(32000)
 unsigned1 dummy;
  real4 id_specificity;
  real4 id_switch;
  real4 id_max;
  dataset(id_ChildRec) nulls_id {MAXCOUNT(100)};
  real4 fname_specificity;
  real4 fname_switch;
  real4 fname_max;
  dataset(fname_ChildRec) nulls_fname {MAXCOUNT(100)};
  real4 lname_specificity;
  real4 lname_switch;
  real4 lname_max;
  dataset(lname_ChildRec) nulls_lname {MAXCOUNT(100)};
  real4 dob_specificity;
  real4 dob_switch;
  real4 dob_max;
  dataset(dob_ChildRec) nulls_dob {MAXCOUNT(100)};
  real4 Own_Home_specificity;
  real4 Own_Home_switch;
  real4 Own_Home_max;
  dataset(Own_Home_ChildRec) nulls_Own_Home {MAXCOUNT(100)};
  real4 dlnum_specificity;
  real4 dlnum_switch;
  real4 dlnum_max;
  dataset(dlnum_ChildRec) nulls_dlnum {MAXCOUNT(100)};
  real4 State_Of_License_specificity;
  real4 State_Of_License_switch;
  real4 State_Of_License_max;
  dataset(State_Of_License_ChildRec) nulls_State_Of_License {MAXCOUNT(100)};
  real4 addr_specificity;
  real4 addr_switch;
  real4 addr_max;
  dataset(addr_ChildRec) nulls_addr {MAXCOUNT(100)};
  real4 city_specificity;
  real4 city_switch;
  real4 city_max;
  dataset(city_ChildRec) nulls_city {MAXCOUNT(100)};
  real4 st_specificity;
  real4 st_switch;
  real4 st_max;
  dataset(st_ChildRec) nulls_st {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 Phone_Home_specificity;
  real4 Phone_Home_switch;
  real4 Phone_Home_max;
  dataset(Phone_Home_ChildRec) nulls_Phone_Home {MAXCOUNT(100)};
  real4 Phone_Cell_specificity;
  real4 Phone_Cell_switch;
  real4 Phone_Cell_max;
  dataset(Phone_Cell_ChildRec) nulls_Phone_Cell {MAXCOUNT(100)};
  real4 Phone_Work_specificity;
  real4 Phone_Work_switch;
  real4 Phone_Work_max;
  dataset(Phone_Work_ChildRec) nulls_Phone_Work {MAXCOUNT(100)};
  real4 EMAIL_specificity;
  real4 EMAIL_switch;
  real4 EMAIL_max;
  dataset(EMAIL_ChildRec) nulls_EMAIL {MAXCOUNT(100)};
  real4 ip_specificity;
  real4 ip_switch;
  real4 ip_max;
  dataset(ip_ChildRec) nulls_ip {MAXCOUNT(100)};
  real4 dt_specificity;
  real4 dt_switch;
  real4 dt_max;
  dataset(dt_ChildRec) nulls_dt {MAXCOUNT(100)};
  real4 INCOME_MONTHLY_specificity;
  real4 INCOME_MONTHLY_switch;
  real4 INCOME_MONTHLY_max;
  dataset(INCOME_MONTHLY_ChildRec) nulls_INCOME_MONTHLY {MAXCOUNT(100)};
  real4 Weekly_BiWeekly_specificity;
  real4 Weekly_BiWeekly_switch;
  real4 Weekly_BiWeekly_max;
  dataset(Weekly_BiWeekly_ChildRec) nulls_Weekly_BiWeekly {MAXCOUNT(100)};
  real4 MONTHSEMPLOYED_specificity;
  real4 MONTHSEMPLOYED_switch;
  real4 MONTHSEMPLOYED_max;
  dataset(MONTHSEMPLOYED_ChildRec) nulls_MONTHSEMPLOYED {MAXCOUNT(100)};
  real4 MonthsAtBank_specificity;
  real4 MonthsAtBank_switch;
  real4 MonthsAtBank_max;
  dataset(MonthsAtBank_ChildRec) nulls_MonthsAtBank {MAXCOUNT(100)};
  real4 employer_specificity;
  real4 employer_switch;
  real4 employer_max;
  dataset(employer_ChildRec) nulls_employer {MAXCOUNT(100)};
  real4 Bank_specificity;
  real4 Bank_switch;
  real4 Bank_max;
  dataset(Bank_ChildRec) nulls_Bank {MAXCOUNT(100)};
end;
end;
