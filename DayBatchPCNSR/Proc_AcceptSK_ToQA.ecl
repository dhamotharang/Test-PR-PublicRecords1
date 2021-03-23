import roxiekeybuild, ut, autokey;

/*ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.address',  'Q', mv_address_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.did', 'Q',mv_did_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.lz3', 'Q', mv_lz3_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.zz4317_deduped',  'Q',mv_zz4317_deduped_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.phone.area_code.st',  'Q',mv_phone_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.lz3_deduped', 'Q', mv_lz3_deduped_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.z137lf',  'Q',mv_z137lf_key, 2);
ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.hhid', 'Q',mv_hhid_key, 2);*/

// RoxieKeyBuild.Mac_SK_Move('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.address','Q',mv_address_key);
ut.mac_sk_move_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.address',  'Q', mv_address_key, 2);
RoxieKeyBuild.Mac_SK_Move('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.did','Q',mv_did_key);
RoxieKeyBuild.Mac_SK_Move('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.lz3','Q',mv_lz3_key);
//RoxieKeyBuild.Mac_SK_Move('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.zz4317_deduped','Q',mv_zz4317_deduped_key);
//RoxieKeyBuild.Mac_SK_Move('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.phone.area_code.st','Q',mv_phone_key);
//RoxieKeyBuild.Mac_SK_Move('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.lz3_deduped','Q',mv_lz3_deduped_key);
RoxieKeyBuild.Mac_SK_Move('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.z137lf','Q',mv_z137lf_key);
RoxieKeyBuild.Mac_SK_Move('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.hhid','Q',mv_hhid_key);

export Proc_AcceptSK_ToQA :=  parallel(mv_address_key, mv_did_key, mv_lz3_key, /*mv_zz4317_deduped_key,
										mv_phone_key, mv_lz3_deduped_key,*/ mv_z137lf_key, mv_hhid_key);
					  



