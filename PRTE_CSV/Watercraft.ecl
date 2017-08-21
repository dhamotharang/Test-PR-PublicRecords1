export Watercraft	:=
module

	shared	lWatercraftSubDirName		:=	'';
	shared	lCSVVersion							:=	'20091218';
	shared	lCSVFileNamePrefix			:=	PRTE_CSV.Constants.CSVFilesBaseName + lWatercraftSubDirName;

	export	rCSVWatercraft__autokey__address	:=
	record
		string28	prim_name;
		string10	prim_range;
		string2		st;
		unsigned4	city_code;
		string5		zip;
		string8		sec_range;
		string6		dph_lname;
		string20	lname;
		string20	pfname;
		string20	fname;
		unsigned8	states;
		unsigned4	lname1;
		unsigned4	lname2;
		unsigned4	lname3;
		unsigned4	lookups;
		unsigned6	did;
	end;

	export	rCSVWatercraft__autokey__addressb2	:=
	record
		string28	prim_name;
		string10	prim_range;
		string2		st;
		unsigned4	city_code;
		string5		zip;
		string8		sec_range;
		string40	cname_indic;
		string40	cname_sec;
		unsigned6	bdid;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__citystname	:=
	record
		unsigned4	city_code;
		string2		st;
		string6		dph_lname;
		string20	lname;
		string20	pfname;
		string20	fname;
		integer4	dob;
		unsigned8	states;
		unsigned4	lname1;
		unsigned4	lname2;
		unsigned4	lname3;
		unsigned4	city1;
		unsigned4	city2;
		unsigned4	city3;
		unsigned4	rel_fname1;
		unsigned4	rel_fname2;
		unsigned4	rel_fname3;
		unsigned4	lookups;
		unsigned6	did;
	end;

	export	rCSVWatercraft__autokey__citystnameb2	:=
	record
		unsigned4	city_code;
		string2		st;
		string40	cname_indic;
		string40	cname_sec;
		unsigned6	bdid;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__fein2	:=
	record
		string1		f1;
		string1		f2;
		string1		f3;
		string1		f4;
		string1		f5;
		string1		f6;
		string1		f7;
		string1		f8;
		string1		f9;
		string40	cname_indic;
		string40	cname_sec;
		unsigned6	bdid;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__name	:=
	record
		string6		dph_lname;
		string20	lname;
		string20	pfname;
		string20	fname;
		string1		minit;
		unsigned2	yob;
		unsigned2	s4;
		integer4	dob;
		unsigned8	states;
		unsigned4	lname1;
		unsigned4	lname2;
		unsigned4	lname3;
		unsigned4	city1;
		unsigned4	city2;
		unsigned4	city3;
		unsigned4	rel_fname1;
		unsigned4	rel_fname2;
		unsigned4	rel_fname3;
		unsigned4	lookups;
		unsigned6	did;
	end;

	export	rCSVWatercraft__autokey__nameb2	:=
	record
		string40	cname_indic;
		string40	cname_sec;
		unsigned6	bdid;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__namewords2	:=
	record
		string40	word;
		string2		state;
		unsigned1	seq;
		unsigned6	bdid;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__payload	:=
	record
		unsigned6	fakeid;
		string30	watercraft_key;
		string30	sequence_key;
		string2		state_origin;
		string20	fname;
		string20	lname;
		string20	mname;
		string8		dob;
		string28	prim_name;
		string10	prim_range;
		string2		st;
		string5		zip5;
		string8		sec_range;
		string60	company_name;
		unsigned6	ldid;
		unsigned6	lbdid;
		string10	phone;
		unsigned1	zero;
		string25	city;
		string2		bstate;
		string25	bcity;
		string10	bphone;
		string10	bprim_range;
		string28	bprim_name;
		string8		bsec_range;
		string5		bzip5;
		string9		fein_use;
		string9		ssn_use;
		unsigned8	__internal_fpos__;
	end;

	export	rCSVWatercraft__autokey__phone2	:=
	record
		string7		p7;
		string3		p3;
		string6		dph_lname;
		string20	pfname;
		string2		st;
		unsigned6	did;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__phoneb2	:=
	record
		string7		p7;
		string3		p3;
		string40	cname_indic;
		string40	cname_sec;
		string2		st;
		unsigned6	bdid;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__ssn2	:=
	record
		string1		s1;
		string1		s2;
		string1		s3;
		string1		s4;
		string1		s5;
		string1		s6;
		string1		s7;
		string1		s8;
		string1		s9;
		string6		dph_lname;
		string20	pfname;
		unsigned6	did;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__stname	:=
	record
		string2		st;
		string6		dph_lname;
		string20	lname;
		string20	pfname;
		string20	fname;
		string1		minit;
		unsigned2	yob;
		unsigned2	s4;
		integer4	zip;
		integer4	dob;
		unsigned8	states;
		unsigned4	lname1;
		unsigned4	lname2;
		unsigned4	lname3;
		unsigned4	city1;
		unsigned4	city2;
		unsigned4	city3;
		unsigned4	rel_fname1;
		unsigned4	rel_fname2;
		unsigned4	rel_fname3;
		unsigned4	lookups;
		unsigned6	did;
	end;

	export	rCSVWatercraft__autokey__stnameb2	:=
	record
		string2		st;
		string40	cname_indic;
		string40	cname_sec;
		unsigned6	bdid;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__autokey__zip	:=
	record
		integer4	zip;
		string6		dph_lname;
		string20	lname;
		string20	pfname;
		string20	fname;
		string1		minit;
		unsigned2	yob;
		unsigned2	s4;
		integer4	dob;
		unsigned8	states;
		unsigned4	lname1;
		unsigned4	lname2;
		unsigned4	lname3;
		unsigned4	city1;
		unsigned4	city2;
		unsigned4	city3;
		unsigned4	rel_fname1;
		unsigned4	rel_fname2;
		unsigned4	rel_fname3;
		unsigned4	lookups;
		unsigned6	did;
	end;

	export	rCSVWatercraft__autokey__zipb2	:=
	record
		integer4	zip;
		string40	cname_indic;
		string40	cname_sec;
		unsigned6	bdid;
		unsigned4	lookups;
	end;

	export	rCSVWatercraft__bdid	:=
	record
		unsigned6	l_bdid;
		string2		state_origin;
		string30	watercraft_key;
		string30	sequence_key;
		unsigned8	__internal_fpos__;
	end;

	export	rCSVWatercraft__cid	:=
	record
		string2		state_origin;
		string30	watercraft_key;
		string30	sequence_key;
		string2		source_code;
		string10	vessel_id;
		string10	vessel_database_key;
		string50	name_of_vessel;
		string8		call_sign;
		string10	official_number;
		string30	imo_number;
		string30	hull_number;
		string30	hull_identification_number;
		string30	vessel_service_type;
		string2		flag;
		string1		self_propelled_indicator;
		string7		registered_gross_tons;
		string7		registered_net_tons;
		string7		registered_length;
		string6		registered_breadth;
		string6		registered_depth;
		string7		itc_gross_tons;
		string7		itc_net_tons;
		string7		itc_length;
		string6		itc_breadth;
		string6		itc_depth;
		string50	hailing_port;
		string2		hailing_port_state;
		string50	hailing_port_province;
		string50	home_port_name;
		string2		home_port_state;
		string50	home_port_province;
		string1		trade_ind_coastwise_unrestricted;
		string1		trade_ind_limited_coastwise_bowaters_only;
		string1		trade_ind_limited_coastwise_restricted;
		string1		trade_ind_limited_coastwise_oil_spill_response_only;
		string1		trade_ind_limited_coastwise_under_charter_to_citizen;
		string1		trade_ind_fishery;
		string1		trade_ind_limited_fishery_only;
		string1		trade_ind_recreation;
		string1		trade_ind_limited_recreation_great_lakes_use_only;
		string1		trade_ind_registry;
		string1		trade_ind_limited_registry_cross_border_financing;
		string1		trade_ind_limited_registry_no_foreign_voyage;
		string1		trade_ind_limited_registry_trade_with_canada_only;
		string1		trade_ind_great_lakes;
		string50	vessel_complete_build_city;
		string2		vessel_complete_build_state;
		string50	vessel_complete_build_province;
		string64	vessel_complete_build_country;
		string4		vessel_build_year;
		string50	vessel_hull_build_city;
		string2		vessel_hull_build_state;
		string50	vessel_hull_build_province;
		string64	vessel_hull_build_country;
		string10	party_identification_number;
		string7		main_hp_ahead;
		string7		main_hp_astern;
		string30	propulsion_type;
		string30	hull_material;
		string50	ship_yard;
		string50	hull_builder_name;
		string11	doc_certificate_status;
		string10	date_issued;
		string10	date_expires;
		string19	hull_design_type;
		string1		sail_ind;
		string10	party_database_key;
		string1		itc_tons_cod_ind;
		unsigned8	__internal_fpos__;
	end;

	export	rCSVWatercraft__did	:=
	record
		unsigned6	l_did;
		string2		state_origin;
		string30	watercraft_key;
		string30	sequence_key;
		unsigned8	__internal_fpos__;
	end;

	export	rCSVWatercraft__hullnum	:=
	record
		string30	hull_number;
		string2		state_origin;
		string30	watercraft_key;
		string30	sequence_key;
		unsigned8	__internal_fpos__;
	end;

	export	rCSVWatercraft__sid	:=
	record
		string2		state_origin;
		string30	watercraft_key;
		string30	sequence_key;
		string8		date_first_seen;
		string8		date_last_seen;
		string8		date_vendor_first_reported;
		string8		date_vendor_last_reported;
		string2		source_code;
		string1		dppa_flag;
		string100	orig_name;
		string1		orig_name_type_code;
		string20	orig_name_type_description;
		string25	orig_name_first;
		string25	orig_name_middle;
		string25	orig_name_last;
		string10	orig_name_suffix;
		string60	orig_address_1;
		string60	orig_address_2;
		string25	orig_city;
		string2		orig_state;
		string10	orig_zip;
		string5		orig_fips;
		string30	orig_province;
		string30	orig_country;
		string8		dob;
		string9		orig_ssn;
		string9		orig_fein;
		string1		gender;
		string10	phone_1;
		string10	phone_2;
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		name_suffix;
		string3		name_cleaning_score;
		string60	company_name;
		string10	prim_range;
		string2		predir;
		string28	prim_name;
		string4		suffix;
		string2		postdir;
		string10	unit_desig;
		string8		sec_range;
		string25	p_city_name;
		string25	v_city_name;
		string2		st;
		string5		zip5;
		string4		zip4;
		string3		county;
		string4		cart;
		string1		cr_sort_sz;
		string4		lot;
		string1		lot_order;
		string2		dpbc;
		string1		chk_digit;
		string2		rec_type;
		string2		ace_fips_st;
		string3		ace_fips_county;
		string10	geo_lat;
		string11	geo_long;
		string4		msa;
		string7		geo_blk;
		string1		geo_match;
		string4		err_stat;
		string12	bdid;
		string9		fein;
		string12	did;
		string3		did_score;
		string9		ssn;
		string1		history_flag;
		unsigned8	__internal_fpos__;
	end;

	export	rCSVWatercraft__vslnam	:=
	record
		string50	vessel_name;
		string2		state_origin;
		string30	watercraft_key;
		string30	sequence_key;
		unsigned8	__internal_fpos__;
	end;

	export	rCSVWatercraft__wid	:=
	record
		string2		state_origin;
		string30	watercraft_key;
		string30	sequence_key;
		string10	watercraft_id;
		string2		source_code;
		string2		st_registration;
		string15	county_registration;
		string20	registration_number;
		string30	hull_number;
		string2		propulsion_code;
		string20	propulsion_description;
		string2		vehicle_type_code;
		string20	vehicle_type_description;
		string1		fuel_code;
		string20	fuel_description;
		string5		hull_type_code;
		string20	hull_type_description;
		string5		use_code;
		string20	use_description;
		string4		model_year;
		string40	watercraft_name;
		string5		watercraft_class_code;
		string35	watercraft_class_description;
		string5		watercraft_make_code;
		string30	watercraft_make_description;
		string5		watercraft_model_code;
		string30	watercraft_model_description;
		string5		watercraft_length;
		string5		watercraft_width;
		string10	watercraft_weight;
		string3		watercraft_color_1_code;
		string20	watercraft_color_1_description;
		string3		watercraft_color_2_code;
		string20	watercraft_color_2_description;
		string2		watercraft_toilet_code;
		string40	watercraft_toilet_description;
		string2		watercraft_number_of_engines;
		string5		watercraft_hp_1;
		string5		watercraft_hp_2;
		string5		watercraft_hp_3;
		string20	engine_number_1;
		string20	engine_number_2;
		string20	engine_number_3;
		string20	engine_make_1;
		string20	engine_make_2;
		string20	engine_make_3;
		string20	engine_model_1;
		string20	engine_model_2;
		string20	engine_model_3;
		string4		engine_year_1;
		string4		engine_year_2;
		string4		engine_year_3;
		string1		coast_guard_documented_flag;
		string30	coast_guard_number;
		string8		registration_date;
		string8		registration_expiration_date;
		string5		registration_status_code;
		string40	registration_status_description;
		string8		registration_status_date;
		string8		registration_renewal_date;
		string20	decal_number;
		string5		transaction_type_code;
		string40	transaction_type_description;
		string2		title_state;
		string5		title_status_code;
		string40	title_status_description;
		string20	title_number;
		string8		title_issue_date;
		string5		title_type_code;
		string20	title_type_description;
		string1		additional_owner_count;
		string1		lien_1_indicator;
		string40	lien_1_name;
		string8		lien_1_date;
		string60	lien_1_address_1;
		string60	lien_1_address_2;
		string25	lien_1_city;
		string2		lien_1_state;
		string10	lien_1_zip;
		string1		lien_2_indicator;
		string40	lien_2_name;
		string8		lien_2_date;
		string60	lien_2_address_1;
		string60	lien_2_address_2;
		string25	lien_2_city;
		string2		lien_2_state;
		string10	lien_2_zip;
		string2		state_purchased;
		string8		purchase_date;
		string40	dealer;
		string10	purchase_price;
		string1		new_used_flag;
		string5		watercraft_status_code;
		string20	watercraft_status_description;
		string1		history_flag;
		string1		coastguard_flag;
		string4		signatory;
		unsigned8	__internal_fpos__;
	end;
	
export	rCSVWatercraft__LinkIDs	:=
	RECORD
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
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string30 watercraft_key;
  string30 sequence_key;
  string2 state_origin;
  string2 source_code;
  string1 dppa_flag;
  string100 orig_name;
  string1 orig_name_type_code;
  string20 orig_name_type_description;
  string25 orig_name_first;
  string25 orig_name_middle;
  string25 orig_name_last;
  string10 orig_name_suffix;
  string60 orig_address_1;
  string60 orig_address_2;
  string25 orig_city;
  string2 orig_state;
  string10 orig_zip;
  string5 orig_fips;
  string30 orig_province;
  string30 orig_country;
  string8 dob;
  string9 orig_ssn;
  string9 orig_fein;
  string1 gender;
  string10 phone_1;
  string10 phone_2;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_cleaning_score;
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
  string12 bdid;
  string9 fein;
  string12 did;
  string3 did_score;
  string9 ssn;
  string1 history_flag;
  unsigned8 rawaid;
  string100 reg_owner_name_2;
  unsigned8 persistent_record_id;
  unsigned8 source_rec_id;
  integer1 fp;
 END;

 
	export	dCSVWatercraft__autokey__address			:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__address.csv', rCSVWatercraft__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__addressb2		:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__addressb2.csv', rCSVWatercraft__autokey__addressb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__citystname		:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__citystname.csv', rCSVWatercraft__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__citystnameb2	:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__citystnameb2.csv', rCSVWatercraft__autokey__citystnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__fein2				:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__fein2.csv', rCSVWatercraft__autokey__fein2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__name					:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__name.csv', rCSVWatercraft__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__nameb2				:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__nameb2.csv', rCSVWatercraft__autokey__nameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__namewords2		:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__namewords2.csv', rCSVWatercraft__autokey__namewords2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__payload			:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__payload.csv', rCSVWatercraft__autokey__payload, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__phone2				:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__phone2.csv', rCSVWatercraft__autokey__phone2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__phoneb2			:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__phoneb2.csv', rCSVWatercraft__autokey__phoneb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__ssn2					:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__ssn2.csv', rCSVWatercraft__autokey__ssn2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__stname				:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__stname.csv', rCSVWatercraft__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__stnameb2			:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__stnameb2.csv', rCSVWatercraft__autokey__stnameb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__zip					:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__zip.csv', rCSVWatercraft__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__autokey__zipb2				:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__autokey__zipb2.csv', rCSVWatercraft__autokey__zipb2, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__bdid									:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__bdid.csv', rCSVWatercraft__bdid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__cid										:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__cid.csv', rCSVWatercraft__cid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__did										:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__did.csv', rCSVWatercraft__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__hullnum								:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__hullnum.csv', rCSVWatercraft__hullnum, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__sid										:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__sid.csv', rCSVWatercraft__sid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__vslnam								:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__vslnam.csv', rCSVWatercraft__vslnam, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__wid										:= 	dataset(lCSVFileNamePrefix + 'thor_data400__key__watercraft__' + lCSVVersion + '__wid.csv', rCSVWatercraft__wid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export	dCSVWatercraft__LinkIDs								:= 	dataset([],rCSVWatercraft__LinkIDs);
end;