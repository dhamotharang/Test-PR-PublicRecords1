export Official_Records := 

 module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20100106';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

 export rthor_200__key__official_records__autokey__address	:=
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

export rthor_200__key__official_records__autokey__addressb2	:=
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

export rthor_200__key__official_records__autokey__citystname	:=
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

export rthor_200__key__official_records__autokey__citystnameb2	:=
record
	unsigned4 city_code;
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_200__key__official_records__autokey__name	:=
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

export rthor_200__key__official_records__autokey__nameb2	:=
record
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_200__key__official_records__autokey__namewords2	:=
record
	string40 word;
	string2 state;
	unsigned1 seq;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_200__key__official_records__autokey__payload	:=
record
	unsigned6 fakeid;
	string60 official_record_key;
	string20 fname;
	string20 mname;
	string20 lname;
	string70 cname;
	string25 city;
	string2 per_state;
	string2 bus_state;
	unsigned1 zero;
	unsigned6 zerodid;
	unsigned6 zerobdid;
	string1 blank;
	string1 blank_prim_name;
	string1 blank_prim_range;
	string1 blank_st;
	string1 blank_city;
	string1 blank_zip5;
	string1 blank_sec_range;
	unsigned8 __internal_fpos__;
end;

export rthor_200__key__official_records__autokey__stname	:=
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

export rthor_200__key__official_records__autokey__stnameb2	:=
record
	string2 st;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_200__key__official_records__autokey__zip	:=
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

export rthor_200__key__official_records__autokey__zipb2	:=
record
	integer4 zip;
	string40 cname_indic;
	string40 cname_sec;
	unsigned6 bdid;
	unsigned4 lookups;
end;

export rthor_200__key__official_records_document__orid	:=
record
	string60 official_record_key;
	string2 state_origin;
	string30 county_name;
	string25 doc_instrument_or_clerk_filing_num;
	string8 doc_filed_dt;
	string60 doc_type_desc;
	string60 legal_desc_1;
	string6 doc_page_count;
	string30 doc_amend_desc;
	string8 execution_dt;
	string25 consideration_amt;
	string10 transfer_;
	string10 mortgage;
	string10 intangible_tax_amt;
	string10 book_num;
	string10 page_num;
	string60 book_type_desc;
	string25 prior_doc_file_num;
	string60 prior_doc_type_desc;
	string10 prior_book_num;
	string10 prior_page_num;
	string60 prior_book_type_desc;
	unsigned8 __internal_fpos__;
end;

export rthor_200__key__official_records_party__orid	:=
record
	string60 official_record_key;
	string2 state_origin;
	string30 county_name;
	string8 doc_filed_dt;
	string60 doc_type_desc;
	string50 entity_type_desc;
	string80 entity_nm;
	string5 title1;
	string20 fname1;
	string20 mname1;
	string20 lname1;
	string5 suffix1;
	string70 cname1;
	string1 master_party_type_cd;
	unsigned8 __internal_fpos__;
end;


	export dthor_200__key__official_records__autokey__address 			:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__address.csv', rthor_200__key__official_records__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__addressb2 		:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__addressb2.csv', rthor_200__key__official_records__autokey__addressb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__citystname 		:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__citystname.csv', rthor_200__key__official_records__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__citystnameb2 	:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__citystnameb2.csv', rthor_200__key__official_records__autokey__citystnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__name 					:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__name.csv', rthor_200__key__official_records__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__nameb2 				:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__nameb2.csv', rthor_200__key__official_records__autokey__nameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__namewords2 		:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__namewords2.csv', rthor_200__key__official_records__autokey__namewords2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__payload 			:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__payload.csv', rthor_200__key__official_records__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__stname 				:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__stname.csv', rthor_200__key__official_records__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__stnameb2 			:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__stnameb2.csv', rthor_200__key__official_records__autokey__stnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__zip 					:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__zip.csv', rthor_200__key__official_records__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records__autokey__zipb2 				:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records__'+ lCSVVersion + '__autokey__zipb2.csv', rthor_200__key__official_records__autokey__zipb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records_document__orid 					:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records_document__'+ lCSVVersion + '__orid.csv', rthor_200__key__official_records_document__orid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dthor_200__key__official_records_party__orid 						:= dataset(lCSVFileNamePrefix + 'thor_200__key__official_records_party__'+ lCSVVersion + '__orid.csv', rthor_200__key__official_records_party__orid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

end;
