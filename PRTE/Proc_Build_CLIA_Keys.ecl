IMPORT _Control;

EXPORT Proc_Build_CLIA_Keys(STRING pIndexVersion) := FUNCTION

	rKeyCLIA__autokey__addressb2 := RECORD
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

	rKeyCLIA__autokey__citystnameb2 := RECORD
		UNSIGNED4 city_code;
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCLIA__autokey__nameb2 := RECORD
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCLIA__autokey__namewords2 := RECORD
		STRING40  word;
		STRING2   state;
		UNSIGNED1 seq;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
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
	
  cleaned_phones := RECORD
		STRING10 phone;
  END;
	
	rKeyCLIA__autokey__payload := RECORD
		UNSIGNED6 fakeid;
		STRING10  clia_number;
		STRING50  lab_type;
		STRING75  facility_name;
		STRING75  facility_name2;
		STRING55  address1;
		STRING55  address2;
		STRING30  city;
		STRING2   state;
		STRING5   zip;
		STRING4   zip4;
		STRING10  facility_phone;
		STRING50  certificate_type;
		STRING8   expiration_date;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyCLIA__autokey__phoneb2 := RECORD
		STRING7   p7;
		STRING3   p3;
		STRING40  cname_indic;
		STRING40  cname_sec;
		STRING2   st;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCLIA__autokey__stnameb2 := RECORD
		STRING2   st;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCLIA__autokey__zipb2 := RECORD
		INTEGER4  zip;
		STRING40  cname_indic;
		STRING40  cname_sec;
		UNSIGNED6 bdid;
		UNSIGNED4 lookups;
	END;

	rKeyCLIA__bdid := RECORD
		UNSIGNED6 bdid;
		STRING10  clia_number;
		STRING50  lab_type;
		STRING75  facility_name;
		STRING75  facility_name2;
		STRING55  address1;
		STRING55  address2;
		STRING30  city;
		STRING2   state;
		STRING5   zip;
		STRING4   zip4;
		STRING10  facility_phone;
		STRING50  certificate_type;
		STRING8   expiration_date;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED1 bdid_score;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	rKeyCLIA__clia__number := RECORD
		STRING10  clia_number;
		STRING1   record_type;
		STRING50  lab_type;
		STRING75  facility_name;
		STRING75  facility_name2;
		STRING55  address1;
		STRING55  address2;
		STRING30  city;
		STRING2   state;
		STRING5   zip;
		STRING4   zip4;
		STRING10  facility_phone;
		STRING50  certificate_type;
		STRING8   expiration_date;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		layout_clean182_fips clean_company_address;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__
	END;

	ds_addressb2									:= DATASET([], rKeyCLIA__autokey__addressb2);
	ds_citystnameb2								:= DATASET([], rKeyCLIA__autokey__citystnameb2);
	ds_nameb2											:= DATASET([], rKeyCLIA__autokey__nameb2);
	ds_namewords2									:= DATASET([], rKeyCLIA__autokey__namewords2);
	ds_payload										:= DATASET([], rKeyCLIA__autokey__payload);
	ds_phoneb2										:= DATASET([], rKeyCLIA__autokey__phoneb2);
	ds_stnameb2										:= DATASET([], rKeyCLIA__autokey__stnameb2);
	ds_zipb2											:= DATASET([], rKeyCLIA__autokey__zipb2);
  ds_bdid							      		:= DATASET([], rKeyCLIA__bdid);
  ds_clia_number			       		:= DATASET([], rKeyCLIA__clia__number);

	addressb2_IN									:= INDEX(ds_addressb2, {prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_addressb2}, '~prte::key::clia::' + pIndexVersion + '::autokey::addressb2');
	citystnameb2_IN								:= INDEX(ds_citystnameb2, {city_code, st, cname_indic, cname_sec, bdid}, {ds_citystnameb2}, '~prte::key::clia::' + pIndexVersion + '::autokey::citystnameb2');
	nameb2_IN											:= INDEX(ds_nameb2, {cname_indic, cname_sec, bdid}, {ds_nameb2}, '~prte::key::clia::' + pIndexVersion + '::autokey::nameb2');
	namewords2_IN									:= INDEX(ds_namewords2, {word, state, seq, bdid}, {ds_namewords2}, '~prte::key::clia::' + pIndexVersion + '::autokey::namewords2');
	payload_IN										:= INDEX(ds_payload, {fakeid}, {ds_payload}, '~prte::key::clia::' + pIndexVersion + '::autokey::payload');
	phoneb2_IN										:= INDEX(ds_phoneb2, {p7, p3, cname_indic, cname_sec, st, bdid}, {ds_phoneb2}, '~prte::key::clia::' + pIndexVersion + '::autokey::phoneb2');
	stnameb2_IN										:= INDEX(ds_stnameb2, {st, cname_indic, cname_sec, bdid}, {ds_stnameb2}, '~prte::key::clia::' + pIndexVersion + '::autokey::stnameb2');
	zipb2_IN											:= INDEX(ds_zipb2, {zip, cname_indic, cname_sec, bdid}, {ds_zipb2}, '~prte::key::clia::' + pIndexVersion + '::autokey::zipb2');
  bdid_IN 											:= INDEX(ds_bdid, {bdid, clia_number}, {ds_bdid}, '~prte::key::clia::' + pIndexVersion + '::bdid');	
  clia_number_IN 								:= INDEX(ds_clia_number, {clia_number, record_type}, {ds_clia_number}, '~prte::key::clia::' + pIndexVersion + '::clia_number');	

	RETURN SEQUENTIAL(PARALLEL(BUILD(addressb2_IN, update),
														 BUILD(citystnameb2_IN, update),
														 BUILD(nameb2_IN, update),
														 BUILD(namewords2_IN, update),
														 BUILD(payload_IN, update),
														 BUILD(phoneb2_IN, update),
														 BUILD(stnameb2_IN, update),
														 BUILD(zipb2_IN, update),
														 BUILD(bdid_IN, update),
														 BUILD(clia_number_IN, update)),
									  PRTE.UpdateVersion('CLIAKeys',											   //	Package name
																	     pIndexVersion,											 //	Package version
																	     _control.MyInfo.EmailAddressNormal, //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;