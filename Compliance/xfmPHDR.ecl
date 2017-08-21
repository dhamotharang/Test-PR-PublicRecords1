
//// Compliance: Search in the Header Key, which mirrors the service results, as opposed to the Header base file, which may contain records suppressed from the key ////


IMPORT Data_Services, ut, Header;


Layout_pre_key :=
	RECORD
		Header.layout_header_v2;
		string1 valid_dob;
		unsigned6 hhid;
		string18 county_name;
		string120 listed_name;
		string10 listed_phone;
		unsigned4 dod;
		string1 death_code;
		unsigned4 lookup_did;
 END;
 
layout_header_key := 
RECORD
//  unsigned6 s_did;
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

ds_header_key := PULL(INDEX({unsigned6 s_did}, layout_header_key, Data_Services.foreign_prod+'thor_data400::key::header_qa'));

hdr := PROJECT(ds_header_key, Layout_pre_key);


EXPORT	Compliance.Layout_Out_v3 xfmPHDR(Layout_pre_key LE, Compliance.Layout_orig_out RI) := 
	TRANSFORM
		self.src := LE.src;

		self.source_value := LE.src;
		
		SELF := LE;
		SELF := RI;
	END;
