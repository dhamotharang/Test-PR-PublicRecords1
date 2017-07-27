import AID;
export layout_best := module

export lscored := record

  unsigned6 did;
  unsigned3 dt_last_seen;
  unsigned3 dt_first_seen;
  integer4 daterank := 0;
  qstring20 fname;
  integer4 fcnt := 0;
  integer4 bfcnt := 0;
  qstring20 mname;
  integer4 mcnt := 0;
  integer4 bmcnt := 0;
  qstring20 lname;
  integer4 lcnt := 0;
  integer4 blcnt := 0;
  qstring9 ssn;
  integer8 scnt := 0;
  integer4 bscnt := 0;
  integer4 dob;
  integer4 dcnt := 0;
	integer4 bdcnt := 0;
	qstring10 phone;
	integer4 pcnt := 0;
	integer4 bpcnt := 0;
  string46 addr1;
  string18 addr2;
  qstring10 prim_range;
  qstring28 prim_name;
	string2   predir;
  string2   postdir;
  qstring10 unit_desig;
  qstring4 suffix;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  unsigned8 rawaid;
  boolean poor_addr;
  integer4 acnt := 0;
  integer4 bacnt := 0;
  integer4 fname_score := 0;
	integer4 mname_score := 0;
  integer4 lname_score := 0;
  integer4 ssn_score := 0;
  integer4 dob_score := 0;
	integer4 phone_score := 0;
  integer4 addr_score := 0;

 END;

export lbest := record

unsigned6    did := 0;
qstring10    phone := '';
qstring9     ssn := '';
integer4     dob := 0;
qstring20    fname := '';
qstring20    mname := '';
qstring20    lname := '';
qstring10    prim_range := '';
string2      predir := '';
qstring28    prim_name := '';
qstring4     suffix := '';
string2      postdir := '';
qstring10    unit_desig := '';
qstring8     sec_range := '';
qstring25    city_name := '';
string2      st := '';
qstring5     zip := '';
qstring4     zip4 := '';
unsigned3    addr_dt_last_seen := 0;
AID.Common.xAID	RawAID:=0;
unsigned3    addr_dt_first_seen := 0;

end;

end;