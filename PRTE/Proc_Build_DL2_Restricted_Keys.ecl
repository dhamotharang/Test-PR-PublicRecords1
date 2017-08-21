IMPORT _Control;

EXPORT Proc_Build_DL2_Restricted_Keys(STRING pIndexVersion) := FUNCTION

	rKeyDL2Restricted__dl_restricted_did_public := RECORD
		UNSIGNED6 did;
		UNSIGNED6 dl_seq;
		UNSIGNED6 preglb_did;
		UNSIGNED3 dt_first_seen;
		UNSIGNED3 dt_last_seen;
		UNSIGNED3 dt_vendor_first_reported;
		UNSIGNED3 dt_vendor_last_reported;
		STRING14  dlcp_key;
		STRING2   orig_state;
		STRING2   source_code;
		STRING1   history;
		QSTRING52 name;
		STRING1   addr_type;
		QSTRING40 addr1;
		QSTRING20 city;
		QSTRING2  state;
		QSTRING5  zip;
		STRING2   province;
		STRING3   country;
		STRING10  postal_code;
		UNSIGNED4 dob;
		STRING1   race;
		STRING1   sex_flag;
		STRING6   license_class;
		QSTRING4  license_type;
		QSTRING4  moxie_license_type;
		QSTRING14 attention_flag;
		QSTRING8  dod;
		QSTRING42 restrictions;
		QSTRING42 restrictions_delimited;
		UNSIGNED4 orig_expiration_date;
		UNSIGNED4 orig_issue_date;
		UNSIGNED4 lic_issue_date;
		UNSIGNED4 expiration_date;
		UNSIGNED3 active_date;
		UNSIGNED3 inactive_date;
		QSTRING10 lic_endorsement;
		QSTRING4  motorcycle_code;
		QSTRING24 dl_number;
		QSTRING9  ssn;
		QSTRING9  ssn_safe;
		QSTRING3  age;
		STRING1   privacy_flag;
		STRING1   driver_edu_code;
		STRING1   dup_lic_count;
		STRING1   rcd_stat_flag;
		QSTRING3  height;
		QSTRING3  hair_color;
		QSTRING3  eye_color;
		QSTRING3  weight;
		QSTRING25 oos_previous_dl_number;
		STRING2   oos_previous_st;
		QSTRING5  title;
		QSTRING20 fname;
		QSTRING20 mname;
		QSTRING20 lname;
		QSTRING5  name_suffix;
		QSTRING3  cleaning_score;
		STRING1   addr_fix_flag;
		QSTRING10 prim_range;
		QSTRING2  predir;
		QSTRING28 prim_name;
		QSTRING4  suffix;
		QSTRING2  postdir;
		QSTRING10 unit_desig;
		QSTRING8  sec_range;
		QSTRING25 p_city_name;
		QSTRING25 v_city_name;
		QSTRING2  st;
		QSTRING5  zip5;
		QSTRING4  zip4;
		QSTRING4  cart;
		STRING1   cr_sort_sz;
		QSTRING4  lot;
		STRING1   lot_order;
		STRING2   dpbc;
		STRING1   chk_digit;
		STRING2   rec_type;
		STRING2   ace_fips_st;
		QSTRING3  county;
		QSTRING10 geo_lat;
		QSTRING11 geo_long;
		QSTRING4  msa;
		QSTRING7  geo_blk;
		STRING1   geo_match;
		QSTRING4  err_stat;
		STRING3   status;
		QSTRING2  issuance;
		QSTRING8  address_change;
		STRING1   name_change;
		STRING1   dob_change;
		STRING1   sex_change;
		QSTRING24 old_dl_number;
		QSTRING9  dl_key_number;
		STRING3   cdl_status;
		STRING1   record_type;
		STRING18  county_name;
		STRING30  history_name;
		STRING30  attention_name;
		STRING30  race_name;
		STRING30  sex_name;
		STRING30  hair_color_name;
		STRING30  eye_color_name;
		STRING30  orig_state_name;
		UNSIGNED8 __internal_fpos__
	END;

  ds_dl_restricted_did_public := DATASET([], rKeyDL2Restricted__dl_restricted_did_public);

  dl_restricted_did_public_IN := INDEX(ds_dl_restricted_did_public, {did}, {ds_dl_restricted_did_public}, '~prte::key::dl2::' + pIndexVersion + '::dl_restricted_did_public');	

	RETURN SEQUENTIAL(BUILD(dl_restricted_did_public_IN, UPDATE),
									  PRTE.UpdateVersion('DLV2RestrictedKeys',						   //	Package name
																	     pIndexVersion,											 //	Package version
																	     _Control.MyInfo.EmailAddressNormal, //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );

END;