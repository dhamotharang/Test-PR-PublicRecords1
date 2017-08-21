IMPORT _Control;

EXPORT Proc_Build_NCPDP_Keys(STRING pIndexVersion) := FUNCTION

	rKeyNCPDP__autokey__address := RECORD
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

	rKeyNCPDP__autokey__addressb2 := RECORD
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

	rKeyNCPDP__autokey__citystname := RECORD
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

	rKeyNCPDP__autokey__citystnameb2 := RECORD
		UNSIGNED4 city_code;
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyNCPDP__autokey__fein2 := RECORD
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

	rKeyNCPDP__autokey__name := RECORD
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

	rKeyNCPDP__autokey__nameb2 := RECORD
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyNCPDP__autokey__namewords2 := RECORD
		STRING40  word;
		STRING2   state;
		UNSIGNED1 seq;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyNCPDP__autokey__contlegal__payload := RECORD
		UNSIGNED6 fakeid;
		STRING7   ncpdp_provider_id;
		STRING12  dea_registration_id;
		STRING10  national_provider_id;
		UNSIGNED6 did;
	  STRING200 business_name;
		STRING9   fein;
		STRING10  business_phone;
		STRING28  business_prim_name;
		STRING10  business_prim_range;
		STRING2   business_st;
		STRING50  business_city;
		STRING5   business_zip;
		STRING8   business_sec_range;
    UNSIGNED6 bdid;
		STRING25  first_name;
		STRING1   middle_initial;
		STRING25  last_name;
		STRING10  phone;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyNCPDP__autokey__dba__payload := RECORD
		UNSIGNED6 fakeid;
		STRING7   ncpdp_provider_id;
		STRING12  dea_registration_id;
		STRING10  national_provider_id;
		UNSIGNED6 did;
	  STRING200 business_name;
		STRING9   fein;
		STRING10  business_phone;
		STRING28  business_prim_name;
		STRING10  business_prim_range;
		STRING2   business_st;
		STRING50  business_city;
		STRING5   business_zip;
		STRING8   business_sec_range;
    UNSIGNED6 bdid;
	END;

	rKeyNCPDP__autokey__phone2 := RECORD
		STRING7   p7;
		STRING3   p3;
		STRING6   dph_lname;
		STRING20  pfname;
		STRING2   st;
		UNSIGNED6 did;
		UNSIGNED4 lookups;
	END;

	rKeyNCPDP__autokey__phoneb2 := RECORD
		STRING7   p7;
		STRING3   p3;
		STRING40  cname_indic;
		STRING40  cname_sec;
		STRING2   st;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyNCPDP__autokey__stname := RECORD
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

	rKeyNCPDP__autokey__stnameb2 := RECORD
		STRING2 st;
		STRING40 cname_indic;
		STRING40 cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyNCPDP__autokey__zip := RECORD
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

	rKeyNCPDP__autokey__zipb2 := RECORD
		INTEGER4  zip;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyNCPDP__bdid := RECORD
		UNSIGNED6 bdid;
		STRING7   ncpdp_provider_id;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyNCPDP__dea := RECORD
		STRING12  dea_registration_id;
		STRING7   ncpdp_provider_id;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyNCPDP__did := RECORD
		UNSIGNED6 did;
		STRING7   ncpdp_provider_id;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyNCPDP__fein := RECORD
		STRING15  federal_tax_id;
		STRING7   ncpdp_provider_id;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyNCPDP__linkids := RECORD
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
		string7 ncpdp_provider_id;
		string60 legal_business_name;
		string60 dba;
		string10 store_number;
		string55 phys_loc_address1;
		string55 phys_loc_address2;
		string30 phys_loc_city;
		string2 phys_loc_state;
		string9 phys_loc_full_zip;
		string10 phys_loc_phone;
		string5 phys_loc_phone_ext;
		string10 phys_loc_fax_number;
		string50 phys_loc_email;
		string50 phys_loc_cross_street;
		string5 phys_loc_fips;
		string4 phys_loc_msa;
		string4 phys_loc_pmsa;
		string1 phys_loc_24hr_operation;
		string35 phys_loc_provider_hours;
		string1 phys_loc_accepts_eprescriptions;
		string1 phys_loc_delivery_service;
		string1 phys_loc_compounding_service;
		string1 phys_loc_driveup_window;
		string1 phys_loc_durable_med_equip;
		string4 phys_loc_voting_district;
		string2 phys_loc_language_code1;
		string2 phys_loc_language_code2;
		string2 phys_loc_language_code3;
		string2 phys_loc_language_code4;
		string2 phys_loc_language_code5;
		string1 phys_loc_handicap_access;
		string8 phys_loc_store_open_date;
		string8 phys_loc_store_close_date;
		string55 address1;
		string55 address2;
		string30 city;
		string2 state;
		string9 full_zip;
		string20 contact_last_name;
		string20 contact_first_name;
		string1 contact_middle_initial;
		string30 contact_title;
		string10 contact_phone;
		string5 contact_phone_ext;
		string50 contact_email;
		string2 dispenser_class_code;
		string2 primary_dispenser_type_code;
		string2 secondary_dispenser_type_code;
		string2 tertiary_dispenser_type_code;
		string10 medicare_provider_id;
		string10 national_provider_id;
		string12 dea_registration_id;
		string15 federal_tax_id;
		string20 state_license_number;
		string15 state_income_tax_id;
		string20 sundayhours;
		string20 mondayhours;
		string20 tuesdayhours;
		string20 wednesdayhours;
		string20 thursdayhours;
		string20 fridayhours;
		string20 saturdayhours;
		string20 languagecode1desc;
		string20 languagecode2desc;
		string20 languagecode3desc;
		string20 languagecode4desc;
		string20 languagecode5desc;
		string25 dispensingclassdesc;
		string70 primarydispensingtypedesc;
		string70 secondarydispensingtypedesc;
		string70 tertiarydispensingtypedesc;
		unsigned6 bdid;
		unsigned6 did;
		unsigned6 dt_first_seen;
		unsigned6 dt_last_seen;
		string100 append_phyaddr1;
		string50 append_phyaddrlast;
		unsigned8 append_phyrawaid;
		unsigned8 append_phyaceaid;
		string100 append_mailaddr1;
		string50 append_mailaddrlast;
		unsigned8 append_mailrawaid;
		unsigned8 append_mailaceaid;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 suffix;
		string10 phys_prim_range;
		string2 phys_predir;
		string28 phys_prim_name;
		string4 phys_addr_suffix;
		string2 phys_postdir;
		string10 phys_unit_desig;
		string8 phys_sec_range;
		string25 phys_p_city_name;
		string25 phys_v_city_name;
		string2 phys_state;
		string5 phys_zip5;
		string4 phys_zip4;
		string4 phys_cart;
		string1 phys_cr_sort_sz;
		string4 phys_lot;
		string1 phys_lot_order;
		string2 phys_dpbc;
		string1 phys_chk_digit;
		string2 phys_rec_type;
		string2 phys_ace_fips_st;
		string3 phys_county;
		string10 phys_geo_lat;
		string11 phys_geo_long;
		string4 phys_msa;
		string7 phys_geo_blk;
		string1 phys_geo_match;
		string4 phys_err_stat;
		string10 mail_prim_range;
		string2 mail_predir;
		string28 mail_prim_name;
		string4 mail_addr_suffix;
		string2 mail_postdir;
		string10 mail_unit_desig;
		string8 mail_sec_range;
		string25 mail_p_city_name;
		string25 mail_v_city_name;
		string2 mail_state;
		string5 mail_zip5;
		string4 mail_zip4;
		string4 mail_cart;
		string1 mail_cr_sort_sz;
		string4 mail_lot;
		string1 mail_lot_order;
		string2 mail_dpbc;
		string1 mail_chk_digit;
		string2 mail_rec_type;
		string2 mail_ace_fips_st;
		string3 mail_county;
		string10 mail_geo_lat;
		string11 mail_geo_long;
		string4 mail_msa;
		string7 mail_geo_blk;
		string1 mail_geo_match;
		string4 mail_err_stat;
		integer1 fp;
 END;



	rKeyNCPDP__ncpdp_id := RECORD
		STRING7   NCPDP_provider_id;
		STRING1   record_type;
		STRING60  legal_business_name;
		STRING60  DBA;
		STRING10  store_number;
		STRING55  phys_loc_address1;
		STRING55  phys_loc_address2;
		STRING30  phys_loc_city;
		STRING2   phys_loc_state;
		STRING9   phys_loc_full_zip;
		STRING10  phys_loc_phone;
		STRING5   phys_loc_phone_ext;
		STRING10  phys_loc_fax_number;
		STRING50  phys_loc_email;
		STRING50  phys_loc_cross_street;
		STRING5   phys_loc_FIPS;
		STRING4   phys_loc_MSA;
		STRING4   phys_loc_PMSA;
		STRING1   phys_loc_24hr_operation;
		STRING35  phys_loc_provider_hours;
		STRING1   phys_loc_accepts_ePrescriptions;
		STRING1   phys_loc_delivery_service;
		STRING1   phys_loc_compounding_service;
		STRING1   phys_loc_driveup_window;
		STRING1   phys_loc_durable_med_equip;
		STRING4   phys_loc_voting_district;
		STRING2   phys_loc_language_code1;
		STRING2   phys_loc_language_code2;
		STRING2   phys_loc_language_code3;
		STRING2   phys_loc_language_code4;
		STRING2   phys_loc_language_code5;
		STRING1   phys_loc_handicap_access;
		STRING8   phys_loc_store_open_date;
		STRING8   phys_loc_store_close_date;
		STRING55  address1;
		STRING55  address2;
		STRING30  city;
		STRING2   state;
		STRING9   full_zip;
		STRING20  contact_last_name;
		STRING20  contact_first_name;
		STRING1   contact_middle_initial;
		STRING30  contact_title;
		STRING10  contact_phone;
		STRING5   contact_phone_ext;
		STRING50  contact_email;
		STRING2   dispenser_class_code;
		STRING2   primary_dispenser_type_code;
		STRING2   secondary_dispenser_type_code;
		STRING2   tertiary_dispenser_type_code;
		STRING10  medicare_provider_id;
		STRING10  national_provider_id;
		STRING12  DEA_registration_id;
		STRING15  federal_tax_id;
		STRING20  state_license_number;
		STRING15  state_income_tax_id;
		STRING20	SundayHours;
		STRING20	MondayHours;
		STRING20	TuesdayHours;
		STRING20	WednesdayHours;
		STRING20	ThursdayHours;
		STRING20	FridayHours;
		STRING20	SaturdayHours;
		STRING20	languageCode1Desc;
		STRING20	languageCode2Desc;
		STRING20	languageCode3Desc;
		STRING20	languageCode4Desc;
		STRING20	languageCode5Desc;
		STRING25	dispensingClassDesc;
		STRING70	PrimaryDispensingTypeDesc;
		STRING70	SecondaryDispensingTypeDesc;
		STRING70	TertiaryDispensingTypeDesc;
		UNSIGNED6 bdid;
		UNSIGNED6 did;
		UNSIGNED6 Dt_First_Seen;
		UNSIGNED6 Dt_Last_Seen;
		STRING100	Append_PhyAddr1;
		STRING50	Append_PhyAddrLast;
		UNSIGNED8	Append_PhyRawAID;
		UNSIGNED8	Append_PhyAceAID;
		STRING100	Append_MailAddr1;
		STRING50	Append_MailAddrLast;
		UNSIGNED8	Append_MailRawAID;
		UNSIGNED8	Append_MailAceAID;
		STRING20  fname;
		STRING20  mname;
		STRING20  lname;
		STRING5   suffix;
		STRING10  Phys_prim_range;
		STRING2   Phys_predir;
		STRING28  Phys_prim_name;
		STRING4   Phys_addr_suffix;
		STRING2   Phys_postdir;
		STRING10  Phys_unit_desig;
		STRING8   Phys_sec_range;
		STRING25  Phys_p_city_name;
		STRING25  Phys_v_city_name;
		STRING2   Phys_state;
		STRING5   Phys_zip5;
		STRING4   Phys_zip4;
		STRING4   Phys_cart;
		STRING1   Phys_cr_sort_sz;
		STRING4   Phys_lot;
		STRING1   Phys_lot_order;
		STRING2   Phys_dpbc;
		STRING1   Phys_chk_digit;
		STRING2   Phys_rec_type;
		STRING2   Phys_ace_fips_st;
		STRING3   Phys_county;
		STRING10  Phys_geo_lat;
		STRING11  Phys_geo_long;
		STRING4   Phys_msa;
		STRING7   Phys_geo_blk;
		STRING1   Phys_geo_match;
		STRING4   Phys_err_stat;
		STRING10  Mail_prim_range;
		STRING2   Mail_predir;
		STRING28  Mail_prim_name;
		STRING4   Mail_addr_suffix;
		STRING2   Mail_postdir;
		STRING10  Mail_unit_desig;
		STRING8   Mail_sec_range;
		STRING25  Mail_p_city_name;
		STRING25  Mail_v_city_name;
		STRING2   Mail_state;
		STRING5   Mail_zip5;
		STRING4   Mail_zip4;
		STRING4   Mail_cart;
		STRING1   Mail_cr_sort_sz;
		STRING4   Mail_lot;
		STRING1   Mail_lot_order;
		STRING2   Mail_dpbc;
		STRING1   Mail_chk_digit;
		STRING2   Mail_rec_type;
		STRING2   Mail_ace_fips_st;
		STRING3   Mail_county;
		STRING10  Mail_geo_lat;
		STRING11  Mail_geo_long;
		STRING4   Mail_msa;
		STRING7   Mail_geo_blk;
		STRING1   Mail_geo_match;
		STRING4   Mail_err_stat;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyNCPDP__npi := RECORD
		STRING10  national_provider_id;
		STRING7   ncpdp_provider_id;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyNCPDP__sln_state := RECORD
		STRING20  state_license_number;
		STRING2   Phys_state;
		STRING7   ncpdp_provider_id;
		UNSIGNED8 __internal_fpos__;
	END;
	
	rKeyNCPDP__lnpid := RECORD
		unsigned8 lnpid;
		string7 ncpdp_provider_id;
		unsigned8 __internal_fpos__ ;
  END;

	ds_contlegalmail_address  		:= DATASET([], rKeyNCPDP__autokey__address);
	ds_contlegalmail_addressb2		:= DATASET([], rKeyNCPDP__autokey__addressb2);
	ds_contlegalmail_citystname 	:= DATASET([], rKeyNCPDP__autokey__citystname);
	ds_contlegalmail_citystnameb2	:= DATASET([], rKeyNCPDP__autokey__citystnameb2);
	ds_contlegalmail_fein2				:= DATASET([], rKeyNCPDP__autokey__fein2);
	ds_contlegalmail_name 				:= DATASET([], rKeyNCPDP__autokey__name);
	ds_contlegalmail_nameb2				:= DATASET([], rKeyNCPDP__autokey__nameb2);
	ds_contlegalmail_namewords2		:= DATASET([], rKeyNCPDP__autokey__namewords2);
	ds_contlegalmail_payload			:= DATASET([], rKeyNCPDP__autokey__contlegal__payload);
	ds_contlegalmail_phone2		  	:= DATASET([], rKeyNCPDP__autokey__phone2);
	ds_contlegalmail_phoneb2			:= DATASET([], rKeyNCPDP__autokey__phoneb2);
	ds_contlegalmail_stname 			:= DATASET([], rKeyNCPDP__autokey__stname);
	ds_contlegalmail_stnameb2			:= DATASET([], rKeyNCPDP__autokey__stnameb2);
	ds_contlegalmail_zip  				:= DATASET([], rKeyNCPDP__autokey__zip);
	ds_contlegalmail_zipb2				:= DATASET([], rKeyNCPDP__autokey__zipb2);
	ds_contlegalphys_address  		:= DATASET([], rKeyNCPDP__autokey__address);
	ds_contlegalphys_addressb2		:= DATASET([], rKeyNCPDP__autokey__addressb2);
	ds_contlegalphys_citystname 	:= DATASET([], rKeyNCPDP__autokey__citystname);
	ds_contlegalphys_citystnameb2	:= DATASET([], rKeyNCPDP__autokey__citystnameb2);
	ds_contlegalphys_fein2				:= DATASET([], rKeyNCPDP__autokey__fein2);
	ds_contlegalphys_name 				:= DATASET([], rKeyNCPDP__autokey__name);
	ds_contlegalphys_nameb2				:= DATASET([], rKeyNCPDP__autokey__nameb2);
	ds_contlegalphys_namewords2		:= DATASET([], rKeyNCPDP__autokey__namewords2);
	ds_contlegalphys_payload			:= DATASET([], rKeyNCPDP__autokey__contlegal__payload);
	ds_contlegalphys_phone2		  	:= DATASET([], rKeyNCPDP__autokey__phone2);
	ds_contlegalphys_phoneb2			:= DATASET([], rKeyNCPDP__autokey__phoneb2);
	ds_contlegalphys_stname 			:= DATASET([], rKeyNCPDP__autokey__stname);
	ds_contlegalphys_stnameb2			:= DATASET([], rKeyNCPDP__autokey__stnameb2);
	ds_contlegalphys_zip  				:= DATASET([], rKeyNCPDP__autokey__zip);
	ds_contlegalphys_zipb2				:= DATASET([], rKeyNCPDP__autokey__zipb2);
	ds_dbamail_addressb2					:= DATASET([], rKeyNCPDP__autokey__addressb2);
	ds_dbamail_citystnameb2				:= DATASET([], rKeyNCPDP__autokey__citystnameb2);
	ds_dbamail_fein2							:= DATASET([], rKeyNCPDP__autokey__fein2);
	ds_dbamail_nameb2							:= DATASET([], rKeyNCPDP__autokey__nameb2);
	ds_dbamail_namewords2					:= DATASET([], rKeyNCPDP__autokey__namewords2);
	ds_dbamail_payload						:= DATASET([], rKeyNCPDP__autokey__dba__payload);
	ds_dbamail_phoneb2						:= DATASET([], rKeyNCPDP__autokey__phoneb2);
	ds_dbamail_stnameb2						:= DATASET([], rKeyNCPDP__autokey__stnameb2);
	ds_dbamail_zipb2							:= DATASET([], rKeyNCPDP__autokey__zipb2);
	ds_dbaphys_addressb2					:= DATASET([], rKeyNCPDP__autokey__addressb2);
	ds_dbaphys_citystnameb2				:= DATASET([], rKeyNCPDP__autokey__citystnameb2);
	ds_dbaphys_fein2							:= DATASET([], rKeyNCPDP__autokey__fein2);
	ds_dbaphys_nameb2							:= DATASET([], rKeyNCPDP__autokey__nameb2);
	ds_dbaphys_namewords2					:= DATASET([], rKeyNCPDP__autokey__namewords2);
	ds_dbaphys_payload						:= DATASET([], rKeyNCPDP__autokey__dba__payload);
	ds_dbaphys_phoneb2						:= DATASET([], rKeyNCPDP__autokey__phoneb2);
	ds_dbaphys_stnameb2						:= DATASET([], rKeyNCPDP__autokey__stnameb2);
	ds_dbaphys_zipb2							:= DATASET([], rKeyNCPDP__autokey__zipb2);
  ds_bdid      									:= DATASET([], rKeyNCPDP__bdid);
  ds_dea       									:= DATASET([], rKeyNCPDP__dea);
  ds_did       									:= DATASET([], rKeyNCPDP__did);
  ds_fein      									:= DATASET([], rKeyNCPDP__fein);
	ds_linkids										:= DATASET([], rKeyNCPDP__linkids);		
  ds_ncpdp_id  									:= DATASET([], rKeyNCPDP__ncpdp_id);
  ds_npi       									:= DATASET([], rKeyNCPDP__npi);
  ds_sln_state 									:= DATASET([], rKeyNCPDP__sln_state);
	ds_lnpid 											:= DATASET([], rKeyNCPDP__lnpid);

	contlegalmail_address_IN  		:= INDEX(ds_contlegalmail_address, {prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, lookups}, {ds_contlegalmail_address}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::address');
	contlegalmail_addressb2_IN		:= INDEX(ds_contlegalmail_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_contlegalmail_addressb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::addressb2');
	contlegalmail_citystname_IN	  := INDEX(ds_contlegalmail_citystname, {city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_contlegalmail_citystname}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::citystname');
	contlegalmail_citystnameb2_IN	:= INDEX(ds_contlegalmail_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_contlegalmail_citystnameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::citystnameb2');
	contlegalmail_fein2_IN      	:= INDEX(ds_contlegalmail_fein2, {f1, f2, f3, f4, f5, f6, f7, f8, f9, cname_indic, cname_sec, bdid}, {ds_contlegalmail_fein2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::fein2');
	contlegalmail_name_IN 				:= INDEX(ds_contlegalmail_name, {dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_contlegalmail_name}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::name');
	contlegalmail_nameb2_IN				:= INDEX(ds_contlegalmail_nameb2, {cname_indic, cname_sec, bdid}, {ds_contlegalmail_nameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::nameb2');
	contlegalmail_namewords2_IN		:= INDEX(ds_contlegalmail_namewords2, {word, state, seq, bdid}, {ds_contlegalmail_namewords2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::namewords2');
	contlegalmail_payload_IN			:= INDEX(ds_contlegalmail_payload, {fakeid}, {ds_contlegalmail_payload}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::payload');
	contlegalmail_phone2_IN 			:= INDEX(ds_contlegalmail_phone2, {p7, p3, dph_lname, pfname, st, did}, {ds_contlegalmail_phone2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::phone2');
	contlegalmail_phoneb2_IN			:= INDEX(ds_contlegalmail_phoneb2, {p7, p3, cname_indic, cname_sec, st, bdid}, {ds_contlegalmail_phoneb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::phoneb2');
	contlegalmail_stname_IN 			:= INDEX(ds_contlegalmail_stname, {st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_contlegalmail_stname}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::stname');
	contlegalmail_stnameb2_IN			:= INDEX(ds_contlegalmail_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_contlegalmail_stnameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::stnameb2');
	contlegalmail_zip_IN  				:= INDEX(ds_contlegalmail_zip, {zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_contlegalmail_zip}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::zip');
	contlegalmail_zipb2_IN				:= INDEX(ds_contlegalmail_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_contlegalmail_zipb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalmail::zipb2');
	contlegalphys_address_IN  		:= INDEX(ds_contlegalphys_address, {prim_name, prim_range, st, city_code, zip, sec_range, dph_lname, lname, pfname, fname, states, lname1, lname2, lname3, lookups}, {ds_contlegalphys_address}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::address');
	contlegalphys_addressb2_IN		:= INDEX(ds_contlegalphys_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_contlegalphys_addressb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::addressb2');
	contlegalphys_citystname_IN	  := INDEX(ds_contlegalphys_citystname, {city_code, st, dph_lname, lname, pfname, fname, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_contlegalphys_citystname}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::citystname');
	contlegalphys_citystnameb2_IN	:= INDEX(ds_contlegalphys_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_contlegalphys_citystnameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::citystnameb2');
	contlegalphys_fein2_IN      	:= INDEX(ds_contlegalphys_fein2, {f1, f2, f3, f4, f5, f6, f7, f8, f9, cname_indic, cname_sec, bdid}, {ds_contlegalphys_fein2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::fein2');
	contlegalphys_name_IN 				:= INDEX(ds_contlegalphys_name, {dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_contlegalphys_name}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::name');
	contlegalphys_nameb2_IN				:= INDEX(ds_contlegalphys_nameb2, {cname_indic, cname_sec, bdid}, {ds_contlegalphys_nameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::nameb2');
	contlegalphys_namewords2_IN		:= INDEX(ds_contlegalphys_namewords2, {word, state, seq, bdid}, {ds_contlegalphys_namewords2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::namewords2');
	contlegalphys_payload_IN			:= INDEX(ds_contlegalphys_payload, {fakeid}, {ds_contlegalphys_payload}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::payload');
	contlegalphys_phone2_IN 			:= INDEX(ds_contlegalphys_phone2, {p7, p3, dph_lname, pfname, st, did}, {ds_contlegalphys_phone2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::phone2');
	contlegalphys_phoneb2_IN			:= INDEX(ds_contlegalphys_phoneb2, {p7, p3, cname_indic, cname_sec, st, bdid}, {ds_contlegalphys_phoneb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::phoneb2');
	contlegalphys_stname_IN 			:= INDEX(ds_contlegalphys_stname, {st, dph_lname, lname, pfname, fname, minit, yob, s4, zip, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_contlegalphys_stname}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::stname');
	contlegalphys_stnameb2_IN			:= INDEX(ds_contlegalphys_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_contlegalphys_stnameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::stnameb2');
	contlegalphys_zip_IN  				:= INDEX(ds_contlegalphys_zip, {zip, dph_lname, lname, pfname, fname, minit, yob, s4, dob, states, lname1, lname2, lname3, city1, city2, city3, rel_fname1, rel_fname2, rel_fname3, lookups}, {ds_contlegalphys_zip}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::zip');
	contlegalphys_zipb2_IN				:= INDEX(ds_contlegalphys_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_contlegalphys_zipb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::contlegalphys::zipb2');
	dbamail_addressb2_IN					:= INDEX(ds_dbamail_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_dbamail_addressb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::addressb2');
	dbamail_citystnameb2_IN				:= INDEX(ds_dbamail_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_dbamail_citystnameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::citystnameb2');
	dbamail_fein2_IN      				:= INDEX(ds_dbamail_fein2, {f1, f2, f3, f4, f5, f6, f7, f8, f9, cname_indic, cname_sec, bdid}, {ds_dbamail_fein2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::fein2');
	dbamail_nameb2_IN							:= INDEX(ds_dbamail_nameb2, {cname_indic, cname_sec, bdid}, {ds_dbamail_nameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::nameb2');
	dbamail_namewords2_IN					:= INDEX(ds_dbamail_namewords2, {word, state, seq, bdid}, {ds_dbamail_namewords2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::namewords2');
	dbamail_payload_IN						:= INDEX(ds_dbamail_payload, {fakeid}, {ds_dbamail_payload}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::payload');
	dbamail_phoneb2_IN						:= INDEX(ds_dbamail_phoneb2, {p7, p3, cname_indic, cname_sec, st, bdid}, {ds_dbamail_phoneb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::phoneb2');
	dbamail_stnameb2_IN						:= INDEX(ds_dbamail_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_dbamail_stnameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::stnameb2');
	dbamail_zipb2_IN							:= INDEX(ds_dbamail_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_dbamail_zipb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbamail::zipb2');
	dbaphys_addressb2_IN					:= INDEX(ds_dbaphys_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_dbaphys_addressb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::addressb2');
	dbaphys_citystnameb2_IN				:= INDEX(ds_dbaphys_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_dbaphys_citystnameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::citystnameb2');
	dbaphys_fein2_IN      				:= INDEX(ds_dbaphys_fein2, {f1, f2, f3, f4, f5, f6, f7, f8, f9, cname_indic, cname_sec, bdid}, {ds_dbaphys_fein2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::fein2');
	dbaphys_nameb2_IN							:= INDEX(ds_dbaphys_nameb2, {cname_indic, cname_sec, bdid}, {ds_dbaphys_nameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::nameb2');
	dbaphys_namewords2_IN					:= INDEX(ds_dbaphys_namewords2, {word, state, seq, bdid}, {ds_dbaphys_namewords2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::namewords2');
	dbaphys_payload_IN						:= INDEX(ds_dbaphys_payload, {fakeid}, {ds_dbaphys_payload}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::payload');
	dbaphys_phoneb2_IN						:= INDEX(ds_dbaphys_phoneb2, {p7, p3, cname_indic, cname_sec, st, bdid}, {ds_dbaphys_phoneb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::phoneb2');
	dbaphys_stnameb2_IN						:= INDEX(ds_dbaphys_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_dbaphys_stnameb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::stnameb2');
	dbaphys_zipb2_IN							:= INDEX(ds_dbaphys_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_dbaphys_zipb2}, '~prte::key::ncpdp::' + pIndexVersion + '::autokey::dbaphys::zipb2');
  bdid_IN      									:= INDEX(ds_bdid, {bdid}, {ds_bdid}, '~prte::key::ncpdp::' + pIndexVersion + '::bdid');	
  dea_IN       									:= INDEX(ds_dea, {dea_registration_id}, {ds_dea}, '~prte::key::ncpdp::' + pIndexVersion + '::dea');	
  did_IN       									:= INDEX(ds_did, {did}, {ds_did}, '~prte::key::ncpdp::' + pIndexVersion + '::did');	
  fein_IN      									:= INDEX(ds_fein, {federal_tax_id}, {ds_fein}, '~prte::key::ncpdp::' + pIndexVersion + '::fein');	
  linkids_IN   									:= INDEX(ds_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_linkids}, '~prte::key::ncpdp::' + pIndexVersion + '::linkids');	
  ncpdp_id_IN  									:= INDEX(ds_ncpdp_id, {NCPDP_provider_id}, {ds_ncpdp_id}, '~prte::key::ncpdp::' + pIndexVersion + '::ncpdp_id');	
  npi_IN       									:= INDEX(ds_npi, {national_provider_id}, {ds_npi}, '~prte::key::ncpdp::' + pIndexVersion + '::npi');	
  sln_state_IN 									:= INDEX(ds_sln_state, {state_license_number, Phys_state}, {ds_sln_state}, '~prte::key::ncpdp::' + pIndexVersion + '::sln_state');	
	lnpid_IN 											:= INDEX(ds_lnpid, {lnpid}, {ds_lnpid}, '~prte::key::ncpdp::' + pIndexVersion + '::lnpid');	

	RETURN SEQUENTIAL(PARALLEL(BUILD(contlegalmail_address_IN, update),
														 BUILD(contlegalmail_addressb2_IN, update),
														 BUILD(contlegalmail_citystname_IN, update),
														 BUILD(contlegalmail_citystnameb2_IN, update),
														 BUILD(contlegalmail_fein2_IN, update),
														 BUILD(contlegalmail_name_IN, update),
														 BUILD(contlegalmail_nameb2_IN, update),
														 BUILD(contlegalmail_namewords2_IN, update),
														 BUILD(contlegalmail_payload_IN, update),
														 BUILD(contlegalmail_phone2_IN, update),
														 BUILD(contlegalmail_phoneb2_IN, update),
														 BUILD(contlegalmail_stname_IN, update),
														 BUILD(contlegalmail_stnameb2_IN, update),
														 BUILD(contlegalmail_zip_IN, update),
														 BUILD(contlegalmail_zipb2_IN, update),
														 BUILD(contlegalphys_address_IN, update),
														 BUILD(contlegalphys_addressb2_IN, update),
														 BUILD(contlegalphys_citystname_IN, update),
														 BUILD(contlegalphys_citystnameb2_IN, update),
														 BUILD(contlegalphys_fein2_IN, update),
														 BUILD(contlegalphys_name_IN, update),
														 BUILD(contlegalphys_nameb2_IN, update),
														 BUILD(contlegalphys_namewords2_IN, update),
														 BUILD(contlegalphys_payload_IN, update),
														 BUILD(contlegalphys_phone2_IN, update),
														 BUILD(contlegalphys_phoneb2_IN, update),
														 BUILD(contlegalphys_stname_IN, update),
														 BUILD(contlegalphys_stnameb2_IN, update),
														 BUILD(contlegalphys_zip_IN, update),
														 BUILD(contlegalphys_zipb2_IN, update),
														 BUILD(dbamail_addressb2_IN, update),
														 BUILD(dbamail_citystnameb2_IN, update),
														 BUILD(dbamail_fein2_IN, update),
														 BUILD(dbamail_nameb2_IN, update),
														 BUILD(dbamail_namewords2_IN, update),
														 BUILD(dbamail_payload_IN, update),
														 BUILD(dbamail_phoneb2_IN, update),
														 BUILD(dbamail_stnameb2_IN, update),
														 BUILD(dbamail_zipb2_IN, update),
														 BUILD(dbaphys_addressb2_IN, update),
														 BUILD(dbaphys_citystnameb2_IN, update),
														 BUILD(dbaphys_fein2_IN, update),
														 BUILD(dbaphys_nameb2_IN, update),
														 BUILD(dbaphys_namewords2_IN, update),
														 BUILD(dbaphys_payload_IN, update),
														 BUILD(dbaphys_phoneb2_IN, update),
														 BUILD(dbaphys_stnameb2_IN, update),
														 BUILD(dbaphys_zipb2_IN, update),
														 BUILD(bdid_IN, update),
														 BUILD(dea_IN, update),
														 BUILD(did_IN, update),
														 BUILD(fein_IN, update),
														 BUILD(linkids_IN, update),														 
														 BUILD(ncpdp_id_IN, update),
														 BUILD(npi_IN, update),
														 BUILD(sln_state_IN, update),
														 BUILD(lnpid_IN, update)),
									  PRTE.UpdateVersion('NCPDPKeys',											   //	Package name
																	     pIndexVersion,											 //	Package version
																	     _control.MyInfo.EmailAddressNormal, //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;