import RoxieKeyBuild;

// SuperKeyName := cluster.cluster_out+'key::hunting_fishing::';
// SuperKeyName_CCW := cluster.cluster_out+'key::ccw::';

SuperKeyName 					:= cluster.cluster_out+'key::hunting_fishing::';
SuperKeyName_fcra			:= cluster.cluster_out+'key::hunting_fishing::fcra::';
SuperKeyName_CCW 			:= cluster.cluster_out+'key::ccw::';
SuperKeyName_CCW_fcra := cluster.cluster_out+'key::ccw::fcra::';

RoxieKeyBuild.mac_sk_move('~thor_data400::key::hunters_doxie_did','Q',do1);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::ccw_doxie_did','Q',do2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::did','Q',do3,2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName+'@version@::rid','Q',do4,2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName_CCW+'@version@::did','Q',do5,2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName_CCW+'@version@::rid','Q',do6,2);

RoxieKeyBuild.mac_sk_move('~thor_data400::key::hunters_doxie_did_fcra','Q',fcra_do1);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::ccw_doxie_did_fcra','Q',fcra_do2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName_fcra+'@version@::did','Q',fcra_do3,2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName_fcra+'@version@::rid','Q',fcra_do4,2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName_CCW_fcra+'@version@::did','Q',fcra_do5,2);
RoxieKeyBuild.Mac_SK_Move_V2(SuperKeyName_CCW_fcra+'@version@::rid','Q',fcra_do6,2);


export proc_accept_sk_to_QA := parallel(
                               do1,do2,do3,do4,
															  do5,do6,
                                fcra_do1, fcra_do2, fcra_do3,fcra_do4,
															  fcra_do5,fcra_do6);