import header,doxie,RoxieKeybuild,DriversV2,vehicleV2,LN_Property,ln_mortgage,liensv2,ExperianCred,TransunionCred,dx_header;

export build_source_key_prep(string filedate='00000000') := function

rid_rec := record
	unsigned6 rid;
	unsigned6 did;
	unsigned6 first_seen;
	unsigned3 dt_nonglb_last_seen;
end;
rid1:=project(index(doxie.key_Header_rid(true,false),'~thor_data400::key::header::'+filedate+'::rid_fheader'),rid_rec);
rid2:=project(index(doxie.key_Header_rid(false,false),'~thor_data400::key::header.rid_header_qa'),rid_rec);

Srid1:=project(index(dx_header.Key_Rid_SrcID(,true,false),'~thor_data400::key::header::'+filedate+'::rid_srid_fheader'),dx_Header.layouts.i_rid_src);
Srid2:=project(index(dx_header.Key_Rid_SrcID(,false,false),'~thor_data400::key::header_rid_srid_header_qa'),dx_Header.layouts.i_rid_src);

Header.Mac_key_src_read(header.Key_Src_DLv2(true,false),       DriversV2.Layout_DL,                                dl_child,       'dl_src_building', '~thor_data400::key::header::'+filedate+'::dlv2_src_fheader',      DLsrcbuilding);
Header.Mac_key_src_read(header.Key_Src_EQ(true,false),         header.layout_eq_src,                               eq_child,       'eq_src_building', '~thor_data400::key::header::'+filedate+'::eq_src_fheader',        EQsrcbuilding);
Header.Mac_key_src_read(header.Key_Src_VehV2(true,false),      vehicleV2.layout_vehicle_source,                    veh_child,      'vh_src_building', '~thor_data400::key::header::'+filedate+'::veh_v2_src_fheader',    VHsrcbuilding);
Header.Mac_key_src_read(header.Key_Src_bkv2(true,false),       {string50 tmsid},                                   bk_child,       'bk_src_building', '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src_fheader',      BKsrcbuilding);
Header.Mac_key_src_read(header.Key_Src_PropAssess(true,false), LN_Property.Layout_Property_Common_Model_BASE,      asses_child,    'as_src_building', '~thor_data400::key::header::'+filedate+'::PropAsses_src_fheader', ASsrcbuilding);
Header.Mac_key_src_read(header.Key_Src_Deed(true,false),       ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base, deeds_child,    'de_src_building', '~thor_data400::key::header::'+filedate+'::PropDeed_src_fheader',  DEsrcbuilding);
Header.Mac_key_src_read(header.Key_Src_LienV2(true,false),     liensv2.Layout_as_source,                           lienv2_child,   'li_src_building', '~thor_data400::key::header::'+filedate+'::lienv2_src_fheader',    LIsrcbuilding);
Header.Mac_key_src_read(header.key_src_experian(true,false),   ExperianCred.Layouts.Layout_Out_old,                Experian_child, 'en_src_building', '~thor_data400::key::header::'+filedate+'::Experian_src_fheader',  ENsrcbuilding);
Header.Mac_key_src_read(header.Key_Src_TN(true,false),         TransunionCred.Layouts.base,                        tn_child,       'tn_src_building', '~thor_data400::key::header::'+filedate+'::TN_src_fheader',        TNsrcbuilding);

Header.Mac_key_src_read(header.Key_Src_DLv2(false,false),       DriversV2.Layout_DL,                                dl_child,       'dl_src_built', '~thor_data400::key::dlv2_src_index_header_QA',      DLsrcbuilt);
Header.Mac_key_src_read(header.Key_Src_EQ(false,false),         header.layout_eq_src,                               eq_child,       'eq_src_built', '~thor_data400::key::eq_src_index_header_QA',        EQsrcbuilt);
Header.Mac_key_src_read(header.Key_Src_VehV2(false,false),      vehicleV2.layout_vehicle_source,                    veh_child,      'vh_src_built', '~thor_data400::key::veh_v2_src_index_header_QA',    VHsrcbuilt);
Header.Mac_key_src_read(header.Key_Src_bkv2(false,false),       {string50 tmsid},                                   bk_child,       'bk_src_built', '~thor_data400::key::bkv2_src_index_header_QA',      BKsrcbuilt);
Header.Mac_key_src_read(header.Key_Src_PropAssess(false,false), LN_Property.Layout_Property_Common_Model_BASE,      asses_child,    'as_src_built', '~thor_data400::key::PropAsses_src_index_header_QA', ASsrcbuilt);
Header.Mac_key_src_read(header.Key_Src_Deed(false,false),       ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base, deeds_child,    'de_src_built', '~thor_data400::key::PropDeed_src_index_header_QA',  DEsrcbuilt);
Header.Mac_key_src_read(header.Key_Src_LienV2(false,false),     liensv2.Layout_as_source,                           lienv2_child,   'li_src_built', '~thor_data400::key::lienv2_src_index_header_QA',    LIsrcbuilt);
Header.Mac_key_src_read(header.key_src_experian(false,false),   ExperianCred.Layouts.Layout_Out_old,                Experian_child, 'en_src_built', '~thor_data400::key::Experian_src_index_header_QA',  ENsrcbuilt);
Header.Mac_key_src_read(header.Key_Src_TN(false,false),         TransunionCred.Layouts.base,                        tn_child,       'tn_src_built', '~thor_data400::key::TN_src_index_header_QA',        TNsrcbuilt);


RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_rid(,true,rid1 + rid2),'~thor_data400::key::header.rid','~thor_data400::key::header::'+filedate+'::rid',rid_only);

RoxieKeybuild.MAC_build_logical (dx_header.Key_Rid_SrcID(,false,false), header.Key_Rid_SrcID_Prep(,true,Srid1 + Srid2),
								'~thor_data400::key::header_rid_srid', '~thor_data400::key::header::'+filedate+'::rid_srid', bld_rid_srid_key);

RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.Key_Src_DLv2(,true,DLsrcbuilding + DLsrcbuilt),'~thor_data400::key::dlv2_src_index',      '~thor_data400::key::header::'+filedate+'::dlv2_src',       bld_dl);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.Key_Src_EQ(,true,EQsrcbuilding + EQsrcbuilt),'~thor_data400::key::eq_src_index',        '~thor_data400::key::header::'+filedate+'::eq_src',         bld_eq);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.Key_Src_Vehv2(,true,VHsrcbuilding + VHsrcbuilt),'~thor_data400::key::veh_v2_src_index',    '~thor_data400::key::header::'+filedate+'::veh_v2_src',     bld_veh_v2);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.Key_Src_bkv2(,true,BKsrcbuilding + BKsrcbuilt),'~thor_data400::key::bkv2_src_index',      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src',bld_bkv3);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.Key_Src_PropAssess(,true,ASsrcbuilding + ASsrcbuilt),'~thor_data400::key::PropAsses_src_index', '~thor_data400::key::header::'+filedate+'::PropAsses_src',  bld_as);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.Key_Src_deed(,true,DEsrcbuilding + DEsrcbuilt),'~thor_data400::key::PropDeed_src_index',  '~thor_data400::key::header::'+filedate+'::PropDeed_src',   bld_de);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.Key_Src_LienV2(,true,LIsrcbuilding + LIsrcbuilt),'~thor_data400::key::lienv2_src_index',    '~thor_data400::key::header::'+filedate+'::lienv2_src',     bld_li);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.key_src_experian(,true,ENsrcbuilding + ENsrcbuilt),'~thor_data400::key::Experian_src_index',  '~thor_data400::key::header::'+filedate+'::Experian_src',bld_En);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(header.Key_Src_TN(,true,TNsrcbuilding + TNsrcbuilt),'~thor_data400::key::TN_src_index',        '~thor_data400::key::header::'+filedate+'::TN_src',bld_tn);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.rid',          '~thor_data400::key::header::'+filedate+'::rid',mv_rid);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_rid_srid',     '~thor_data400::key::header::'+filedate+'::rid_srid',mv_rid_srid_key);
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
													rid_only
													,bld_rid_srid_key
													,bld_dl
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
													mv_rid
													,mv_rid_srid_key
													,mv_dl
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