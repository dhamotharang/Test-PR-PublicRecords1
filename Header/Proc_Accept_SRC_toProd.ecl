import ut;
ut.mac_sk_move_v2('~thor_data400::key::ak_src_index','P',do1,2);
ut.mac_sk_move_v2('~thor_data400::key::atf_src_index','P',do2,2);
ut.mac_sk_move_v2('~thor_data400::key::bk_src_index','P',do3,2);
ut.mac_sk_move_v2('~thor_data400::key::lien_src_index','P',do4,2);
ut.mac_sk_move_v2('~thor_data400::key::dl_src_index','P',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::em_src_index','P',do6,2);
ut.mac_sk_move_v2('~thor_data400::key::ms_src_index','P',do7,2);
ut.mac_sk_move_v2('~thor_data400::key::death_src_index','P',do8,2);
ut.mac_sk_move_v2('~thor_data400::key::statedeath_src_index','P',do9,2);
ut.mac_sk_move_v2('~thor_data400::key::prof_src_index','P',do10,2);
ut.mac_sk_move_v2('~thor_data400::key::propasses_src_index','P',do11,2);
ut.mac_sk_move_v2('~thor_data400::key::propdeed_src_index','P',do12,2);
ut.mac_sk_move_v2('~thor_data400::key::util_src_index','P',do13,2);
ut.mac_sk_move_v2('~thor_data400::key::veh_src_index','P',do14,2);
ut.mac_sk_move_v2('~thor_data400::key::airm_src_index','P',do15,2);
ut.mac_sk_move_v2('~thor_data400::key::for_src_index','P',do16,2);
ut.mac_sk_move_v2('~thor_data400::key::dea_src_index','P',do17,2);
ut.mac_sk_move_v2('~thor_data400::key::water_src_index','P',do18,2);
ut.mac_sk_move_v2('~thor_data400::key::airc_src_index','P',do19,2);
ut.mac_sk_move_v2('~thor_data400::key::eq_src_index','P',do20,2);
ut.mac_sk_move_v2('~thor_data400::key::boater_src_index','P',do21,2);
ut.mac_sk_move_v2('~thor_data400::key::LNTU_src_index','P',do22,2);


export Proc_Accept_SRC_toProd := parallel(do1,
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
do22);