export CClue := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

sprayed_slim :=	record
		qstring120 	name;
		string50 		c_last_name;
		string50 		c_first_name;
		string15 		c_middle_name;
		string4 		c_suffix_name;
		string2 		subject_identifier;
		string1 		subject_name_type;
		unsigned6 	cnp_nameid;
		string120 	cnp_name;
		string30 		cnp_number;
		string10 		cnp_store_number;
		string10 		cnp_btype;
		string20 		cnp_lowv;
		boolean 		cnp_translated;
		integer4 		cnp_classid;
		string2 		address_ind;
		string10 		prim_range;
		string2 		predir;
		string28 		prim_name;
		string4 		addr_suffix;
		string2 		postdir;
		string10 		unit_desig;
		string2 		record_type;
		string8 		sec_range;
		string30 		city;
		string2 		st;
		string5 		zip;
		string4 		zip4;
		string6 		addr_err_code;
		string25 		policy_no;
		string2 		policy_type;
		string10 		phone;
		string9 		tax_id;
		string9 		ssn;
		string1 		sex;
		string25 		driver_license_no;
		string2 		driver_license_state;
		unsigned4 	dob;
		string5 		customer_no;
		string6 		ambest_no;
		string20 		claim_no;
		string8 		claim_date;
		string8 		policy_eff_date;
		string9 		duns_no;
		string9 		austin_tetra_no;
		string9 		experian_bin;
		unsigned8 	rid;
		unsigned8 	ccid;
		unsigned8 	unique_id;
		unsigned8		source_rid;
		unsigned8		header_rid;
		string1 		delete_flag;
end;

layout_clean_name := RECORD
   string5	 title;
   string20	 fname;
   string20	 mname;
   string20	 lname;
   string5	 name_suffix;
   string3	 name_score;
end;

layout_clean182_fips := RECORD
   string10	 prim_range;
   string2	 predir;
   string28	 prim_name;
   string4	 addr_suffix;
   string2	 postdir;
   string10	 unit_desig;
   string8	 sec_range;
   string25	 p_city_name;
   string25	 v_city_name;
   string2	 st;
   string5	 zip;
   string4	 zip4;
   string4	 cart;
   string1	 cr_sort_sz;
   string4	 lot;
   string1	 lot_order;
   string2	 dbpc;
   string1	 chk_digit;
   string2	 rec_type;
   string2	 fips_state;
   string3	 fips_county;
   string10	 geo_lat;
   string11	 geo_long;
   string4	 msa;
   string7	 geo_blk;
   string1	 geo_match;
   string4	 err_stat;
end;
	
export rthor_data400__key__cclue__linkids := record
  unsigned6 	ultid;
  unsigned6		orgid;
  unsigned6 	seleid;
  unsigned6 	proxid;
  unsigned6 	powid;
  unsigned6 	empid;
  unsigned6 	dotid;
  unsigned2 	ultscore;
  unsigned2 	orgscore;
  unsigned2 	selescore;
  unsigned2 	proxscore;
  unsigned2 	powscore;
  unsigned2 	empscore;
  unsigned2 	dotscore;
  unsigned2 	ultweight;
  unsigned2 	orgweight;
  unsigned2 	seleweight;
  unsigned2 	proxweight;
  unsigned2 	powweight;
  unsigned2 	empweight;
  unsigned2 	dotweight;
  unsigned6		Bdid;
	unsigned1		bdid_score;
	unsigned6		did;
	unsigned1		did_score;
	unsigned4 	dt_first_seen;
	unsigned4 	dt_last_seen;
	unsigned4 	dt_vendor_first_reported;
	unsigned4 	dt_vendor_last_reported	;
	string1			record_type;	
	sprayed_slim;
	string120 	business_name;
	layout_clean_name		 	clean_Name;
	layout_clean182_fips	clean_addr;
	unsigned8		raw_aid;
	unsigned8		ace_aid;
	string100		prep_addr_line1;
	string50		prep_addr_line_last;	
end;

export dthor_data400__key__cclue__linkids 	:= dataset([], rthor_data400__key__cclue__linkids);																										

end;