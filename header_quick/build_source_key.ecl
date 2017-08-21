import roxiekeybuild,header;

export build_source_key(string filedate='00000000') := function

dl_index                 := Header.Key_Src_DLv2(true,false);
bkv3_index               := Header.Key_Src_bkv2(true,false);
vehicle_v2_index         := header.Key_Src_VehV2(true,false);
eq_index                 := Header.Key_Src_EQ(true,false);
PropAsses_index          := Header.Key_Src_PropAssess(true,false);
PropDeed_index           := Header.Key_Src_Deed(true,false);
liensv2_index            := Header.Key_Src_Lienv2(true,false);
Experian_index           := Header.key_src_experian(true,false);
TransunionCred_index     := Header.Key_Src_TN(true,false);

RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(dl_index,            '~thor_data400::key::dlv2_src_index_fheader',      '~thor_data400::key::header::'+filedate+'::dlv2_src_fheader',       bld_dl);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(bkv3_index,          '~thor_data400::key::bkv2_src_index_fheader',      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src_fheader',bld_bkv3);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(vehicle_v2_index,    '~thor_data400::key::veh_v2_src_index_fheader',    '~thor_data400::key::header::'+filedate+'::veh_v2_src_fheader',     bld_veh_v2);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(eq_index,            '~thor_data400::key::eq_src_index_fheader',        '~thor_data400::key::header::'+filedate+'::eq_src_fheader',         bld_eq);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(liensv2_index,       '~thor_data400::key::lienv2_src_index_fheader',    '~thor_data400::key::header::'+filedate+'::lienv2_src_fheader',     bld_liensv2);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(PropAsses_index,     '~thor_data400::key::PropAsses_src_index_fheader', '~thor_data400::key::header::'+filedate+'::PropAsses_src_fheader',  bld_PropAsses);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(PropDeed_index,      '~thor_data400::key::PropDeed_src_index_fheader',  '~thor_data400::key::header::'+filedate+'::PropDeed_src_fheader',   bld_PropDeed);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Experian_index,      '~thor_data400::key::Experian_src_index_fheader',	'~thor_data400::key::header::'+filedate+'::Experian_src_fheader',   bld_Experian);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(TransunionCred_index,'~thor_data400::key::TN_src_index_fheader',        '~thor_data400::key::header::'+filedate+'::TN_src_fheader',         bld_TransunionCred);

RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PropDeed_src_index_fheader',  '~thor_data400::key::header::'+filedate+'::PropDeed_src_fheader',   mv_PropDeed);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dlv2_src_index_fheader',      '~thor_data400::key::header::'+filedate+'::dlv2_src_fheader',       mv_dl);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::eq_src_index_fheader',        '~thor_data400::key::header::'+filedate+'::eq_src_fheader',         mv_eq);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::lienv2_src_index_fheader',    '~thor_data400::key::header::'+filedate+'::lienv2_src_fheader',     mv_liensv2);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PropAsses_src_index_fheader', '~thor_data400::key::header::'+filedate+'::PropAsses_src_fheader',  mv_PropAsses);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bkv2_src_index_fheader',      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src_fheader',mv_bkv3);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::veh_v2_src_index_fheader',    '~thor_data400::key::header::'+filedate+'::veh_v2_src_fheader',     mv_veh_v2);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::experian_src_index_fheader',  '~thor_data400::key::header::'+filedate+'::Experian_src_fheader',   mv_Experian);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::TN_src_index_fheader',        '~thor_data400::key::header::'+filedate+'::TN_src_fheader',         mv_TransunionCred);


return	sequential(
									parallel(
													bld_liensv2
													,bld_dl
													,bld_eq
													,bld_bkv3
													,bld_veh_v2
													,bld_Experian
													,bld_TransunionCred
													,bld_propasses
													,bld_propdeed
													)
									,parallel(
													mv_liensv2
													,mv_dl
													,mv_propasses
													,mv_propdeed
													,mv_eq
													,mv_bkv3
													,mv_veh_v2
													,mv_Experian
													,mv_TransunionCred
													)
							    );

end;