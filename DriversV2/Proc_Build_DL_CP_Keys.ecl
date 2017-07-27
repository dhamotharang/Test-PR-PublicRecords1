import Doxie_Files, ut, doxie, autokey, autokeyB2, RoxieKeyBuild;

export Proc_Build_DL_CP_Keys(string filedate) := function

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(DriversV2.Key_DL_Conviction_DLCPKey,
                                           '~thor_data400::key::dl2::@version@::Conviction_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::Conviction_DLCP_Key',
                                           bld_Conv_DLCPkey);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(DriversV2.Key_DL_Suspension_DLCPKey,
										   '~thor_data400::key::dl2::@version@::Suspension_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::Suspension_DLCP_Key',
										   bld_Susp_DLCPkey);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(DriversV2.Key_DL_DR_Info_DLCPKey,
										   '~thor_data400::key::dl2::@version@::DR_Info_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::DR_Info_DLCP_Key',
										   bld_DRInfo_DLCPkey);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(DriversV2.Key_DL_Accident_DLCPKey,
										   '~thor_data400::key::dl2::@version@::Accident_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::Accident_DLCP_Key',
										   bld_Accid_DLCPkey);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(DriversV2.Key_DL_FRA_Insurance_DLCPKey,
										   '~thor_data400::key::dl2::@version@::FRA_Insur_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::FRA_Insur_DLCP_Key',
										   bld_FRAIns_DLCPkey);

// Move DID, dl_number & seq keys to built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::Conviction_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::Conviction_DLCP_Key',mv_Conv);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::Suspension_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::Suspension_DLCP_Key',mv_Susp);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::DR_Info_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::DR_Info_DLCP_Key',mv_DRInfo);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::Accident_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::Accident_DLCP_Key',mv_Accid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::FRA_Insur_DLCP_Key','~thor_data400::key::dl2::'+filedate+'::FRA_Insur_DLCP_Key',mv_FRAIns);

// Move DID, dl_number & seq to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::Conviction_DLCP_Key', 'Q', mv_Conv_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::Suspension_DLCP_Key', 'Q', mv_Susp_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::DR_Info_DLCP_Key', 'Q', mv_DRInfo_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::Accident_DLCP_Key', 'Q', mv_Accid_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::FRA_Insur_DLCP_Key', 'Q', mv_FRAInfo_key);


Build_DL_CP_Keys := sequential(parallel(bld_Conv_DLCPkey, bld_Susp_DLCPkey, bld_DRInfo_DLCPkey,
							 			   bld_Accid_DLCPkey, bld_FRAIns_DLCPkey),
								parallel(mv_Conv, mv_Susp, mv_DRInfo, mv_Accid, mv_FRAIns),
								parallel(mv_Conv_key, mv_Susp_key, mv_DRInfo_key, 
								          mv_Accid_key, mv_FRAInfo_key));

return Build_DL_CP_Keys;

end;