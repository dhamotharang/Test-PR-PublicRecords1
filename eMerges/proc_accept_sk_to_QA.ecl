import ut, roxiekeybuild;

SuperKeyName := cluster.cluster_out+'key::hunting_fishing::';

ut.mac_sk_move('~thor_data400::key::hunters_doxie_did','Q',do1)
ut.mac_sk_move('~thor_data400::key::ccw_doxie_did','Q',do2)
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::did','Q',do3,2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::rid','Q',do4,2);

export proc_accept_sk_to_QA := parallel(do1,do2,do3,do4);