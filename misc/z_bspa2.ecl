import ut,doxie_files,doxie_build,lib_stringlib;
import did_add,  didville;
import address;
//
import header;
import header_quick;
import risk_indicators;
import watchdog;
import utilfile;


my_layout := record
unsigned6    did := 0;
qstring10    phone := '';
qstring9     ssn := '';
integer4     dob := 0;
qstring5     title := '';
qstring20    fname := '';
qstring20    mname := '';
qstring20    lname := '';
qstring5     name_suffix := '';
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
qstring8	 DOD := '';
end;

my_layout to_get_my_stuff(watchdog.file_best l, misc._bspa r) := transform
self := l;
end;

my_stuff := join(watchdog.File_Best, misc._bspa, left.did=right.did, to_get_my_stuff(left,right),lookup);

output(my_stuff);
