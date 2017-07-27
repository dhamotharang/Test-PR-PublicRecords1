import ut,roxiekeybuild, doxie_files;

export proc_build_keys_bid(string version_date) := module

	RoxieKeyBuild.MAC_SK_BuildProcess_Local(doxie_files.key_aircraft_did_FCRA_bid,'~thor_data400::key::faa::fcra::'+version_date+'::aircraft_reg_did_bid','~thor_data400::key::fcra::aircraft_reg_did_bid',export b1_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_aircraft_reg_bid,'~thor_data400::key::aircraft_reg_bid','~thor_data400::key::faa::'+version_date+'::aircraft_reg_bid',export b2_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_aircraft_reg_nnum_bid,'~thor_data400::key::aircraft_reg_nnum_bid','~thor_data400::key::faa::'+version_date+'::aircraft_reg_nnum_bid',export b3_key);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_aircraft_id_bid,'~thor_data400::key::aircraft_id_bid','~thor_data400::key::faa::'+version_date+'::aircraft_id_bid',export b4_key);

	RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::faa::fcra::'+version_date+'::aircraft_reg_did_bid','~thor_data400::key::fcra::aircraft_reg_did_bid',export b1);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aircraft_reg_bid','~thor_data400::key::faa::'+version_date+'::aircraft_reg_bid',export b2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aircraft_reg_nnum_bid','~thor_data400::key::faa::'+version_date+'::aircraft_reg_nnum_bid',export b3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aircraft_id_bid','~thor_data400::key::faa::'+version_date+'::aircraft_id_bid',export b4);

	export build_autokeys := proc_build_autokeys_bid(version_date);

	// Move autokeys to QA
	//Business Keys
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::faa::autokey::bid::payload', 'Q', mv_autokey_payload);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::AddressB2','Q',mv_autokey_addrB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::NameB2','Q',mv_autokey_nameB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::StNameB2','Q',mv_autokey_stnamB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::CityStNameB2','Q',mv_autokey_cityB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::ZipB2','Q',mv_autokey_zipB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::NameWords2','Q',mv_autokey_Namewords2);
	// Person keys
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::ssn2','Q',mv_autokey_ssn);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::Name','Q',mv_autokey_name);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::Address','Q',mv_autokey_addr);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::StName','Q',mv_autokey_stnam);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::CityStName','Q',mv_autokey_city);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::faa::autokey::bid::Zip','Q',mv_autokey_zip);

	move_qa := faa.proc_accept_sk_to_QA_bid;

	export mv_keys := parallel(mv_autokey_payload,
										 mv_autokey_ssn,
										 mv_autokey_name,
										 mv_autokey_addr,
										 mv_autokey_stnam,
										 mv_autokey_city,
										 mv_autokey_zip,
										 mv_autokey_addrB2,
										 mv_autokey_nameB2,
										 mv_autokey_stnamB2,
										 mv_autokey_cityB2,
										 mv_autokey_zipB2,
										 mv_autokey_Namewords2,
										 move_qa);
	
end;