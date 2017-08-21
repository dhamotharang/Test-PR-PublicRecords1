import fcra;

/*RECORD
  unsigned6 s_did;
  string13 uid;
  string8 date_created;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string12 did;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string9 ssn;
  string8 dob;
  string2 predir;
  string28 prim_name;
  string10 prim_range;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string4 zip4;
  string51 address;
  string30 city_name;
  string2 st;
  string9 zip;
  string10 phone;
  string20 dl_number;
  string2 dl_state;
  unsigned8 __internal_fpos__;
 END;*/
 
 layout_key_out := RECORD
  unsigned6 s_did;
  string13 uid;
  string8 date_created;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string12 did;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string9 ssn;
  string8 dob;
  string2 predir;
  string28 prim_name;
  string10 prim_range;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string4 zip4;
  string51 address;
  string30 city_name;
  string2 st;
  string9 zip;
  string10 phone;
  string20 dl_number;
  string2 dl_state;
  //unsigned8 __internal_fpos__;
	END;

 key_in :=  fcra.key_fcra_override_pii_did;

 //transform statement
layout_key_out makerecord (key_in L) := transform
self.s_did := L.s_did;
self.uid := L.uid;
self.date_created := L.date_created;
self.dt_first_seen := L.dt_first_seen;
self.dt_last_seen := L.dt_last_seen;
self.did := L.did;
self.fname := L.fname;
self.mname := L.mname;
self.lname := L.lname;
self.name_suffix := L.name_suffix;
self.ssn := L.ssn;
self.dob := L.dob;
self.predir := L.predir;
self.prim_name := L.prim_name;
self.prim_range := L.prim_range;
self.suffix := L.suffix;
self.postdir := L.postdir;
self.unit_desig := L.unit_desig;
self.sec_range := L.sec_range;
self.zip4 := L.zip4;
self.address := L.address;
self.city_name := L.city_name;
self.st := L.st;
self.zip := L.zip;
self.phone := L.phone;
self.dl_number := L.dl_number;
self.dl_state := L.dl_state;
//unsigned8 __internal_fpos__;
END;




EXPORT file_Key_fcra_override_pii_did := project(key_in,makerecord(left));