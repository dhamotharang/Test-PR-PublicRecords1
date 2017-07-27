export Layout_MatchCandidates := record
unsigned6 did;
unsigned6 rid; // Needed if we are going to start see HOW these rules are being triggered
qstring18 vendor_id;
qstring9 ssn;
STRING1 valid_ssn;
STRING9 best_ssn := '';
integer4 dob;
STRING1 jflag1;
integer4 best_dob := 0;
qstring10	phone;
qstring20 fname;
qstring20 lname;
qstring20 mname;
qstring5 name_suffix;
qstring10 prim_range;
qstring28 prim_name;
qstring5 zip;
string2 st;
qstring25 city_name;
qstring8 sec_range;
unsigned3	dt_last_seen;
boolean good_ssn := false;
integer1 good_nmaddr := 0;
unsigned1 rare_name := 255;
unsigned1 head_cnt;
boolean prim_range_fraction := false;
  end;