export UCC := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20090901';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;


export standard__name := 
RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
END;

export name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

export rthor_data400__key__ucc__autokey__address	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned integer4 city_code;
	string5 zip;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__ucc__autokey__addressb2	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned integer4 city_code;
	string5 zip;
	string8 sec_range;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__autokey__citystname	:=
record
	unsigned integer4 city_code;
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	integer4 dob;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 city1;
	unsigned integer4 city2;
	unsigned integer4 city3;
	unsigned integer4 rel_fname1;
	unsigned integer4 rel_fname2;
	unsigned integer4 rel_fname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__ucc__autokey__citystnameb2	:=
record
	unsigned integer4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__autokey__fein2	:=
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
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__autokey__name	:=
record
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned integer2 yob;
	unsigned integer2 s4;
	integer4 dob;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 city1;
	unsigned integer4 city2;
	unsigned integer4 city3;
	unsigned integer4 rel_fname1;
	unsigned integer4 rel_fname2;
	unsigned integer4 rel_fname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__ucc__autokey__nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__autokey__namewords2	:=
record
	string40 word;
	string2 state;
	unsigned integer1 seq;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

standard__addr	:=
record
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
end;

export rthor_data400__key__ucc__autokey__payload	:=
record
	unsigned integer6 fakeid;
	string1 party_type;
	unsigned integer4 party_bits;
	unsigned integer1 zero;
	string31 tmsid;
	string23 rmsid;
	unsigned integer6 did;
	unsigned integer6 bdid;
	string60 company_name;
	string9 ssn;
	string10 fein;
	standard__addr company_addr;
	standard__addr person_addr;
	standard__name person_name;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__ucc__autokey__phone2	:=
record
	string7 p7;
	string3 p3;
	string6 dph_lname;
	string20 pfname;
	string2 st;
	unsigned integer6 did;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__autokey__phoneb2	:=
record
	string7 p7;
	string3 p3;
	string40 cname_indic;
	string40 cname_sec;
	string2 st;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__autokey__ssn2	:=
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
	unsigned integer6 did;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__autokey__stname	:=
record
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned integer2 yob;
	unsigned integer2 s4;
	integer4 zip;
	integer4 dob;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 city1;
	unsigned integer4 city2;
	unsigned integer4 city3;
	unsigned integer4 rel_fname1;
	unsigned integer4 rel_fname2;
	unsigned integer4 rel_fname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__ucc__autokey__stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__autokey__zip	:=
record
	integer4 zip;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned integer2 yob;
	unsigned integer2 s4;
	integer4 dob;
	unsigned integer8 states;
	unsigned integer4 lname1;
	unsigned integer4 lname2;
	unsigned integer4 lname3;
	unsigned integer4 city1;
	unsigned integer4 city2;
	unsigned integer4 city3;
	unsigned integer4 rel_fname1;
	unsigned integer4 rel_fname2;
	unsigned integer4 rel_fname3;
	unsigned integer4 lookups;
	unsigned integer6 did;
end;

export rthor_data400__key__ucc__autokey__zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned integer6 bdid;
	unsigned integer4 lookups;
end;

export rthor_data400__key__ucc__bdid_w_type	:=
record
	unsigned integer6 bdid;
	string1 party_type;
	string31 tmsid;
	string23 rmsid;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__ucc__did_w_type	:=
record
	unsigned integer6 did;
	string1 party_type;
	string31 tmsid;
	string23 rmsid;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__ucc__filing_number	:=
record
	string25 filing_number;
	string31 tmsid;
	string23 rmsid;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__ucc__main_rmsid	:=
record
,maxLength(32767) 
	string31 tmsid;

  string23 rmsid;
  string8 process_date;
  string12 static_value;
  string8 date_vendor_removed;
  string8 date_vendor_changed;
  string3 filing_jurisdiction;
  string25 orig_filing_number;
  string40 orig_filing_type;
  string8 orig_filing_date;
  string4 orig_filing_time;
  string25 filing_number;
  string1 filing_number_indc;
  string40 filing_type;
  string8 filing_date;
  string4 filing_time;
  string8 filing_status;
  string30 status_type;
  string3 page;
  string8 expiration_date;
  string9 contract_type;
  string8 vendor_entry_date;
  string4 vendor_upd_date;
  string3 statements_filed;
  string8 continuious_expiration;
  string17 microfilm_number;
  string17 amount;
  string17 irs_serial_number;
  string8 effective_date;
  string75 signer_name;
  string60 title;
  string120 filing_agency;
  string64 address;
  string30 city;
  string2 state;
  string30 county;
  string9 zip;
  string9 duns_number;
  string8 cmnt_effective_date;
  string500 description;
  string512 collateral_desc;
  string145 prim_machine;
  string145 sec_machine;
  string5 manufacturer_code;
  string120 manufacturer_name;
  string15 model;
  string4 model_year;
  string50 model_desc;
  string5 collateral_count;
  string4 manufactured_year;
  string1 new_used;
  string30 serial_number;
  string50 property_desc;
  string9 borough;
  string5 block;
  string4 lot;
  string60 collateral_address;
  string1 air_rights_indc;
  string1 subterranean_rights_indc;
  string1 easment_indc;
  string3 volume;
	unsigned8 persistent_record_id:=0;
  unsigned8 __internal_fpos__;

end;

export rthor_data400__key__ucc__party_rmsid	:=
record,maxLength(32767) string31 tmsid;
	string23 rmsid;
	string120 orig_name;
	string25 orig_lname;
	string25 orig_fname;
	string35 orig_mname;
	string10 orig_suffix;
	string9 duns_number;
	string9 hq_duns_number;
	string9 ssn;
	string10 fein;
	string45 incorp_state;
	string30 corp_number;
	string30 corp_type;
	string60 orig_address1;
	string60 orig_address2;
	string30 orig_city;
	string2 orig_state;
	string5 orig_zip5;
	string4 orig_zip4;
	string30 orig_country;
	string30 orig_province;
	string9 orig_postal_code;
	string1 foreign_indc;
	string1 party_type;
	unsigned integer6 dt_first_seen;
	unsigned integer6 dt_last_seen;
	unsigned integer6 dt_vendor_last_reported;
	unsigned integer6 dt_vendor_first_reported;
	string8 process_date;
	string5 title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string3 name_score;
	string60 company_name;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string25 v_city_name;
	string2 st;
	string5 zip5;
	string4 zip4;
	string3 county;
	string4 cart;
	string1 cr_sort_sz;
	string4 lot;
	string1 lot_order;
	string2 dpbc;
	string1 chk_digit;
	string2 rec_type;
	string2 ace_fips_st;
	string3 ace_fips_county;
	string10 geo_lat;
	string11 geo_long;
	string4 msa;
	string7 geo_blk;
	string1 geo_match;
	string4 err_stat;
	unsigned integer6 bdid;
	unsigned integer6 did;
	unsigned integer6 did_score;
	unsigned integer6 bdid_score;
end;

export rthor_data400__key__ucc__rmsid	:=
record,maxLength(32767) string23 rmsid;
	string31 tmsid;
	unsigned integer8 __internal_fpos__;
end;

export rthor_data400__key__ucc__Linkids:=RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  string31 tmsid;
  string23 rmsid;
  string120 orig_name;
  string25 orig_lname;
  string25 orig_fname;
  string35 orig_mname;
  string10 orig_suffix;
  string9 duns_number;
  string9 hq_duns_number;
  string9 ssn;
  string10 fein;
  string45 incorp_state;
  string30 corp_number;
  string30 corp_type;
  string60 orig_address1;
  string60 orig_address2;
  string30 orig_city;
  string2 orig_state;
  string5 orig_zip5;
  string4 orig_zip4;
  string30 orig_country;
  string30 orig_province;
  string9 orig_postal_code;
  string1 foreign_indc;
  string1 party_type;
  unsigned6 dt_first_seen;
  unsigned6 dt_last_seen;
  unsigned6 dt_vendor_last_reported;
  unsigned6 dt_vendor_first_reported;
  string8 process_date;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string60 company_name;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string3 county;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 ace_fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned6 bdid;
  unsigned6 did;
  unsigned6 did_score;
  unsigned6 bdid_score;
  unsigned8 source_rec_id;
  string100 prep_addr_line1;
  string50 prep_addr_last_line;
  unsigned8 rawaid;
  unsigned8 aceaid;
  integer1 fp;
 END;
 
export rthor_data400__key__ucc__bdid:=RECORD
  unsigned6 bdid;
  string31 tmsid;
  string23 rmsid;
  unsigned8 __internal_fpos__;
 END;


export rthor_data400__key__ucc__did:=RECORD
  unsigned6 did;
  string31 tmsid;
  string23 rmsid;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__ucc__filing_date:=RECORD
  string8 filing_date;
  string31 tmsid;
  string23 rmsid;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__ucc__jurisdiction:=RECORD
  string3 filing_jurisdiction;
  string31 tmsid;
  string23 rmsid;
  unsigned8 __internal_fpos__;
 END;


export dthor_data400__key__ucc__autokey__address 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__address.csv', rthor_data400__key__ucc__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__addressb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__addressb2.csv', rthor_data400__key__ucc__autokey__addressb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__citystname 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__citystname.csv', rthor_data400__key__ucc__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__citystnameb2 	:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__citystnameb2.csv', rthor_data400__key__ucc__autokey__citystnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__fein2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__fein2.csv', rthor_data400__key__ucc__autokey__fein2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__name 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__name.csv', rthor_data400__key__ucc__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__nameb2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__nameb2.csv', rthor_data400__key__ucc__autokey__nameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__namewords2 		:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__namewords2.csv', rthor_data400__key__ucc__autokey__namewords2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__payload				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__payload.csv', rthor_data400__key__ucc__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__phone2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__phone2.csv', rthor_data400__key__ucc__autokey__phone2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__phoneb2 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__phoneb2.csv', rthor_data400__key__ucc__autokey__phoneb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__20090901__autokey__ssn2 := dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__ssn2.csv', rthor_data400__key__ucc__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__stname 				:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__stname.csv', rthor_data400__key__ucc__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__stnameb2 			:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__stnameb2.csv', rthor_data400__key__ucc__autokey__stnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__zip 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__zip.csv', rthor_data400__key__ucc__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__autokey__zipb2 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__autokey__zipb2.csv', rthor_data400__key__ucc__autokey__zipb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__bdid_w_type 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__bdid_w_type.csv', rthor_data400__key__ucc__bdid_w_type, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__did_w_type 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__did_w_type.csv', rthor_data400__key__ucc__did_w_type, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__filing_number 					:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__filing_number.csv', rthor_data400__key__ucc__filing_number, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__main_rmsid 							:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__main_rmsid.csv', rthor_data400__key__ucc__main_rmsid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__party_rmsid 						:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__party_rmsid.csv', rthor_data400__key__ucc__party_rmsid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__rmsid 									:= dataset(lCSVFileNamePrefix + 'thor_data400__key__ucc__' + lCSVVersion + '__rmsid.csv', rthor_data400__key__ucc__rmsid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ucc__Linkids 								:= dataset([],rthor_data400__key__ucc__Linkids);
export dthor_data400__key__ucc__bdid 								    := dataset([],rthor_data400__key__ucc__bdid);
export dthor_data400__key__ucc__did 								    := dataset([],rthor_data400__key__ucc__did);
export dthor_data400__key__ucc__filing_date 						:= dataset([],rthor_data400__key__ucc__filing_date);
export dthor_data400__key__ucc__jurisdiction 						:= dataset([],rthor_data400__key__ucc__jurisdiction);
end;