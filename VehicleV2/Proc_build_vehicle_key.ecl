import Address_Attributes,roxiekeybuild,vehiclev2,Vehicle_Wildcard,VersionControl;
 
export Proc_build_vehicle_key(string filedate) := function

// Build LinkIDS
VersionControl.MacBuildNewLogicalKeyWithName(vehiclev2.Key_Vehicle_linkids.Key,	'~thor_data400::key::vehiclev2::'+filedate+'::linkids', linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::linkids', '~thor_data400::key::vehiclev2::'+filedate+'::linkids', mv_linkids_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_DID,'~thor_data400::key::vehiclev2::did','~thor_data400::key::vehiclev2::'+filedate+'::DID',vehicle_DID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::DID', '~thor_data400::key::vehiclev2::'+filedate+'::DID', mv_DID_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_BDID,'~thor_data400::key::vehiclev2::bdid','~thor_data400::key::vehiclev2::'+filedate+'::BDID',vehicle_BDID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::BDID', '~thor_data400::key::vehiclev2::'+filedate+'::BDID', mv_BDID_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_DL_Number,'~thor_data400::key::vehiclev2::dl_number','~thor_data400::key::vehiclev2::'+filedate+'::DL_Number',vehicle_DL_Number_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::DL_Number', '~thor_data400::key::vehiclev2::'+filedate+'::DL_Number', mv_DL_Number_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_Lic_Plate,'~thor_data400::key::vehiclev2::Lic_Plate','~thor_data400::key::vehiclev2::'+filedate+'::Lic_Plate',vehicle_Lic_Plate_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::Lic_Plate', '~thor_data400::key::vehiclev2::'+filedate+'::Lic_Plate', mv_Lic_Plate_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_reverse_Lic_Plate,'~thor_data400::key::vehiclev2::reverse_Lic_Plate','~thor_data400::key::vehiclev2::'+filedate+'::reverse_Lic_Plate',vehicle_reverse_Lic_Plate_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::reverse_Lic_Plate', '~thor_data400::key::vehiclev2::'+filedate+'::reverse_Lic_Plate', mv_reverse_Lic_Plate_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_MAIN_Key,'~thor_data400::key::vehiclev2::MAIN_Key','~thor_data400::key::vehiclev2::'+filedate+'::MAIN_Key',vehicle_MAIN_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::MAIN_Key', '~thor_data400::key::vehiclev2::'+filedate+'::MAIN_Key', mv_MAIN_Key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_VIN,'~thor_data400::key::vehiclev2::VIN','~thor_data400::key::vehiclev2::'+filedate+'::VIN',vehicle_VIN_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::VIN', '~thor_data400::key::vehiclev2::'+filedate+'::VIN', mv_VIN_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_Party_Key,'~thor_data400::key::vehiclev2::Party_Key','~thor_data400::key::vehiclev2::'+filedate+'::Party_Key',vehicle_Party_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::Party_Key', '~thor_data400::key::vehiclev2::'+filedate+'::Party_Key', mv_Party_Key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_Title_Number,'~thor_data400::key::vehiclev2::Title_Number','~thor_data400::key::vehiclev2::'+filedate+'::Title_Number',vehicle_Title_Number_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::Title_Number', '~thor_data400::key::vehiclev2::'+filedate+'::Title_Number', mv_Title_Number_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(VehicleV2.Key_Vehicle_Lic_Plate_Blur,'~thor_data400::key::VehicleV2::lic_plate_blur','~thor_data400::key::vehiclev2::'+filedate+'::lic_plate_blur',vehicle_lic_plate_blur_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::lic_plate_blur', '~thor_data400::key::vehiclev2::'+filedate+'::lic_plate_blur', mv_lic_plate_blur_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.Key_BocaShell_Vehicles,'~thor_data400::key::vehicleV2::bocashell_did','~thor_data400::key::vehiclev2::'+filedate+'::bocashell_did',bocashell_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::bocashell_did', '~thor_data400::key::vehiclev2::'+filedate+'::bocashell_did', mv_bocashell_did_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Address_Attributes.key_vehicles_addr,'~thor_data400::key::vehiclev2::vehicles_address','~thor_data400::key::vehiclev2::'+filedate+'::vehicles_address',vehicle_addr_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::vehicles_address', '~thor_data400::key::vehiclev2::'+filedate+'::vehicles_address', mv_vehicle_addr_key);

//Bug 123614
//Deprecated key - Jira DF-26974
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(vehiclev2.key_vehicle_Party_Key_Linkids,'~thor_data400::key::vehiclev2::Party_Key::Linkids','~thor_data400::key::vehiclev2::'+filedate+'::Party_Key::Linkids',vehicle_Party_Key_Linkids);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::Party_Key::Linkids', '~thor_data400::key::vehiclev2::'+filedate+'::Party_Key::Linkids', mv_Party_Key_linkids);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(VehicleV2.Key_Vehicle_Source_Rec_ID,'~thor_data400::key::vehiclev2::source_rec_id','~thor_data400::key::vehiclev2::'+filedate+'::source_rec_id',vehicle_SourceRecID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::source_rec_id', '~thor_data400::key::vehiclev2::'+filedate+'::source_rec_id', mv_SourceRecID_Key);

//DF-17145, MFD search key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(VehicleV2.Key_Vehicle_MFD_Srch,'~thor_data400::key::vehiclev2::mfd_srch','~thor_data400::key::vehiclev2::'+filedate+'::mfd_srch',vehicle_MFDSrch_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::vehiclev2::mfd_srch', '~thor_data400::key::vehiclev2::'+filedate+'::mfd_srch', mv_MFDSrch_Key);

build_keys	:=	sequential(	parallel(	linkids_key,vehicle_DID_key,vehicle_BDID_key,vehicle_DL_Number_key,
																			vehicle_Lic_Plate_key,vehicle_reverse_lic_plate_key,
																			vehicle_MAIN_Key,vehicle_VIN_Key,vehicle_Party_Key,
																			vehicle_Title_Number_Key,vehicle_lic_plate_blur_key,
																			bocashell_did_key,vehicle_addr_key, /*vehicle_Party_Key_Linkids,*/
																			vehicle_SourceRecID_key,vehicle_MFDSrch_key
																				),
															parallel(	mv_linkids_key,mv_DID_key,mv_BDID_key,mv_DL_Number_key,mv_Lic_Plate_key,mv_reverse_lic_plate_key,
																				mv_MAIN_Key,mv_VIN_Key,mv_Party_Key,mv_Title_Number_Key,
																				mv_lic_plate_blur_key,mv_bocashell_did_key,mv_vehicle_addr_key,/*mv_Party_Key_linkids,*/
																				mv_SourceRecID_Key,mv_MFDSrch_Key
																				),
															Vehiclev2.Proc_AutokeyBuild(filedate),
															Vehicle_Wildcard.proc_build_wildcard_search(filedate),
															VehicleV2.Proc_AcceptSK_ToQA
														);
		
return build_keys;

end;