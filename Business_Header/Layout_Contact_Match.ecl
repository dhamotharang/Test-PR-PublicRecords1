EXPORT Layout_Contact_Match := RECORD
unsigned6 uid;
unsigned6 bdid;
unsigned1 did_score := 0;
unsigned6 did := 0;
qstring20 fname;
qstring20 mname;
qstring20 lname;
qstring5  name_suffix;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
qstring5  zip;
string2   state;
qstring10 phone;
qstring9  ssn;
END;