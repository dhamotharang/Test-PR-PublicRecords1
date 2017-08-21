import autokey,roxiekeybuild,promotesupers;
promotesupers.MAC_SK_Move_v2('~thor_data400::key::utility_address','Q',mk_addr);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::utility_did','Q',mk_did);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::utility::daily.fdid','Q',big_build1);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::utility::daily.did','Q',big_build2);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::utility::daily.id','Q',big_build3);
AutoKey.MAC_AcceptSK_to_QA('~thor_data400::key::utility::daily.',out_ak,,['-'])

//*** Utility Business Keys
promotesupers.MAC_SK_Move_v2('~thor_data400::key::utility::bus::address','Q',mv_bus_addr);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::utility::daily::bus::bdid','Q',mv_bus_bdid);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::utility::daily::bus::id','Q',mv_bus_id);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::utility::@version@::linkids','Q',mv_link);

// Move Utility Business autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::utility::daily::bus::autokey::@version@::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::utility::daily::bus::autokey::@version@::AddressB2','Q',mv_autokey_addrB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::utility::daily::bus::autokey::@version@::NameB2','Q',mv_autokey_nameB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::utility::daily::bus::autokey::@version@::StNameB2','Q',mv_autokey_stnamB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::utility::daily::bus::autokey::@version@::CityStNameB2','Q',mv_autokey_cityB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::utility::daily::bus::autokey::@version@::ZipB2','Q',mv_autokey_zipB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::utility::daily::bus::autokey::@version@::NameWords2','Q',mv_autokey_Namewords2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::utility::daily::bus::autokey::@version@::PhoneB2','Q',mv_autokey_PhoneB2);

export Proc_AcceptSK_toQA := sequential(mk_addr,mk_did,big_build1,big_build2,big_build3,out_ak,
																				mv_bus_addr, mv_bus_bdid, mv_bus_id, mv_link,
																				mv_fdids_key, mv_autokey_addrB2, mv_autokey_nameB2,
																				mv_autokey_stnamB2, mv_autokey_cityB2, mv_autokey_zipB2,
																				mv_autokey_Namewords2, mv_autokey_PhoneB2
																			 );
																			 
