import	Infutor, ut;

 inf := Infutor.infutor_header_filtered(true) : PERSIST('~thor::spokeo::persist::infutor_header');
 inf2 := DISTRIBUTE(inf(did<>0), did);
 hdr := SORT(inf2, did, prim_range, prim_name, zip, -sec_range, LOCAL);
 infh := ROLLUP(hdr,
								left.did=right.did AND
								left.prim_range=right.prim_range AND
								left.prim_name=right.prim_name AND
								left.zip=right.zip 
								AND ut.NNEQ(left.sec_range, right.sec_range),
								TRANSFORM(recordof(hdr),
									self.dt_first_seen := ut.min2(left.dt_first_seen, right.dt_first_seen);
									self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen);
									self.sec_range := IF(right.sec_range='', left.sec_range, right.sec_range);
									self := right;),
									LOCAL);	//	 : PERSIST('~thor::spokeo::persist::infutor_header_rolledup');

//EXPORT File_Infutor_Hdr := 	infh;

r1 := RECORD
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;
EXPORT File_Infutor_Hdr := DATASET('~thor::spokeo::infutor_header_rolledup', r1, thor);
