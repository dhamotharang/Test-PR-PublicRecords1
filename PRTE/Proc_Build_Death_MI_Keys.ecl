IMPORT Address, _Control;

EXPORT Proc_Build_Death_MI_Keys(STRING pIndexVersion) := FUNCTION

	rKeyDeath_MI__autokey__address := RECORD
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

	rKeyDeath_MI__autokey__citystname := RECORD
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

	rKeyDeath_MI__autokey__name := RECORD
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
	
	rKeyDeath_MI__autokey__payload := RECORD
		UNSIGNED6 fakeid;
	  UNSIGNED4 customer_id;
		STRING6   fileno;
		STRING2   occurrence_state;
		STRING4   occurrence_civil_division;
		STRING2   residence_state;
		STRING4   residence_civil_division;
		STRING30  lname;
		STRING30  fname;
		STRING10  mname;
		STRING1   alias_code;
		STRING4   dod_year;
		STRING2   dod_month;
		STRING2   dod_day;
		STRING4   dob_year;
		STRING2   dob_month;
		STRING2   dob_day;
		STRING1   decedent_sex;
		STRING9   ssn;
		STRING25  address;
		STRING15  city;
		STRING2   state;
		STRING15  father_surname;
		STRING15  occurrence_county;
		STRING15  residence_county;
		STRING8   dob;
		STRING8   dod;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		Address.Layout_Clean182_fips clean_address;
    Address.Layout_Clean_Name    clean_name;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyDeath_MI__autokey__stname := RECORD
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

	rKeyDeath_MI__autokey__zip := RECORD
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

	rKeyDeath_MI__did_customer_id := RECORD
		UNSIGNED6 did;
	  UNSIGNED4 customer_id;
		STRING6   fileno;
		STRING2   occurrence_state;
		STRING4   occurrence_civil_division;
		STRING2   residence_state;
		STRING4   residence_civil_division;
		STRING30  lname;
		STRING30  fname;
		STRING10  mname;
		STRING1   alias_code;
		STRING4   dod_year;
		STRING2   dod_month;
		STRING2   dod_day;
		STRING4   dob_year;
		STRING2   dob_month;
		STRING2   dob_day;
		STRING1   decedent_sex;
		STRING9   ssn;
		STRING25  address;
		STRING15  city;
		STRING2   state;
		STRING15  father_surname;
		STRING15  occurrence_county;
		STRING15  residence_county;
		STRING8   dob;
		STRING8   dod;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 bdid;
		Address.Layout_Clean182_fips clean_address;
    Address.Layout_Clean_Name    clean_name;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyDeath_MI__ssn_customer_id := RECORD
		STRING9   ssn;
	  UNSIGNED4 customer_id;
		STRING6   fileno;
		STRING2   occurrence_state;
		STRING4   occurrence_civil_division;
		STRING2   residence_state;
		STRING4   residence_civil_division;
		STRING30  lname;
		STRING30  fname;
		STRING10  mname;
		STRING1   alias_code;
		STRING4   dod_year;
		STRING2   dod_month;
		STRING2   dod_day;
		STRING4   dob_year;
		STRING2   dob_month;
		STRING2   dob_day;
		STRING1   decedent_sex;
		STRING25  address;
		STRING15  city;
		STRING2   state;
		STRING15  father_surname;
		STRING15  occurrence_county;
		STRING15  residence_county;
		STRING8   dob;
		STRING8   dod;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		Address.Layout_Clean182_fips clean_address;
    Address.Layout_Clean_Name    clean_name;
		UNSIGNED8 __internal_fpos__;
	END;

	ds_address  				:= DATASET([], rKeyDeath_MI__autokey__address);
	ds_citystname 			:= DATASET([], rKeyDeath_MI__autokey__citystname);
	ds_name 						:= DATASET([], rKeyDeath_MI__autokey__name);
	ds_payload					:= DATASET([], rKeyDeath_MI__autokey__payload);
	ds_stname 					:= DATASET([], rKeyDeath_MI__autokey__stname);
	ds_zip  						:= DATASET([], rKeyDeath_MI__autokey__zip);
  ds_did_customer_id  := DATASET([], rKeyDeath_MI__did_customer_id);
  ds_ssn_customer_id  := DATASET([], rKeyDeath_MI__ssn_customer_id);

	address_IN  				:= INDEX(ds_address, {prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, lookups}, {ds_address}, '~prte::key::death_mi::' + pIndexVersion + '::autokey::address');
	citystname_IN	  		:= INDEX(ds_citystname, {city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_citystname}, '~prte::key::death_mi::' + pIndexVersion + '::autokey::citystname');
	name_IN 						:= INDEX(ds_name, {dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_name}, '~prte::key::death_mi::' + pIndexVersion + '::autokey::name');
	payload_IN					:= INDEX(ds_payload, {fakeid}, {ds_payload}, '~prte::key::death_mi::' + pIndexVersion + '::autokey::payload');
	stname_IN 					:= INDEX(ds_stname, {st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_stname}, '~prte::key::death_mi::' + pIndexVersion + '::autokey::stname');
	zip_IN  						:= INDEX(ds_zip, {zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_zip}, '~prte::key::death_mi::' + pIndexVersion + '::autokey::zip');
  did_customer_id_IN	:= INDEX(ds_did_customer_id, {did, customer_id}, {ds_did_customer_id}, '~prte::key::death_mi::' + pIndexVersion + '::did_customer_id');	
  ssn_customer_id_IN	:= INDEX(ds_ssn_customer_id, {ssn, customer_id}, {ds_ssn_customer_id}, '~prte::key::death_mi::' + pIndexVersion + '::ssn_customer_id');	

	RETURN SEQUENTIAL(PARALLEL(BUILD(address_IN, update),
														 BUILD(citystname_IN, update),
														 BUILD(name_IN, update),
														 BUILD(payload_IN, update),
														 BUILD(stname_IN, update),
														 BUILD(zip_IN, update),
														 BUILD(did_customer_id_IN, update),
														 BUILD(ssn_customer_id_IN, update)),
									  PRTE.UpdateVersion('Death_MIKeys',										 //	Package name
																	     pIndexVersion,											 //	Package version
																	     _control.MyInfo.EmailAddressNormal, //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;