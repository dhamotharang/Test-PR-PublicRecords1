export Layout_Specificities := module
shared L := Layout_files().input.used;
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
export state_ChildRec := record
  typeof(l.state) state;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip_ChildRec := record
  typeof(l.zip) zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export zip4_ChildRec := record
  typeof(l.zip4) zip4;
  unsigned8 cnt;
  unsigned4 id;
end;
export EMAIL_ChildRec := record
  typeof(l.EMAIL) EMAIL;
  unsigned8 cnt;
  unsigned4 id;
end;
export phone_ChildRec := record
  typeof(l.phone) phone;
  unsigned8 cnt;
  unsigned4 id;
end;
export LoanType_ChildRec := record
  typeof(l.LoanType) LoanType;
  unsigned8 cnt;
  unsigned4 id;
end;
export BESTTIME_ChildRec := record
  typeof(l.BESTTIME) BESTTIME;
  unsigned8 cnt;
  unsigned4 id;
end;
export MortRate_ChildRec := record
  typeof(l.MortRate) MortRate;
  unsigned8 cnt;
  unsigned4 id;
end;
export PROPERTYTYPE_ChildRec := record
  typeof(l.PROPERTYTYPE) PROPERTYTYPE;
  unsigned8 cnt;
  unsigned4 id;
end;
export RateType_ChildRec := record
  typeof(l.RateType) RateType;
  unsigned8 cnt;
  unsigned4 id;
end;
export LTV_ChildRec := record
  typeof(l.LTV) LTV;
  unsigned8 cnt;
  unsigned4 id;
end;
export YrsThere_ChildRec := record
  typeof(l.YrsThere) YrsThere;
  unsigned8 cnt;
  unsigned4 id;
end;
export employer_ChildRec := record
  typeof(l.employer) employer;
  unsigned8 cnt;
  unsigned4 id;
end;
export credit_ChildRec := record
  typeof(l.credit) credit;
  unsigned8 cnt;
  unsigned4 id;
end;
export Income_ChildRec := record
  typeof(l.Income) Income;
  unsigned8 cnt;
  unsigned4 id;
end;
export LoanAmt_ChildRec := record
  typeof(l.LoanAmt) LoanAmt;
  unsigned8 cnt;
  unsigned4 id;
end;
export dt_ChildRec := record
  typeof(l.dt) dt;
  unsigned8 cnt;
  unsigned4 id;
end;
export ip_ChildRec := record
  typeof(l.ip) ip;
  unsigned8 cnt;
  unsigned4 id;
end;
export R := RECORD,MAXLENGTH(32000)
 unsigned1 dummy;
  real4 fname_specificity;
  real4 fname_switch;
  real4 fname_max;
  dataset(fname_ChildRec) nulls_fname {MAXCOUNT(100)};
  real4 lname_specificity;
  real4 lname_switch;
  real4 lname_max;
  dataset(lname_ChildRec) nulls_lname {MAXCOUNT(100)};
  real4 addr_specificity;
  real4 addr_switch;
  real4 addr_max;
  dataset(addr_ChildRec) nulls_addr {MAXCOUNT(100)};
  real4 city_specificity;
  real4 city_switch;
  real4 city_max;
  dataset(city_ChildRec) nulls_city {MAXCOUNT(100)};
  real4 state_specificity;
  real4 state_switch;
  real4 state_max;
  dataset(state_ChildRec) nulls_state {MAXCOUNT(100)};
  real4 zip_specificity;
  real4 zip_switch;
  real4 zip_max;
  dataset(zip_ChildRec) nulls_zip {MAXCOUNT(100)};
  real4 zip4_specificity;
  real4 zip4_switch;
  real4 zip4_max;
  dataset(zip4_ChildRec) nulls_zip4 {MAXCOUNT(100)};
  real4 EMAIL_specificity;
  real4 EMAIL_switch;
  real4 EMAIL_max;
  dataset(EMAIL_ChildRec) nulls_EMAIL {MAXCOUNT(100)};
  real4 phone_specificity;
  real4 phone_switch;
  real4 phone_max;
  dataset(phone_ChildRec) nulls_phone {MAXCOUNT(100)};
  real4 LoanType_specificity;
  real4 LoanType_switch;
  real4 LoanType_max;
  dataset(LoanType_ChildRec) nulls_LoanType {MAXCOUNT(100)};
  real4 BESTTIME_specificity;
  real4 BESTTIME_switch;
  real4 BESTTIME_max;
  dataset(BESTTIME_ChildRec) nulls_BESTTIME {MAXCOUNT(100)};
  real4 MortRate_specificity;
  real4 MortRate_switch;
  real4 MortRate_max;
  dataset(MortRate_ChildRec) nulls_MortRate {MAXCOUNT(100)};
  real4 PROPERTYTYPE_specificity;
  real4 PROPERTYTYPE_switch;
  real4 PROPERTYTYPE_max;
  dataset(PROPERTYTYPE_ChildRec) nulls_PROPERTYTYPE {MAXCOUNT(100)};
  real4 RateType_specificity;
  real4 RateType_switch;
  real4 RateType_max;
  dataset(RateType_ChildRec) nulls_RateType {MAXCOUNT(100)};
  real4 LTV_specificity;
  real4 LTV_switch;
  real4 LTV_max;
  dataset(LTV_ChildRec) nulls_LTV {MAXCOUNT(100)};
  real4 YrsThere_specificity;
  real4 YrsThere_switch;
  real4 YrsThere_max;
  dataset(YrsThere_ChildRec) nulls_YrsThere {MAXCOUNT(100)};
  real4 employer_specificity;
  real4 employer_switch;
  real4 employer_max;
  dataset(employer_ChildRec) nulls_employer {MAXCOUNT(100)};
  real4 credit_specificity;
  real4 credit_switch;
  real4 credit_max;
  dataset(credit_ChildRec) nulls_credit {MAXCOUNT(100)};
  real4 Income_specificity;
  real4 Income_switch;
  real4 Income_max;
  dataset(Income_ChildRec) nulls_Income {MAXCOUNT(100)};
  real4 LoanAmt_specificity;
  real4 LoanAmt_switch;
  real4 LoanAmt_max;
  dataset(LoanAmt_ChildRec) nulls_LoanAmt {MAXCOUNT(100)};
  real4 dt_specificity;
  real4 dt_switch;
  real4 dt_max;
  dataset(dt_ChildRec) nulls_dt {MAXCOUNT(100)};
  real4 ip_specificity;
  real4 ip_switch;
  real4 ip_max;
  dataset(ip_ChildRec) nulls_ip {MAXCOUNT(100)};
end;
end;
