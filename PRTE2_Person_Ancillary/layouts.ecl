
import idl_header, header;
EXPORT Layouts := MODULE

EXPORT slimrec := RECORD
  unsigned8 did;
	string9 ssn;
	string1 ssn_ind;
	string9 src;
	unsigned4 rec_cnt;
	unsigned2 src_rank;
	unsigned4 score;
	unsigned4 duration;
	unsigned4 dt_first_seen;
	unsigned4 dt_last_seen;
	unsigned4 dt_vendor_first_reported,
	unsigned4 dt_vendor_last_reported,
	string9 cluster;
	unsigned4 dob;
	boolean isFirst := FALSE;
	boolean isLast  := FALSE;
	boolean isConfirmed := FALSE;
	// real8 field_specificity;
	boolean isSuppress := FALSE;
END;

EXPORT boca_slimrec := record
  unsigned6 did;
	qstring9  ssn;
	string1   jflag3;
	string2   src;
end;

EXPORT _src_rec := RECORD
  string2   src;
	unsigned2 src_rank;
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	boolean   ispriortodob;
END;

EXPORT src_rec := RECORD
  unsigned8 did;  
	string9   ssn;  
	_src_rec _src;
END;

EXPORT _ssndata_rec := RECORD 
	string1   ssn_ind;
	// unsigned4 src_cnt;
	// unsigned4 duration;
	dataset(_src_rec) srcs;
	boolean   isMostRecent;
	boolean   isOriginal;
	boolean   isConfirmed;
END;

EXPORT ssndata_rec := RECORD
  unsigned8    did;  
	string9      ssn;
	_ssndata_rec _ssndata;
END;

EXPORT _other_rec := RECORD
  unsigned8     did;	
	string9       cluster;
	_ssndata_rec  _ssndata;
END;

EXPORT other_rec := RECORD
	string9     ssn;
	unsigned4   dob;
	_other_rec  _other;
END;

EXPORT _subject_rec := RECORD
  string9   ssn;  
	_ssndata_rec  _ssndata;
	unsigned4     score;
	unsigned2     confidence;
	unsigned4     other_cnt;
	dataset(_other_rec) other;
END;

EXPORT subject_rec := RECORD
  unsigned8    did;  
	unsigned4    dob;
	boolean      isAllSuppress;
	_subject_rec _subject;
END;

EXPORT subject_plus_rec := RECORD
  subject_rec  subject;
	unsigned4    total_sources;
	unsigned3    dt_last_seen;
	boolean      in_bureau_and_ssa;
END;

EXPORT _main := RECORD
 unsigned8 did;
 string9 cluster;
 DATASET(_subject_rec) subject;
END;

EXPORT BocaRec := RECORD
  unsigned6 s_did;
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
 
 EXPORT Layout_KeyExclusions := record
  string5     Dodgy_tracking
  ,unsigned3  addr_dt_first_seen
  ,string10   ADL_ind
  ,unsigned8  NID
  ,unsigned2  address_ind
  ,unsigned2  name_ind
END;
 
Export Layout_In:=record
 string50 SrchCriteria;
 string50 Name;
 string50 Address1;
 string50 Address2;
 string8 dob;
 string8 date_last_seen;
 string10 phone;
 qstring9 ssn;
 string8 link_dob;
 string9 link_ssn;
 string10 cust_name;
 string10 bug_num;
 end;

export layout_coreCheck2 := RECORD
  unsigned8 did;
  unsigned4 dt_last_seen;
  unsigned4 dt_first_seen;
  unsigned8 cnt;
  string10 ind;
  string3 lexid_type;
  unsigned8 death_record_cnt;
  string9 ssn;
  unsigned4 dob;
  string25 dl_nbr;
  string2 dl_state;
  string20 fname;
  string20 mname;
  string28 lname;
  string2 sname;
  string1 gender;
  string1 derived_gender;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 city;
  string2 st;
  string5 zip;
  string4 zip4;
  unsigned4 addr_dt_last_seen;
  unsigned4 addr_dt_first_seen;
 END;

export Layout_SSN_Map := record
  string5 ssn5;
  string4 end_serial;
  string4 start_serial;
  string8 start_date;
  string8 end_date;
  string50 state;
end;

Export Layout_Header_link:=record
idl_header.Layout_Header_Link;
end;

Export Layout_header :=record
header.Layout_Header;
end;

Export layout_header_v2_dl:=record
header.Layout_header_v2_dl;
end;

Export arecord1:= RECORD
  unsigned8 did;
  string5 title;
  string20 fname;
  string20 mname;
  string28 lname;
  string5 sname;
  unsigned4 dob;
  string25 dl_nbr;
  string2 dl_state;
  string9 src;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
 END;

Export arecord2:= RECORD
  string25 dl_nbr;
  unsigned8 did;
  string5 title;
  string20 fname;
  string20 mname;
  string28 lname;
  string5 sname;
  unsigned4 dob;
  string2 dl_state;
  string9 src;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
 END;

end;

