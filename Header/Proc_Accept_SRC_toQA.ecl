import ut;
ut.mac_sk_move_v2('~thor_data400::key::ak_src_index','Q',do1,2);
ut.mac_sk_move_v2('~thor_data400::key::atf_src_index','Q',do2,2);
ut.mac_sk_move_v2('~thor_data400::key::bkv2_src_index','Q',do3,2);
ut.mac_sk_move_v2('~thor_data400::key::lien_src_index','Q',do4,2);
ut.mac_sk_move_v2('~thor_data400::key::dlv2_src_index','Q',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::em_src_index','Q',do6,2);
ut.mac_sk_move_v2('~thor_data400::key::ms_src_index','Q',do7,2);
ut.mac_sk_move_v2('~thor_data400::key::death_src_index','Q',do8,2);
ut.mac_sk_move_v2('~thor_data400::key::statedeath_src_index','Q',do9,2);
ut.mac_sk_move_v2('~thor_data400::key::prof_src_index','Q',do10,2);
ut.mac_sk_move_v2('~thor_data400::key::propasses_src_index','Q',do11,2);
ut.mac_sk_move_v2('~thor_data400::key::propdeed_src_index','Q',do12,2);
ut.mac_sk_move_v2('~thor_data400::key::util_src_index','Q',do13,2);
ut.mac_sk_move_v2('~thor_data400::key::veh_src_index','Q',do14,2);
ut.mac_sk_move_v2('~thor_data400::key::airm_src_index','Q',do15,2);
ut.mac_sk_move_v2('~thor_data400::key::for_src_index','Q',do16,2);
ut.mac_sk_move_v2('~thor_data400::key::dea_src_index','Q',do17,2);
ut.mac_sk_move_v2('~thor_data400::key::water_src_index','Q',do18,2);
ut.mac_sk_move_v2('~thor_data400::key::airc_src_index','Q',do19,2);
ut.mac_sk_move_v2('~thor_data400::key::eq_src_index','Q',do20,2);
ut.mac_sk_move_v2('~thor_data400::key::boater_src_index','Q',do21,2);
ut.mac_sk_move_v2('~thor_data400::key::LNTU_src_index','Q',do22,2);
ut.mac_sk_move_v2('~thor_data400::key::lienv2_src_index','Q',do23,2);
ut.mac_sk_move_v2('~thor_data400::key::targ_src_index','Q',do24,2);
ut.mac_sk_move_v2('~thor_data400::key::asl_src_index','Q',do25,2);
ut.mac_sk_move_v2('~thor_data400::key::voters_src_index','Q',do26,2);
ut.mac_sk_move_v2('~thor_data400::key::veh_v2_src_index','Q',do27,2);
ut.mac_sk_move_v2('~thor_data400::key::certegy_src_index','Q',do28,2);
ut.mac_sk_move_v2('~thor_data400::key::tucs_src_index','Q',do29,2);
ut.mac_sk_move_v2('~thor_data400::key::nod_src_index','Q',do30,2);
ut.mac_sk_move_v2('~thor_data400::key::experian_src_index','Q',do31,2);
ut.mac_sk_move_v2('~thor_data400::key::exprnph_src_index','Q',do32,2);


export Proc_Accept_SRC_toQA := parallel(do1,
do2,
do3,
do4,
do5,
do6,
do7,
do8,
do9,
do10,
do11,
do12,
do13,
do14,
do15,
do16,
do17,
do18,
do19,
do20,
do21,
do22,
do23,
do24,
do25,
do26,
do27,
do28,
do29,
do30,
do31,
do32
);