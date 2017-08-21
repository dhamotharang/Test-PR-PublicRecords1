IMPORT _Control;

EXPORT Proc_Build_CNLD_Facilities_Keys(STRING pIndexVersion) := FUNCTION

	rKeyCNLD_Facilities__autokey__addressb2 := RECORD
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

	
	rKeyCNLD_Facilities__autokey__citystnameb2 := RECORD
		UNSIGNED4 city_code;
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCNLD_Facilities__autokey__fein2 := RECORD
		STRING1   f1;
		STRING1   f2;
		STRING1   f3;
		STRING1   f4;
		STRING1   f5;
		STRING1   f6;
		STRING1   f7;
		STRING1   f8;
		STRING1   f9;
	  STRING40  cname_indic;
	  STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	
	rKeyCNLD_Facilities__autokey__nameb2 := RECORD
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCNLD_Facilities__autokey__namewords2 := RECORD
		STRING40  word;
		STRING2   state;
		UNSIGNED1 seq;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCNLD_Facilities__autokey__payload := RECORD
		unsigned6 fakeid;
		string8 first_seen_date;
		string8 last_seen_date;
		string8 process_date;
		string10 gennum;
		string80 org_name;
		string10 storeno;
		string9 deanbr;
		string8 deanbr_exp;
		string1 deanbr_sch1;
		string1 deanbr_sch2;
		string1 deanbr_sch2n;
		string1 deanbr_sch3;
		string1 deanbr_sch3n;
		string1 deanbr_sch4;
		string1 deanbr_sch5;
		string55 addr_id;
		string55 addr_addr1;
		string55 addr_addr2;
		string30 addr_city;
		string2 addr_st;
		string5 addr_zip;
		string10 addr_phone;
		string10 addr_fax;
		string8 addr_date;
		string1 addr_status;
		string1 addr_rank;
		string2 st_lic_in;
		string15 st_lic_num;
		string8 st_lic_num_exp;
		string3 st_lic_stat;
		string10 st_lic_type;
		string10 fednum;
		string1 fednum_type;
		string3 profcode;
		string40 std_prof_desc;
		string1 profstat;
		string40 std_prof_stat;
		string60 ownername;
		string2 ownertype;
		string10 ncpdpnbr;
		string10 npi;
		string2 factype;
		string1 inhospital;
		string1 inchain;
		string3 aff_code;
		string8 survey_date;
		string1 survey_type;
		string4 def_code;
		string1 def_rate;
		string1 def_status;
		string1 def_type;
		string8 sanction_date;
		string2 sanction_state;
		string30 sanction_case;
		unsigned8 sanction_amt;
		string60 name_dba;
		string50 name_contact;
		unsigned6 bdid;
		unsigned6 bdid_score;
		unsigned6 rawaid;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string9 cln_ssn_taxid;
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
		string5 zip5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		unsigned6 did;
		unsigned1 zero;
		string1 blank;
		unsigned8 __internal_fpos__;
 END;
	
	rKeyCNLD_Facilities__autokey__phoneb2 := RECORD
		STRING7   p7;
		STRING3   p3;
		STRING40  cname_indic;
		STRING40  cname_sec;
		STRING2   st;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;


	rKeyCNLD_Facilities__autokey__stnameb2 := RECORD
		STRING2 st;
		STRING40 cname_indic;
		STRING40 cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCNLD_Facilities__autokey__zipb2 := RECORD
		INTEGER4  zip;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCNLD_Facilities__bdid := RECORD
		UNSIGNED6 bdid;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyCNLD_Facilities__dea := RECORD
		STRING9  	deanbr;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyCNLD_Facilities__fein := RECORD
		STRING9  	cln_ssn_taxid;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;
	
	rKeyCNLD_Facilities__gennum := RECORD
		string10 gennum;
		string8 first_seen_date;
		string8 last_seen_date;
		string8 process_date;
		string80 org_name;
		string10 storeno;
		string9 deanbr;
		string8 deanbr_exp;
		string1 deanbr_sch1;
		string1 deanbr_sch2;
		string1 deanbr_sch2n;
		string1 deanbr_sch3;
		string1 deanbr_sch3n;
		string1 deanbr_sch4;
		string1 deanbr_sch5;
		string55 addr_id;
		string55 addr_addr1;
		string55 addr_addr2;
		string30 addr_city;
		string2 addr_st;
		string5 addr_zip;
		string10 addr_phone;
		string10 addr_fax;
		string8 addr_date;
		string1 addr_status;
		string1 addr_rank;
		string2 st_lic_in;
		string15 st_lic_num;
		string8 st_lic_num_exp;
		string3 st_lic_stat;
		string10 st_lic_type;
		string10 fednum;
		string1 fednum_type;
		string3 profcode;
		string40 std_prof_desc;
		string1 profstat;
		string40 std_prof_stat;
		string60 ownername;
		string2 ownertype;
		string10 ncpdpnbr;
		string10 npi;
		string2 factype;
		string1 inhospital;
		string1 inchain;
		string3 aff_code;
		string8 survey_date;
		string1 survey_type;
		string4 def_code;
		string1 def_rate;
		string1 def_status;
		string1 def_type;
		string8 sanction_date;
		string2 sanction_state;
		string30 sanction_case;
		unsigned8 sanction_amt;
		string60 name_dba;
		string50 name_contact;
		unsigned6 bdid;
		unsigned6 bdid_score;
		unsigned6 rawaid;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string9 cln_ssn_taxid;
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
		string5 zip5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		unsigned8 __internal_fpos__;
 END;

	rKeyCNLD_Facilities__license_nbr := RECORD
		STRING15  st_lic_num;
		STRING2   st_lic_in;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;	
	
	rKeyCNLD_Facilities__ncpdp := RECORD
		STRING10  ncpdpnbr;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;
	
	rKeyCNLD_Facilities__npi := RECORD
		STRING10  npi;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyCNLD_Facilities__zipcode := RECORD
		STRING5 	addr_zip;
		STRING10  gennum;
		UNSIGNED8 __internal_fpos__;
	END;
	rKeyCNLD_Facilities_LinkIds := RECORD
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
		string8 first_seen_date;
		string8 last_seen_date;
		string8 process_date;
		string10 gennum;
		string80 org_name;
		string10 storeno;
		string9 deanbr;
		string8 deanbr_exp;
		string1 deanbr_sch1;
		string1 deanbr_sch2;
		string1 deanbr_sch2n;
		string1 deanbr_sch3;
		string1 deanbr_sch3n;
		string1 deanbr_sch4;
		string1 deanbr_sch5;
		string55 addr_id;
		string55 addr_addr1;
		string55 addr_addr2;
		string30 addr_city;
		string2 addr_st;
		string5 addr_zip;
		string10 addr_phone;
		string10 addr_fax;
		string8 addr_date;
		string1 addr_status;
		string1 addr_rank;
		string2 st_lic_in;
		string15 st_lic_num;
		string8 st_lic_num_exp;
		string3 st_lic_stat;
		string10 st_lic_type;
		string10 fednum;
		string1 fednum_type;
		string3 profcode;
		string40 std_prof_desc;
		string1 profstat;
		string40 std_prof_stat;
		string60 ownername;
		string2 ownertype;
		string10 ncpdpnbr;
		string10 npi;
		string2 factype;
		string1 inhospital;
		string1 inchain;
		string3 aff_code;
		string8 survey_date;
		string1 survey_type;
		string4 def_code;
		string1 def_rate;
		string1 def_status;
		string1 def_type;
		string8 sanction_date;
		string2 sanction_state;
		string30 sanction_case;
		unsigned8 sanction_amt;
		string60 name_dba;
		string50 name_contact;
		unsigned6 bdid;
		unsigned6 bdid_score;
		unsigned6 rawaid;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string9 cln_ssn_taxid;
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
		string5 zip5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		integer1 fp;
 END;
 
	ds_addressb2		:= DATASET([], rKeyCNLD_Facilities__autokey__addressb2);
	ds_citystnameb2	:= DATASET([], rKeyCNLD_Facilities__autokey__citystnameb2);
	ds_fein2				:= DATASET([], rKeyCNLD_Facilities__autokey__fein2);
	ds_nameb2				:= DATASET([], rKeyCNLD_Facilities__autokey__nameb2);
	ds_namewords2		:= DATASET([], rKeyCNLD_Facilities__autokey__namewords2);
	ds_payload			:= DATASET([], rKeyCNLD_Facilities__autokey__payload);
	ds_phoneb2			:= DATASET([], rKeyCNLD_Facilities__autokey__phoneb2);
	ds_stnameb2			:= DATASET([], rKeyCNLD_Facilities__autokey__stnameb2);
	ds_zipb2				:= DATASET([], rKeyCNLD_Facilities__autokey__zipb2);
  ds_bdid      		:= DATASET([], rKeyCNLD_Facilities__bdid);
  ds_dea       		:= DATASET([], rKeyCNLD_Facilities__dea);
	ds_fein      		:= DATASET([], rKeyCNLD_Facilities__fein);
	ds_gennum      	:= DATASET([], rKeyCNLD_Facilities__gennum);
  ds_license_nbr  := DATASET([], rKeyCNLD_Facilities__license_nbr);
  ds_ncpdp  			:= DATASET([], rKeyCNLD_Facilities__ncpdp);
  ds_npi       		:= DATASET([], rKeyCNLD_Facilities__npi);
  ds_zipcode 			:= DATASET([], rKeyCNLD_Facilities__zipcode);
	ds_LinkIds			:= DATASET([],rKeyCNLD_Facilities_LinkIds);

	addressb2_IN		:= INDEX(ds_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_addressb2}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::addressb2');
	citystnameb2_IN	:= INDEX(ds_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_citystnameb2}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::citystnameb2');
	fein2_IN      	:= INDEX(ds_fein2, {f1, f2, f3, f4, f5, f6, f7, f8, f9, cname_indic, cname_sec, bdid}, {ds_fein2}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::fein2');
	nameb2_IN				:= INDEX(ds_nameb2, {cname_indic, cname_sec, bdid}, {ds_nameb2}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::nameb2');
	namewords2_IN		:= INDEX(ds_namewords2, {word, state, seq, bdid}, {ds_namewords2}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::namewords2');
	payload_IN			:= INDEX(ds_payload, {fakeid}, {ds_payload}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::payload');
	phoneb2_IN			:= INDEX(ds_phoneb2, {p7, p3, cname_indic, cname_sec, st, bdid}, {ds_phoneb2}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::phoneb2');
	stnameb2_IN			:= INDEX(ds_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_stnameb2}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::stnameb2');
	zipb2_IN				:= INDEX(ds_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_zipb2}, '~prte::key::cnldfacilites::' + pIndexVersion + '::autokey::zipb2');
	bdid_IN      		:= INDEX(ds_bdid, {bdid}, {ds_bdid}, '~prte::key::cnldfacilities::' + pIndexVersion + '::bdid');	
	dea_IN       		:= INDEX(ds_dea, {deanbr}, {ds_dea}, '~prte::key::cnldfacilities::' + pIndexVersion + '::dea');	
	fein_IN      		:= INDEX(ds_fein, {cln_ssn_taxid}, {ds_fein}, '~prte::key::cnldfacilities::' + pIndexVersion + '::fein');	
	gennum_IN  			:= INDEX(ds_gennum, {gennum}, {ds_gennum}, '~prte::key::cnldfacilities::' + pIndexVersion + '::gennum');	
	license_nbr_IN 	:= INDEX(ds_license_nbr, {st_lic_num, st_lic_in}, {ds_license_nbr}, '~prte::key::cnldfacilities::' + pIndexVersion + '::license_nbr');	
	ncpdp_IN       	:= INDEX(ds_ncpdp, {ncpdpnbr}, {ds_ncpdp}, '~prte::key::cnldfacilities::' + pIndexVersion + '::ncpdp');	
	npi_IN       		:= INDEX(ds_npi, {npi}, {ds_npi}, '~prte::key::cnldfacilities::' + pIndexVersion + '::npi');	
	zipcode_IN      := INDEX(ds_zipcode, {addr_zip}, {ds_zipcode}, '~prte::key::cnldfacilities::' + pIndexVersion + '::zipcode');	
	LinkIds_IN      := INDEX(ds_LinkIds, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_LinkIds}, '~prte::key::cnldfacilities::' + pIndexVersion + '::LinkIds');


	RETURN SEQUENTIAL(PARALLEL(BUILD(addressb2_IN, update),
														 BUILD(citystnameb2_IN, update),
														 BUILD(fein2_IN, update),
														 BUILD(nameb2_IN, update),
														 BUILD(namewords2_IN, update),
														 BUILD(payload_IN, update),
														 BUILD(phoneb2_IN, update),
														 BUILD(stnameb2_IN, update),
														 BUILD(zipb2_IN, update),
 														 BUILD(bdid_IN, update),
														 BUILD(dea_IN, update),
														 BUILD(fein_IN, update),
														 BUILD(gennum_IN, update),
														 BUILD(license_nbr_IN, update),
														 BUILD(ncpdp_IN, update),
														 BUILD(npi_IN, update),
														 BUILD(zipcode_IN, update),
														 BUILD(LinkIds_IN, update)),

										PRTE.UpdateVersion('CNLDFacilitiesKeys',							 //	Package name
																	     pIndexVersion,											 //	Package version
																	    'terri.hardy-george@lexisnexis.com;anantha.venkatachalam@lexisnexis.com', //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;


