export Infutor := 

module

	shared	lSubDirName		:= '';
	shared	lCSVVersion		:= '20090706';
	shared	lCSVFileNamePrefix	:= PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__Infutor__teaser__bestdid := RECORD
  unsigned6 did;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
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
  unsigned3 addr_dt_last_seen;
  unsigned8 rawaid;
  unsigned3 addr_dt_first_seen;
end;

export rthor_data400__key__Infutor__teaser__did	:= RECORD
// recordof(header.Key_Teaser_cnsmr_did);
  unsigned6 did;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  integer4 dob;
  integer4 dod;
  boolean bestaddr;
  boolean iscurrent;
  unsigned2 totalrecords;
  unsigned1 nameorder;
 END;



export rthor_data400__key__Infutor__teaser__search := RECORD
// recordof(header.Key_Teaser_cnsmr_search);
  string6 dph_lname;
  qstring20 lname;
  boolean iscurrent;
  string2 st;
  string20 pfname;
  qstring20 fname;
  qstring5 zip;
  unsigned2 yob;
  string1 minit;
  qstring5 title;
  qstring20 mname;
  qstring5 name_suffix;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8 sec_range;
  qstring25 city_name;
  qstring4 zip4;
  integer4 dob;
  integer4 dod;
  unsigned6 did;
  boolean bestaddr;
  unsigned2 totalrecords;
  unsigned1 nameorder;
 END;

export rthor_data400__key__Infutor__adl__infutor__knowx	:= RECORD
// recordof(infutor.Key_Header_Infutor_Knowx);
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

export dthor_data400__key__Infutor__teaser__bestdid	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__Infutor__' + lCSVVersion + '__teaser__bestdid.csv', rthor_data400__key__infutor__teaser__bestdid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single))); 
export dthor_data400__key__Infutor__teaser__did		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__Infutor__' + lCSVVersion + '__teaser__did.csv', rthor_data400__key__infutor__teaser__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__Infutor__teaser__search	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__Infutor__' + lCSVVersion + '__teaser__search.csv', rthor_data400__key__infutor__teaser__search, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__Infutor__adl__infutor__knowx	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__header__' + lCSVVersion + '__adl.infutor.knowx.csv', rthor_data400__key__infutor__adl__infutor__knowx, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

end;