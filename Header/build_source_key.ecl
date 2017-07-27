import roxiekeybuild,ak_perm_fund,atf,bankrupt,drivers,emerges,govdata,prof_license,property,utilfile,vehlic,ut,ln_tu,ln_property,ln_mortgage,faa,watercraft,dea;

export build_source_key(string filedate=header.version_build,boolean pFastHeader = false) := function

dl_index                 := Header.Key_Src_DLv2(pFastHeader,false);
bkv3_index               := Header.Key_Src_bkv2(pFastHeader,false);
vehicle_v2_index         := header.Key_Src_VehV2(pFastHeader,false);
eq_index                 := Header.Key_Src_EQ(pFastHeader,false);
PropAsses_index          := Header.Key_Src_PropAssess(pFastHeader,false);
PropDeed_index           := Header.Key_Src_Deed(pFastHeader,false);
liensv2_index            := Header.Key_Src_Lienv2(pFastHeader,false);
Experian_index           := Header.key_src_experian(pFastHeader,false);
TransunionCred_index     := Header.Key_Src_TN(pFastHeader,false);

RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(dl_index,            '~thor_data400::key::dlv2_src_index'+SF_suffix(pFastHeader),      '~thor_data400::key::header::'+filedate+'::dlv2_src'+SF_suffix(pFastHeader),       bld_dl);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(bkv3_index,          '~thor_data400::key::bkv2_src_index'+SF_suffix(pFastHeader),      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src'+SF_suffix(pFastHeader),bld_bkv3);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(vehicle_v2_index,    '~thor_data400::key::veh_v2_src_index'+SF_suffix(pFastHeader),    '~thor_data400::key::header::'+filedate+'::veh_v2_src'+SF_suffix(pFastHeader),     bld_veh_v2);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(eq_index,            '~thor_data400::key::eq_src_index'+SF_suffix(pFastHeader),        '~thor_data400::key::header::'+filedate+'::eq_src'+SF_suffix(pFastHeader),         bld_eq);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(liensv2_index,       '~thor_data400::key::lienv2_src_index'+SF_suffix(pFastHeader),    '~thor_data400::key::header::'+filedate+'::lienv2_src'+SF_suffix(pFastHeader),     bld_liensv2);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(PropAsses_index,     '~thor_data400::key::PropAsses_src_index'+SF_suffix(pFastHeader), '~thor_data400::key::header::'+filedate+'::PropAsses_src'+SF_suffix(pFastHeader),  bld_PropAsses);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(PropDeed_index,      '~thor_data400::key::PropDeed_src_index'+SF_suffix(pFastHeader),  '~thor_data400::key::header::'+filedate+'::PropDeed_src'+SF_suffix(pFastHeader),   bld_PropDeed);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Experian_index,      '~thor_data400::key::Experian_src_index'+SF_suffix(pFastHeader),	'~thor_data400::key::header::'+filedate+'::Experian_src'+SF_suffix(pFastHeader),   bld_Experian);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(TransunionCred_index,'~thor_data400::key::TN_src_index'+SF_suffix(pFastHeader),        '~thor_data400::key::header::'+filedate+'::TN_src'+SF_suffix(pFastHeader),         bld_TransunionCred);

RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PropDeed_src_index'+SF_suffix(pFastHeader),  '~thor_data400::key::header::'+filedate+'::PropDeed_src'+SF_suffix(pFastHeader),   mv_PropDeed);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dlv2_src_index'+SF_suffix(pFastHeader),      '~thor_data400::key::header::'+filedate+'::dlv2_src'+SF_suffix(pFastHeader),       mv_dl);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::eq_src_index'+SF_suffix(pFastHeader),        '~thor_data400::key::header::'+filedate+'::eq_src'+SF_suffix(pFastHeader),         mv_eq);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::lienv2_src_index'+SF_suffix(pFastHeader),    '~thor_data400::key::header::'+filedate+'::lienv2_src'+SF_suffix(pFastHeader),     mv_liensv2);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PropAsses_src_index'+SF_suffix(pFastHeader), '~thor_data400::key::header::'+filedate+'::PropAsses_src'+SF_suffix(pFastHeader),  mv_PropAsses);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bkv2_src_index'+SF_suffix(pFastHeader),      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src'+SF_suffix(pFastHeader),mv_bkv3);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::veh_v2_src_index'+SF_suffix(pFastHeader),    '~thor_data400::key::header::'+filedate+'::veh_v2_src'+SF_suffix(pFastHeader),     mv_veh_v2);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::experian_src_index'+SF_suffix(pFastHeader),  '~thor_data400::key::header::'+filedate+'::Experian_src'+SF_suffix(pFastHeader),   mv_Experian);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::TN_src_index'+SF_suffix(pFastHeader),        '~thor_data400::key::header::'+filedate+'::TN_src'+SF_suffix(pFastHeader),         mv_TransunionCred);


airc_index        := header.Key_Src_Airc;
airm_index        := header.Key_Src_Airm;
ak_index          := Header.Key_Src_AK;
atf_index         := Header.Key_Src_ATF;
boat_index        := Header.Key_Src_Boater;
Dea_index         := Header.Key_Src_DEA;
death_index       := Header.Key_Src_Death;
em_index          := Header.Key_Src_EM;
forc_index        := Header.Key_Src_For;
liens_index       := Header.Key_Src_Lien;
LNTU_index        := Header.Key_Src_LNTU;
ms_index          := Header.Key_Src_MS;
Prof_index        := Header.Key_Src_Prof;
state_death_index := Header.Key_Src_Statedeath;
Util_index        := Header.Key_Src_Util;
Veh_index         := Header.Key_Src_Veh;
water_index       := Header.Key_Src_Water;
targus_index      := Header.Key_Src_Targus;
asl_index         := header.key_src_asl;
voters_index      := header.key_src_voters;
certegy_index	    := header.Key_Src_certegy;
nod_index         := Header.key_src_nod;
Exprnph_index     := Header.Key_Src_EL;

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(airc_index,       '~thor_data400::key::airc_src_index',      '~thor_data400::key::header::'+filedate+'::airc_src',       bld_airc);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(airm_index,       '~thor_data400::key::airm_src_index',      '~thor_data400::key::header::'+filedate+'::airm_src',       bld_airm);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(ak_index,         '~thor_data400::key::ak_src_index',        '~thor_data400::key::header::'+filedate+'::ak_src',         bld_ak);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(atf_index,        '~thor_data400::key::atf_src_index',       '~thor_data400::key::header::'+filedate+'::atf_src',        bld_atf);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(boat_index,       '~thor_data400::key::boater_src_index',    '~thor_data400::key::header::'+filedate+'::boater_src',     bld_boat);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(dea_index,        '~thor_data400::key::dea_src_index',       '~thor_data400::key::header::'+filedate+'::dea_src',        bld_dea);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(death_index,      '~thor_data400::key::death_src_index',     '~thor_data400::key::header::'+filedate+'::death_src',      bld_death);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(em_index,         '~thor_data400::key::em_src_index',        '~thor_data400::key::header::'+filedate+'::em_src',         bld_em);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(forc_index,       '~thor_data400::key::for_src_index',       '~thor_data400::key::header::'+filedate+'::for_src',        bld_forc);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(LNTU_index,       '~thor_data400::key::LNTU_src_index',      '~thor_data400::key::header::'+filedate+'::LNTU_src',       bld_LNTU);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(ms_index,         '~thor_data400::key::ms_src_index',        '~thor_data400::key::header::'+filedate+'::ms_src',         bld_ms);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Prof_index,       '~thor_data400::key::Prof_src_index',      '~thor_data400::key::header::'+filedate+'::Prof_src',       bld_Prof);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(state_death_index,'~thor_data400::key::statedeath_src_index','~thor_data400::key::header::'+filedate+'::statedeath_src', bld_state_death);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Util_index,       '~thor_data400::key::Util_src_index',      '~thor_data400::key::header::'+filedate+'::Util_src',       bld_Util);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Veh_index,        '~thor_data400::key::Veh_src_index',       '~thor_data400::key::header::'+filedate+'::Veh_src',        bld_Veh);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(water_index,      '~thor_data400::key::water_src_index',     '~thor_data400::key::header::'+filedate+'::water_src',      bld_water);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(targus_index,     '~thor_data400::key::targ_src_index',      '~thor_data400::key::header::'+filedate+'::targus_src',     bld_targus);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(asl_index,        '~thor_data400::key::asl_src_index',       '~thor_data400::key::header::'+filedate+'::asl_src',        bld_asl);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(voters_index,     '~thor_data400::key::voters_src_index',    '~thor_data400::key::header::'+filedate+'::voters_src',     bld_voters);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(certegy_index,    '~thor_data400::key::certegy_src_index',   '~thor_data400::key::header::'+filedate+'::certegy_src',    bld_certegy);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(nod_index,  		 '~thor_data400::key::nod_src_index',         '~thor_data400::key::header::'+filedate+'::nod_src',        bld_nod);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Exprnph_index,   '~thor_data400::key::Exprnph_src_index',    '~thor_data400::key::header::'+filedate+'::Exprnph_src',    bld_Exprnph);

RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::airc_src_index',      '~thor_data400::key::header::'+filedate+'::airc_src',       mv_airc);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::airm_src_index',      '~thor_data400::key::header::'+filedate+'::airm_src',       mv_airm);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ak_src_index',        '~thor_data400::key::header::'+filedate+'::ak_src',         mv_ak);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf_src_index',       '~thor_data400::key::header::'+filedate+'::atf_src',        mv_atf);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::boater_src_index',    '~thor_data400::key::header::'+filedate+'::boater_src',     mv_boat);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dea_src_index',       '~thor_data400::key::header::'+filedate+'::dea_src',        mv_dea);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::death_src_index',     '~thor_data400::key::header::'+filedate+'::death_src',      mv_death);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::em_src_index',        '~thor_data400::key::header::'+filedate+'::em_src',         mv_em);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::for_src_index',       '~thor_data400::key::header::'+filedate+'::for_src',        mv_forc);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::LNTU_src_index',      '~thor_data400::key::header::'+filedate+'::LNTU_src',       mv_LNTU);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ms_src_index',        '~thor_data400::key::header::'+filedate+'::ms_src',         mv_ms);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Prof_src_index',      '~thor_data400::key::header::'+filedate+'::Prof_src',       mv_Prof);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::statedeath_src_index','~thor_data400::key::header::'+filedate+'::statedeath_src', mv_state_death);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Util_src_index',      '~thor_data400::key::header::'+filedate+'::Util_src',       mv_Util);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Veh_src_index',       '~thor_data400::key::header::'+filedate+'::Veh_src',        mv_Veh);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::water_src_index',     '~thor_data400::key::header::'+filedate+'::water_src',      mv_water);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::targ_src_index',      '~thor_data400::key::header::'+filedate+'::targus_src',     mv_targus);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::asl_src_index',       '~thor_data400::key::header::'+filedate+'::asl_src',        mv_asl);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::voters_src_index',    '~thor_data400::key::header::'+filedate+'::voters_src',     mv_voters);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::certegy_src_index',   '~thor_data400::key::header::'+filedate+'::certegy_src',    mv_certegy);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::nod_src_index',       '~thor_data400::key::header::'+filedate+'::nod_src',        mv_nod);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::exprnph_src_index',   '~thor_data400::key::header::'+filedate+'::Exprnph_src',    mv_Exprnph);


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
									,if(~pFastHeader
												,parallel(
																bld_atf
																,bld_ak
																,bld_ms
																,bld_death
																,bld_state_death
																,bld_prof
																,bld_util
																,bld_airc
																,bld_airm
																,bld_forc
																,bld_dea
																,bld_water
																,bld_boat
																,bld_targus
																,bld_asl
																,bld_voters
																,bld_certegy
																,bld_nod
																,bld_Exprnph
																,bld_em
																)
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
									,if(~pFastHeader
												,parallel(
																mv_atf
																,mv_ak
																,mv_em
																,mv_ms
																,mv_death
																,mv_state_death
																,mv_prof
																,mv_util
																,mv_airc
																,mv_airm
																,mv_forc
																,mv_dea
																,mv_water
																,mv_boat
																,mv_targus
																,mv_asl
																,mv_voters
																,mv_certegy
																,mv_nod
																,mv_Exprnph
																)
                     )
							    );

end;