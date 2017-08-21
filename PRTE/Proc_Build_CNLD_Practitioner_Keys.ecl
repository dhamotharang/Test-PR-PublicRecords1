IMPORT _Control;

EXPORT Proc_Build_CNLD_Practitioner_Keys(STRING pIndexVersion) := FUNCTION

	rKeyCNLD_Practitioner__autokey__address := RECORD
		string28 	prim_name;
		string10 	prim_range;
		string2 	st;
		unsigned4 city_code;
		string5 	zip;
		string8 	sec_range;
		string6 	dph_lname;
		string20 	lname;
		string20 	pfname;
		string20 	fname;
		unsigned8 states;
		unsigned4 lname1;
		unsigned4 lname2;
		unsigned4 lname3;
		unsigned4 lookups;
		unsigned6 did;
	END;

	rKeyCNLD_Practitioner__autokey__citystname := RECORD
		unsigned4 city_code;
		string2 	st;
		string6 	dph_lname;
		string20 	lname;
		string20 	pfname;
		string20 	fname;
		integer4 	dob;
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
	END;
	
	rKeyCNLD_Practitioner__autokey__name := RECORD
		string6 	dph_lname;
		string20 	lname;
		string20 	pfname;
		string20 	fname;
		string1 	minit;
		unsigned2 yob;
		unsigned2 s4;
		integer4 	dob;
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
	END;

	rKeyCNLD_Practitioner__autokey__payload := RECORD
		unsigned6 fakeid;
		unsigned8 date_firstseen;
		unsigned8 date_lastseen;
		unsigned6 did;
		string10 	gennum;
		string9 	deanbr;
		string8 	deanbr_exp;
		string7 	deanbr_sch;
		string1 	deanbr_code;
		string6 	upin_num;
		string1 	provstat;
		string10 	provstatdesc;
		string1 	gender;
		string25 	lastname;
		string20 	firstname;
		string20 	middlename;
		string6 	suffix;
		string3 	generation;
		string8 	dob;
		string4 	prescribertype;
		string10 	address_addrid;
		string55 	address_line1;
		string55 	address_line2;
		string30 	address_city;
		string2 	address_st;
		string5 	address_zip;
		string5 	address_zip4;
		string25 	address_country;
		string10 	address_phone;
		string10 	address_fax;
		string8 	address_date;
		string1 	address_status;
		string5 	address_source;
		string1 	address_type;
		string1 	address_rank;
		string10 	ssn;
		string10 	npi;
		string8 	abmsid;
		string1 	profstat;
		string10 	profstatdesc;
		string10 	tax_id;
		string2 	st_lic_in;
		string15 	st_lic_num;
		string8 	st_lic_num_exp;
		string3 	st_lic_stat;
		string10 	licstatdesc;
		string10 	st_lic_type;
		string10 	st_lic_issue;
		string8 	st_lic_source;
		string3 	specialty_code;
		string8 	sanction_date;
		string2 	sanction_state;
		string30 	sanction_case;
		string11 	sanction_id;
		string10 	sanction_docid;
		string5 	sanction_source;
		string5 	sanction_type;
		string10 	degree;
		string5 	schoolcode;
		string4 	schoolyear;
		string1 	train_category;
		string10 	traincatdesc;
		string10 	train_startdate;
		string10 	train_enddate;
		string5 	train_institute;
		string100 append_addrline1;
		string50 	append_addrlinelast;
		unsigned8 append_rawaid;
		unsigned8 append_aceaid;
		string5 	title;
		string20 	fname;
		string20 	mname;
		string20 	lname;
		string5 	name_suffix;
		string10 	prim_range;
		string2 	predir;
		string28 	prim_name;
		string4 	addr_suffix;
		string2 	postdir;
		string10 	unit_desig;
		string8 	sec_range;
		string25 	p_city_name;
		string25 	v_city_name;
		string2 	st;
		string5 	zip;
		string4 	zip4;
		string4 	cart;
		string1 	cr_sort_sz;
		string4 	lot;
		string1 	lot_order;
		string2 	dbpc;
		string1 	chk_digit;
		string2 	rec_type;
		string2 	fips_state;
		string3 	fips_county;
		string10 	geo_lat;
		string11 	geo_long;
		string4		msa;
		string7 	geo_blk;
		string1 	geo_match;
		string4 	err_stat;
		unsigned6	bdid;
		unsigned6	zero;
	END;
	
	rKeyCNLD_Practitioner__autokey__phone2 := RECORD
		string7 	p7;
		string3 	p3;
		string6 	dph_lname;
		string20 	pfname;
		string2 	st;
		unsigned6 did;
		unsigned4 lookups;
	END;

	rKeyCNLD_Practitioner__autokey__stname := RECORD
		string2 	st;
		string6 	dph_lname;
		string20	lname;
		string20 	pfname;
		string20 	fname;
		string1 	minit;
		unsigned2 yob;
		unsigned2 s4;
		integer4 	zip;
		integer4 	dob;
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
	END;

	rKeyCNLD_Practitioner__autokey__zip := RECORD
		integer4 	zip;
		string6 	dph_lname;
		string20 	lname;
		string20 	pfname;
		string20 	fname;
		string1 	minit;
		unsigned2 yob;
		unsigned2 s4;
		integer4 	dob;
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
	END;

	rKeyCNLD_Practitioner__autokey__SSN2 := RECORD
		string1 	s1;
		string1 	s2;
		string1 	s3;
		string1 	s4;
		string1 	s5;
		string1		s6;
		string1 	s7;
		string1 	s8;
		string1 	s9;
		string6 	dph_lname;
		string20 	pfname;
		unsigned6 did;
		unsigned4 lookups;
	END;

	rKeyCNLD_Practitioner__did := RECORD
		UNSIGNED6 did;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyCNLD_Practitioner__dea := RECORD
		string9 	deanbr;
		string10 	gennum;
		unsigned8 __internal_fpos__;

	END;

	rKeyCNLD_Practitioner__taxId := RECORD
		string10 	tax_id;
		string10 	gennum; 
		unsigned8 __internal_fpos__;
	END;
	
	rKeyCNLD_Practitioner__PractitionerID := RECORD
		string10 	gennum;
		unsigned8 date_firstseen;
		unsigned8 date_lastseen;
		unsigned6 did;
		string9 	deanbr;
		string8 	deanbr_exp;
		string7 	deanbr_sch;
		string1 	deanbr_code;
		string6 	upin_num;
		string1 	provstat;
		string10 	provstatdesc;
		string1 	gender;
		string25 	lastname;
		string20 	firstname;
		string20 	middlename;
		string6 	suffix;
		string3 	generation;
		string8 	dob;
		string4 	prescribertype;
		string10 	address_addrid;
		string55 	address_line1;
		string55 	address_line2;
		string30 	address_city;
		string2 	address_st;
		string5 	address_zip;
		string5 	address_zip4;
		string25 	address_country;
		string10 	address_phone;
		string10 	address_fax;
		string8 	address_date;
		string1 	address_status;
		string5 	address_source;
		string1 	address_type;
		string1 	address_rank;
		string10 	ssn;
		string10 	npi;
		string8 	abmsid;
		string1 	profstat;
		string10 	profstatdesc;
		string10 	tax_id;
		string2 	st_lic_in;
		string15 	st_lic_num;
		string8 	st_lic_num_exp;
		string3 	st_lic_stat;
		string10 	licstatdesc;
		string10 	st_lic_type;
		string10 	st_lic_issue;
		string8 	st_lic_source;
		string3 	specialty_code;
		string8 	sanction_date;
		string2 	sanction_state;
		string30 	sanction_case;
		string11 	sanction_id;
		string10 	sanction_docid;
		string5 	sanction_source;
		string5 	sanction_type;
		string10 	degree;
		string5 	schoolcode;
		string4 	schoolyear;
		string1 	train_category;
		string10 	traincatdesc;
		string10 	train_startdate;
		string10 	train_enddate;
		string5 	train_institute;
		string100 append_addrline1;
		string50 	append_addrlinelast;
		unsigned8 append_rawaid;
		unsigned8 append_aceaid;
		string5 	title;
		string20 	fname;
		string20 	mname;
		string20 	lname;
		string5 	name_suffix;
		string10 	prim_range;
		string2 	predir;
		string28 	prim_name;
		string4 	addr_suffix;
		string2 	postdir;
		string10 	unit_desig;
		string8 	sec_range;
		string25 	p_city_name;
		string25 	v_city_name;
		string2 	st;
		string5 	zip;
		string4 	zip4;
		string4 	cart;
		string1 	cr_sort_sz;
		string4 	lot;
		string1 	lot_order;
		string2 	dbpc;
		string1 	chk_digit;
		string2 	rec_type;
		string2 	fips_state;
		string3 	fips_county;
		string10 	geo_lat;
		string11 	geo_long;
		string4 	msa;
		string7 	geo_blk;
		string1 	geo_match;
		string4 	err_stat;
		unsigned8 __internal_fpos__;
	END; 

	rKeyCNLD_Practitioner__stLicNum := RECORD
		string2 	st_lic_in;
		string15 	st_lic_num;
		string10 	gennum;
		unsigned8 __internal_fpos__;
	END;	
	
	rKeyCNLD_Practitioner__upin := RECORD
		string6 	upin_num;
		string10 	gennum;
		unsigned8 __internal_fpos__;
	END;
	
	rKeyCNLD_Practitioner__npi := RECORD
		string10 	npi;
		string10 	gennum;
		unsigned8 __internal_fpos__ ;
	END;

	rKeyCNLD_Practitioner__zip := RECORD
		string5 	zip;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;

	ds_address				:= DATASET([], rKeyCNLD_Practitioner__autokey__address);
	ds_citystname			:= DATASET([], rKeyCNLD_Practitioner__autokey__citystname);
	ds_name						:= DATASET([], rKeyCNLD_Practitioner__autokey__name);
	ds_payload				:= DATASET([], rKeyCNLD_Practitioner__autokey__payload);
	ds_phone2					:= DATASET([], rKeyCNLD_Practitioner__autokey__phone2);
	ds_stname					:= DATASET([], rKeyCNLD_Practitioner__autokey__stname);
	ds_ssn2						:= DATASET([], rKeyCNLD_Practitioner__autokey__ssn2);	
	ds_zip						:= DATASET([], rKeyCNLD_Practitioner__autokey__zip);
  ds_did    		  	:= DATASET([], rKeyCNLD_Practitioner__did);
  ds_dea    		   	:= DATASET([], rKeyCNLD_Practitioner__dea);
  ds_npi    		   	:= DATASET([], rKeyCNLD_Practitioner__npi);	
	ds_taxid   				:= DATASET([], rKeyCNLD_Practitioner__taxid);
	ds_practitionerID	:= DATASET([], rKeyCNLD_Practitioner__practitionerID);
  ds_stlicnum			  := DATASET([], rKeyCNLD_Practitioner__stLicNum);
  ds_upin			 			:= DATASET([], rKeyCNLD_Practitioner__upin);
  ds_zipCode	 			:= DATASET([], rKeyCNLD_Practitioner__zip);

	address_IN				:= INDEX(ds_address, {prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, did}, {ds_address}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::autokey::address');
	citystname_IN			:= INDEX(ds_citystname, {city_code, st,	dph_lname, lname,	pfname,	fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, did}, {ds_citystname}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::autokey::citystname');
	name_IN						:= INDEX(ds_name, {dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, did}, {ds_name}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::autokey::name');
	payload_IN				:= INDEX(ds_payload, {fakeid}, {ds_payload}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::autokey::payload');
	phone2_IN					:= INDEX(ds_phone2, {p7, p3, dph_lname, pfname, st, did}, {ds_phone2}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::autokey::phone2');
	stname_IN					:= INDEX(ds_stname, {st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, did}, {ds_stname}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::autokey::stname');
	ssn2_IN						:= INDEX(ds_ssn2, {s1, s2, s3, s4, s5, s6, s7, s8, s9, dph_lname, pfname, did}, {ds_ssn2}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::autokey::ssn2');
	zip_IN						:= INDEX(ds_zip, {zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, did}, {ds_zip}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::autokey::zip');
  did_IN      			:= INDEX(ds_did, {did}, {ds_did}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::did');	
  dea_IN       			:= INDEX(ds_dea, {deanbr}, {ds_dea}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::dea');	
  taxid_IN      		:= INDEX(ds_taxid, {tax_id}, {ds_taxid}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::taxid');	
  practitionerID_IN := INDEX(ds_practitionerID, {gennum}, {ds_practitionerID}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::practitionerid');	
	stlicnum_IN 			:= INDEX(ds_stlicnum, {st_lic_in, st_lic_num}, {ds_stlicnum}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::stlicnum');	
	upin_IN       		:= INDEX(ds_upin, {upin_num}, {ds_upin}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::upin');	
  npi_IN       			:= INDEX(ds_npi, {npi}, {ds_npi}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::npi');	
	zipcode_IN      	:= INDEX(ds_zipcode, {zip}, {ds_zipcode}, '~prte::key::cnld_practitioner::' + pIndexVersion + '::zip');	
  

	RETURN SEQUENTIAL(PARALLEL(BUILD(address_IN, update),
														 BUILD(citystname_IN, update),
														 BUILD(name_IN, update),
														 BUILD(payload_IN, update),
														 BUILD(phone2_IN, update),
														 BUILD(stname_IN, update),
														 BUILD(ssn2_IN, update),														 
														 BUILD(zip_IN, update),
														 BUILD(did_IN, update),
														 BUILD(dea_IN, update),
														 BUILD(taxid_IN, update),
														 BUILD(practitionerID_IN, update),
														 BUILD(stlicnum_IN, update),
														 BUILD(upin_IN, update),
														 BUILD(npi_IN, update),
														 BUILD(zipcode_IN, update)),
										PRTE.UpdateVersion('CNLDPractitionerKeys',							 	//	Package name
																	     pIndexVersion,											 		//	Package version
																	    'julianne,franzer@lexisnexis.com;anantha.venkatachalam@lexisnexis.com', //	Who to email with specifics
																	     'B',																	 	//	B = Boca, A = Alpharetta
																	     'N',																		//	N = Non-FCRA, F = FCRA
																	     'N'																 		//	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;