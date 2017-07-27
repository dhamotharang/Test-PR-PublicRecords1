import RoxieKeybuild,DriversV2,vehicleV2,LN_Property,ln_mortgage,liensv2,ExperianCred,TransunionCred;

export build_source_key_prep(string filedate=version_build,boolean pFastHeader = false) := function

Mac_key_src_read(Key_Src_DLv2(pFastHeader,false),       DriversV2.Layout_DL,                                dl_child,       'dl_src_building', '~thor_data400::key::header::'+filedate+'::dlv2_src'+SF_suffix(pFastHeader),      DLsrcbuilding);
Mac_key_src_read(Key_Src_EQ(pFastHeader,false),         layout_eq_src,                                      eq_child,       'eq_src_building', '~thor_data400::key::header::'+filedate+'::eq_src'+SF_suffix(pFastHeader),        EQsrcbuilding);
Mac_key_src_read(Key_Src_VehV2(pFastHeader,false),      vehicleV2.layout_vehicle_source,                    veh_child,      'vh_src_building', '~thor_data400::key::header::'+filedate+'::veh_v2_src'+SF_suffix(pFastHeader),    VHsrcbuilding);
Mac_key_src_read(Key_Src_bkv2(pFastHeader,false),       {string50 tmsid},                                   bk_child,       'bk_src_building', '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src'+SF_suffix(pFastHeader),      BKsrcbuilding);
Mac_key_src_read(Key_Src_PropAssess(pFastHeader,false), LN_Property.Layout_Property_Common_Model_BASE,      asses_child,    'as_src_building', '~thor_data400::key::header::'+filedate+'::PropAsses_src'+SF_suffix(pFastHeader), ASsrcbuilding);
Mac_key_src_read(Key_Src_Deed(pFastHeader,false),       ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base, deeds_child,    'de_src_building', '~thor_data400::key::header::'+filedate+'::PropDeed_src'+SF_suffix(pFastHeader),  DEsrcbuilding);
Mac_key_src_read(Key_Src_LienV2(pFastHeader,false),     liensv2.Layout_as_source,                           lienv2_child,   'li_src_building', '~thor_data400::key::header::'+filedate+'::lienv2_src'+SF_suffix(pFastHeader),    LIsrcbuilding);
Mac_key_src_read(key_src_experian(pFastHeader,false),   ExperianCred.Layouts.Layout_Out_old,                Experian_child, 'en_src_building', '~thor_data400::key::header::'+filedate+'::Experian_src'+SF_suffix(pFastHeader),  ENsrcbuilding);
Mac_key_src_read(Key_Src_TN(pFastHeader,false),         TransunionCred.Layouts.base,                        tn_child,       'tn_src_building', '~thor_data400::key::header::'+filedate+'::TN_src'+SF_suffix(pFastHeader),        TNsrcbuilding);

Mac_key_src_read(Key_Src_DLv2(~pFastHeader,false),       DriversV2.Layout_DL,                                dl_child,       'dl_src_built', '~thor_data400::key::dlv2_src_index'+SF_suffix(~pFastHeader)+'_QA',      DLsrcbuilt);
Mac_key_src_read(Key_Src_EQ(~pFastHeader,false),         layout_eq_src,                                      eq_child,       'eq_src_built', '~thor_data400::key::eq_src_index'+SF_suffix(~pFastHeader)+'_QA',        EQsrcbuilt);
Mac_key_src_read(Key_Src_VehV2(~pFastHeader,false),      vehicleV2.layout_vehicle_source,                    veh_child,      'vh_src_built', '~thor_data400::key::veh_v2_src_index'+SF_suffix(~pFastHeader)+'_QA',    VHsrcbuilt);
Mac_key_src_read(Key_Src_bkv2(~pFastHeader,false),       {string50 tmsid},                                   bk_child,       'bk_src_built', '~thor_data400::key::bkv2_src_index'+SF_suffix(~pFastHeader)+'_QA',      BKsrcbuilt);
Mac_key_src_read(Key_Src_PropAssess(~pFastHeader,false), LN_Property.Layout_Property_Common_Model_BASE,      asses_child,    'as_src_built', '~thor_data400::key::PropAsses_src_index'+SF_suffix(~pFastHeader)+'_QA', ASsrcbuilt);
Mac_key_src_read(Key_Src_Deed(~pFastHeader,false),       ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base, deeds_child,    'de_src_built', '~thor_data400::key::PropDeed_src_index'+SF_suffix(~pFastHeader)+'_QA',  DEsrcbuilt);
Mac_key_src_read(Key_Src_LienV2(~pFastHeader,false),     liensv2.Layout_as_source,                           lienv2_child,   'li_src_built', '~thor_data400::key::lienv2_src_index'+SF_suffix(~pFastHeader)+'_QA',    LIsrcbuilt);
Mac_key_src_read(key_src_experian(~pFastHeader,false),   ExperianCred.Layouts.Layout_Out_old,                Experian_child, 'en_src_built', '~thor_data400::key::Experian_src_index'+SF_suffix(~pFastHeader)+'_QA',  ENsrcbuilt);
Mac_key_src_read(Key_Src_TN(~pFastHeader,false),         TransunionCred.Layouts.base,                        tn_child,       'tn_src_built', '~thor_data400::key::TN_src_index'+SF_suffix(~pFastHeader)+'_QA',        TNsrcbuilt);

RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Key_Src_DLv2(,true,DLsrcbuilding + DLsrcbuilt),'~thor_data400::key::dlv2_src_index',      '~thor_data400::key::header::'+filedate+'::dlv2_src',       bld_dl);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Key_Src_EQ(,true,EQsrcbuilding + EQsrcbuilt),'~thor_data400::key::eq_src_index',        '~thor_data400::key::header::'+filedate+'::eq_src',         bld_eq);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Key_Src_Vehv2(,true,VHsrcbuilding + VHsrcbuilt),'~thor_data400::key::veh_v2_src_index',    '~thor_data400::key::header::'+filedate+'::veh_v2_src',     bld_veh_v2);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Key_Src_bkv2(,true,BKsrcbuilding + BKsrcbuilt),'~thor_data400::key::bkv2_src_index',      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src',bld_bkv3);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Key_Src_PropAssess(,true,ASsrcbuilding + ASsrcbuilt),'~thor_data400::key::PropAsses_src_index', '~thor_data400::key::header::'+filedate+'::PropAsses_src',  bld_as);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Key_Src_deed(,true,DEsrcbuilding + DEsrcbuilt),'~thor_data400::key::PropDeed_src_index',  '~thor_data400::key::header::'+filedate+'::PropDeed_src',   bld_de);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Key_Src_LienV2(,true,LIsrcbuilding + LIsrcbuilt),'~thor_data400::key::lienv2_src_index',    '~thor_data400::key::header::'+filedate+'::lienv2_src',     bld_li);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(key_src_experian(,true,ENsrcbuilding + ENsrcbuilt),'~thor_data400::key::Experian_src_index',  '~thor_data400::key::header::'+filedate+'::Experian_src',bld_En);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Key_Src_TN(,true,TNsrcbuilding + TNsrcbuilt),'~thor_data400::key::TN_src_index',        '~thor_data400::key::header::'+filedate+'::TN_src',bld_tn);

RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dlv2_src_index',      '~thor_data400::key::header::'+filedate+'::dlv2_src',       mv_dl);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::eq_src_index',        '~thor_data400::key::header::'+filedate+'::eq_src',         mv_eq);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::veh_v2_src_index',    '~thor_data400::key::header::'+filedate+'::veh_v2_src',     mv_veh_v2);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bkv2_src_index',      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src',mv_bkv3);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PropAsses_src_index', '~thor_data400::key::header::'+filedate+'::PropAsses_src',  mv_as);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PropDeed_src_index',  '~thor_data400::key::header::'+filedate+'::PropDeed_src',   mv_de);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::lienv2_src_index',    '~thor_data400::key::header::'+filedate+'::lienv2_src',     mv_li);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::experian_src_index',  '~thor_data400::key::header::'+filedate+'::Experian_src',   mv_en);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::TN_src_index',        '~thor_data400::key::header::'+filedate+'::TN_src',         mv_tn);


return sequential(
									parallel(
													bld_dl
													,bld_eq
													,bld_veh_v2
													,bld_bkv3
													,bld_as
													,bld_de
													,bld_li
													,bld_en
													,bld_tn
													)
									,parallel(
													mv_dl
													,mv_eq
													,mv_veh_v2
													,mv_bkv3
													,mv_as
													,mv_de
													,mv_li
													,mv_en
													,mv_tn
													)
									);

end;