export people := dataset('people', record
integer8     id;
integer8	 did;
integer8     ssn;
string13     dl_number;
integer8	 total_weight;
string20     fname;
string1      mname;
string20     lname;
string8		 dob;
unsigned4    prim_range;
string28     prim_name;
string8		 sec_range;
unsigned4    zip;
integer1	 num_relatives;
string1		 apt_address;
string1      va_ssn;
string1      va_current_address;

  integer2 early_ssn;
  integer2 late_ssn;
  integer2 ssn_usage_count;
  string20 mcu_fname;
  string20 mcu_lname;
  string1  deceased;
unsigned integer8 holepos
  end, hole );