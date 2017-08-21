IMPORT _Control;

EXPORT Proc_Build_MMCP_Keys(STRING pIndexVersion) := FUNCTION

	rKeyMMCP__autokey__address := RECORD
		STRING28  prim_name;
		STRING10  prim_range;
		STRING2   st;
		UNSIGNED4 city_code;
		STRING5   zip;
		STRING8   sec_range;
    STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	rKeyMMCP__autokey__addressb2 := RECORD
		STRING28  prim_name;
		STRING10  prim_range;
		STRING2   st;
		UNSIGNED4 city_code;
		STRING5   zip;
		STRING8   sec_range;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyMMCP__autokey__citystname := RECORD
		UNSIGNED4 city_code;
		STRING2   st;
		STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		INTEGER4  dob;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 city1;
		UNSIGNED4 city2;
		UNSIGNED4 city3;
		UNSIGNED4 rel_fname1;
		UNSIGNED4 rel_fname2;
		UNSIGNED4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	rKeyMMCP__autokey__citystnameb2 := RECORD
		UNSIGNED4 city_code;
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyMMCP__autokey__name := RECORD
		STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		STRING1   minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4  dob;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 city1;
		UNSIGNED4 city2;
		UNSIGNED4 city3;
		UNSIGNED4 rel_fname1;
		UNSIGNED4 rel_fname2;
		UNSIGNED4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	rKeyMMCP__autokey__nameb2 := RECORD
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyMMCP__autokey__namewords2 := RECORD
		STRING40  word;
		STRING2   state;
		UNSIGNED1 seq;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

  cleaned_name := RECORD
		STRING5  title;
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5  name_suffix;
		STRING3  name_score;
  END;

  layout_clean182_fips := RECORD
		STRING10 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 p_city_name;
		STRING25 v_city_name;
		STRING2  st;
		STRING5  zip;
		STRING4  zip4;
		STRING4  cart;
		STRING1  cr_sort_sz;
		STRING4  lot;
		STRING1  lot_order;
		STRING2  dbpc;
		STRING1  chk_digit;
		STRING2  rec_type;
		STRING2  fips_state;
		STRING3  fips_county;
		STRING10 geo_lat;
		STRING11 geo_long;
		STRING4  msa;
		STRING7  geo_blk;
		STRING1  geo_match;
		STRING4  err_stat;
  END;
	
	rKeyMMCP__autokey__payload := RECORD
		UNSIGNED6 fakeid;
		STRING10  license_number;
	  UNSIGNED4 customer_id;
		STRING2   bull_license_type;
		STRING3   sec_license_status;
		STRING15  license_status;
		STRING8   license_status_date;
		STRING8   expiration_date;
		STRING7   audit_number;
		STRING20  bull_specialty;
		STRING2   license_mask;
		STRING8   issue_date;
		STRING9   dea_number;
		STRING1   discipline_ind;
		STRING8   last_update_date;
		STRING8   status_change_date;
		STRING3   name_prefix;
		STRING40  name_first_middle;
		STRING20  name_first;
		STRING20  name_middle;
		STRING40  name_last;
		STRING5   name_suffix;
		STRING83  full_name;
		STRING8   dob;
		STRING9   ssn;
		STRING65  company_name;
		STRING40  address1;
		STRING40  address2;
		STRING40  address3;
		STRING23  city;
		STRING2   state;
		STRING9   full_zip;
		STRING2   county_code;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		layout_clean182_fips clean_company_address;
		cleaned_name         clean_name;
		STRING    license_board_code_desc;
		STRING    bull_lic_type_desc;
		STRING    license_status_desc;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyMMCP__autokey__ssn2 := RECORD
		STRING1   s1;
		STRING1   s2;
		STRING1   s3;
		STRING1   s4;
		STRING1   s5;
		STRING1   s6;
		STRING1   s7;
		STRING1   s8;
		STRING1   s9;
		STRING3   p3;
		STRING6   dph_lname;
		STRING20  pfname;
		UNSIGNED6 did;
		UNSIGNED4 lookups;
	END;

	rKeyMMCP__autokey__stname := RECORD
		STRING2   st;
		STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		STRING1   minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4  zip;
		INTEGER4  dob;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 city1;
		UNSIGNED4 city2;
		UNSIGNED4 city3;
		UNSIGNED4 rel_fname1;
		UNSIGNED4 rel_fname2;
		UNSIGNED4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	rKeyMMCP__autokey__stnameb2 := RECORD
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyMMCP__autokey__zip := RECORD
		INTEGER4  zip;
		STRING6   dph_lname;
		STRING20  lname;
		STRING20  pfname;
		STRING20  fname;
		STRING1   minit;
		UNSIGNED2 yob;
		UNSIGNED2 s4;
		INTEGER4  dob;
		UNSIGNED8 states;
		UNSIGNED4 lname1;
		UNSIGNED4 lname2;
		UNSIGNED4 lname3;
		UNSIGNED4 city1;
		UNSIGNED4 city2;
		UNSIGNED4 city3;
		UNSIGNED4 rel_fname1;
		UNSIGNED4 rel_fname2;
		UNSIGNED4 rel_fname3;
		UNSIGNED4 lookups;
		UNSIGNED6 did;
	END;

	rKeyMMCP__autokey__zipb2 := RECORD
		INTEGER4  zip;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyMMCP__license_number := RECORD
		STRING10  license_number;
		STRING1   record_type;
	  UNSIGNED4 customer_id;
		STRING2   bull_license_type;
		STRING3   sec_license_status;
		STRING15  license_status;
		STRING8   license_status_date;
		STRING8   expiration_date;
		STRING7   audit_number;
		STRING20  bull_specialty;
		STRING2   license_mask;
		STRING8   issue_date;
		STRING9   dea_number;
		STRING1   discipline_ind;
		STRING8   last_update_date;
		STRING8   status_change_date;
		STRING3   name_prefix;
		STRING40  name_first_middle;
		STRING20  name_first;
		STRING20  name_middle;
		STRING40  name_last;
		STRING5   name_suffix;
		STRING83  full_name;
		STRING8   dob;
		STRING9   ssn;
		STRING65  company_name;
		STRING40  address1;
		STRING40  address2;
		STRING40  address3;
		STRING23  city;
		STRING2   state;
		STRING9   full_zip;
		STRING2   county_code;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		layout_clean182_fips clean_company_address;
		cleaned_name         clean_name;
		STRING    license_board_code_desc;
		STRING    bull_lic_type_desc;
		STRING    license_status_desc;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyMMCP__license_state := RECORD
		STRING2   state;
		STRING10  license_number;
	  UNSIGNED4 customer_id;
		STRING2   bull_license_type;
		STRING3   sec_license_status;
		STRING15  license_status;
		STRING8   license_status_date;
		STRING8   expiration_date;
		STRING7   audit_number;
		STRING20  bull_specialty;
		STRING2   license_mask;
		STRING8   issue_date;
		STRING9   dea_number;
		STRING1   discipline_ind;
		STRING8   last_update_date;
		STRING8   status_change_date;
		STRING3   name_prefix;
		STRING40  name_first_middle;
		STRING20  name_first;
		STRING20  name_middle;
		STRING40  name_last;
		STRING5   name_suffix;
		STRING83  full_name;
		STRING8   dob;
		STRING9   ssn;
		STRING65  company_name;
		STRING40  address1;
		STRING40  address2;
		STRING40  address3;
		STRING23  city;
		STRING9   full_zip;
		STRING2   county_code;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		layout_clean182_fips clean_company_address;
		cleaned_name         clean_name;
		STRING    license_board_code_desc;
		STRING    bull_lic_type_desc;
		STRING    license_status_desc;
		UNSIGNED8 __internal_fpos__
	END;

	ds_address  				:= DATASET([], rKeyMMCP__autokey__address);
	ds_addressb2				:= DATASET([], rKeyMMCP__autokey__addressb2);
	ds_citystname 			:= DATASET([], rKeyMMCP__autokey__citystname);
	ds_citystnameb2			:= DATASET([], rKeyMMCP__autokey__citystnameb2);
	ds_name 						:= DATASET([], rKeyMMCP__autokey__name);
	ds_nameb2						:= DATASET([], rKeyMMCP__autokey__nameb2);
	ds_namewords2				:= DATASET([], rKeyMMCP__autokey__namewords2);
	ds_payload					:= DATASET([], rKeyMMCP__autokey__payload);
	ds_ssn2							:= DATASET([], rKeyMMCP__autokey__ssn2);
	ds_stname 					:= DATASET([], rKeyMMCP__autokey__stname);
	ds_stnameb2					:= DATASET([], rKeyMMCP__autokey__stnameb2);
	ds_zip  						:= DATASET([], rKeyMMCP__autokey__zip);
	ds_zipb2						:= DATASET([], rKeyMMCP__autokey__zipb2);
  ds_license_number 	:= DATASET([], rKeyMMCP__license_number);
  ds_license_state	  := DATASET([], rKeyMMCP__license_state);

	address_IN  				:= INDEX(ds_address, {prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, lookups}, {ds_address}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::address');
	addressb2_IN				:= INDEX(ds_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_addressb2}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::addressb2');
	citystname_IN	  		:= INDEX(ds_citystname, {city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_citystname}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::citystname');
	citystnameb2_IN			:= INDEX(ds_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_citystnameb2}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::citystnameb2');
	name_IN 						:= INDEX(ds_name, {dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_name}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::name');
	nameb2_IN						:= INDEX(ds_nameb2, {cname_indic, cname_sec, bdid}, {ds_nameb2}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::nameb2');
	namewords2_IN				:= INDEX(ds_namewords2, {word, state, seq, bdid}, {ds_namewords2}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::namewords2');
	payload_IN					:= INDEX(ds_payload, {fakeid}, {ds_payload}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::payload');
	ssn2_IN							:= INDEX(ds_ssn2, {s1, s2, s3, s4, s5, s6, s7, s8, s9, dph_lname, pfname, did}, {ds_ssn2}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::ssn2');
	stname_IN 					:= INDEX(ds_stname, {st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_stname}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::stname');
	stnameb2_IN					:= INDEX(ds_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_stnameb2}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::stnameb2');
	zip_IN  						:= INDEX(ds_zip, {zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_zip}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::zip');
	zipb2_IN						:= INDEX(ds_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_zipb2}, '~prte::key::mmcp::' + pIndexVersion + '::autokey::zipb2');
  license_number_IN		:= INDEX(ds_license_number, {license_number, record_type}, {ds_license_number}, '~prte::key::mmcp::' + pIndexVersion + '::license_number');	
  license_state_IN		:= INDEX(ds_license_state, {state, license_number}, {ds_license_state}, '~prte::key::mmcp::' + pIndexVersion + '::license_state');	

	RETURN SEQUENTIAL(PARALLEL(BUILD(address_IN, update),
														 BUILD(addressb2_IN, update),
														 BUILD(citystname_IN, update),
														 BUILD(citystnameb2_IN, update),
														 BUILD(name_IN, update),
														 BUILD(nameb2_IN, update),
														 BUILD(namewords2_IN, update),
														 BUILD(payload_IN, update),
														 BUILD(ssn2_IN, update),
														 BUILD(stname_IN, update),
														 BUILD(stnameb2_IN, update),
														 BUILD(zip_IN, update),
														 BUILD(zipb2_IN, update),
														 BUILD(license_number_IN, update),
														 BUILD(license_state_IN, update)),
									  PRTE.UpdateVersion('MMCPKeys',											   //	Package name
																	     pIndexVersion,											 //	Package version
																	     _control.MyInfo.EmailAddressNormal, //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;