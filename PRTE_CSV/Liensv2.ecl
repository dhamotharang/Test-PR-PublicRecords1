export Liensv2 := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100713';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

export addr := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
END;

export rthor_data400__key__liensv2__autokey_address	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__liensv2__autokey_addressb2	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_citystname	:=
record
	unsigned4 city_code;
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__liensv2__autokey_citystnameb2	:=
record
	unsigned4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_fein2	:=
record
	string1 f1;
	string1 f2;
	string1 f3;
	string1 f4;
	string1 f5;
	string1 f6;
	string1 f7;
	string1 f8;
	string1 f9;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_name	:=
record
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__liensv2__autokey_nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_namewords2	:=
record
	string40 word;
	string2 state;
	unsigned1 seq;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_payload :=  
record 
  unsigned6 fakeid;
	string name_type;
	unsigned4 party_bits;
	unsigned1 zero;
	string50 tmsid;
	string50 rmsid;
	unsigned6 intdid;
	unsigned6 intbdid;
	string cname;
	string9 ssn;
	string9 tax_id;
	addr company_addr;
	addr person_addr;
	name person_name;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__liensv2__autokey_phone2	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned6 did;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_phoneb2	:=
record
	string7 p7;
	string3 p3;
	string40 cname_indic;
	string40 cname_sec;
	string2 st;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_ssn2	:=
record
	string1 s1;
	string1 s2;
	string1 s3;
	string1 s4;
	string1 s5;
	string1 s6;
	string1 s7;
	string1 s8;
	string1 s9;
	string6 dph_lname;
	string20 pfname;
	unsigned6 did;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_stname	:=
record
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 zip;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__liensv2__autokey_stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__autokey_zip	:=
record
	integer4 zip;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__liensv2__autokey_zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_data400__key__liensv2__bdid	:=
record
	unsigned6 p_bdid;
	string50 tmsid;
	string50 rmsid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__liensv2__case_number	:=
record
	string20 case_number;
	string2 filing_state;
	string50 tmsid;
	string50 rmsid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__liensv2__did	:=
record
	unsigned6 did;
	string50 tmsid;
	string50 rmsid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__liensv2__filing_number	:=
record
	string20 filing_number;
	string2 filing_state;
	string50 tmsid;
	string50 rmsid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__liensv2__main__certificate_number	:=
record
	string25 certificate_number;
	string50 tmsid;
	string50 rmsid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__liensv2__main__irs_serial_number	:=
record
	string25 irs_serial_number;
	string2 agency_state;
	string50 tmsid;
	string50 rmsid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__liensv2__main__rmsid	:=
record
,maxLength(32766) string50 rmsid;
	string50 tmsid;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__liensv2__party__tmsid_rmsid	:=
record
	string50 tmsid;
	string50 rmsid;
	string orig_full_debtorname;
	string orig_name;
	string orig_lname;
	string orig_fname;
	string orig_mname;
	string orig_suffix;
	string9 tax_id;
	string9 ssn;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	string cname;
	string orig_address1;
	string orig_address2;
	string orig_city;
	string orig_state;
	string orig_zip5;
	string orig_zip4;
	string orig_county;
	string orig_country;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dbpc;
	string1 chk_digit;
	string2 rec_type;
	string5 county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	string phone;
	string name_type;
	string12 did;
	string12 bdid;
	string8 date_first_seen;
	string8 date_last_seen;
	string8 date_vendor_first_reported;
	string8 date_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__liensv2__autokey_address 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_address.csv', rthor_data400__key__liensv2__autokey_address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_addressb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_addressb2.csv', rthor_data400__key__liensv2__autokey_addressb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_citystname 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_citystname.csv', rthor_data400__key__liensv2__autokey_citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_citystnameb2 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_citystnameb2.csv', rthor_data400__key__liensv2__autokey_citystnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_fein2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_fein2.csv', rthor_data400__key__liensv2__autokey_fein2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_name 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_name.csv', rthor_data400__key__liensv2__autokey_name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_nameb2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_nameb2.csv', rthor_data400__key__liensv2__autokey_nameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_namewords2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_namewords2.csv', rthor_data400__key__liensv2__autokey_namewords2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_payload 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_payload.csv', rthor_data400__key__liensv2__autokey_payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_phone2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_phone2.csv', rthor_data400__key__liensv2__autokey_phone2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_phoneb2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_phoneb2.csv', rthor_data400__key__liensv2__autokey_phoneb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_ssn2 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_ssn2.csv', rthor_data400__key__liensv2__autokey_ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_stname 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_stname.csv', rthor_data400__key__liensv2__autokey_stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_stnameb2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_stnameb2.csv', rthor_data400__key__liensv2__autokey_stnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_zip 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_zip.csv', rthor_data400__key__liensv2__autokey_zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__autokey_zipb2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__autokey_zipb2.csv', rthor_data400__key__liensv2__autokey_zipb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__bdid 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__bdid.csv', rthor_data400__key__liensv2__bdid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__case_number 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__case_number.csv', rthor_data400__key__liensv2__case_number, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__did 										:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__did.csv', rthor_data400__key__liensv2__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__filing_number 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__filing_number.csv', rthor_data400__key__liensv2__filing_number, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__main__certificate_number := dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__main__certificate_number.csv', rthor_data400__key__liensv2__main__certificate_number, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__main__irs_serial_number := dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__main__irs_serial_number.csv', rthor_data400__key__liensv2__main__irs_serial_number, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2__main__rmsid 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__main__rmsid.csv', rthor_data400__key__liensv2__main__rmsid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__liensv2___party__tmsid_rmsid 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__liensv2__' + lCSVVersion + '__party__tmsid.rmsid.csv', rthor_data400__key__liensv2__party__tmsid_rmsid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
end;