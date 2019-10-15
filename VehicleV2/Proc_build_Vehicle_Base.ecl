import _control, MDR, vehicleV2, PromoteSupers, Std;
															
//build vehicle main & party base file

//prep main file	
concatMain 		:= VehicleV2.Map_Experian_Main			          +	
								 VehicleV2.mapping_NC_main				          +
								 VehicleV2.Mapping_Vehicle_Main	         		+
								 VehicleV2.irs_dummy_recs_main		          +
								 VehicleV2.mapping_OH_main                 	+
								 VehicleV2.mapping_Infutor_Motorcycle_main 	+
								 VehicleV2.mapping_Infutor_Vin_main;
									
addGlobalSID 	:= MDR.macGetGlobalSid(concatMain, 'VehicleV2', 'source_code', 'global_sid'); //DF-26080: Populate Global_SID Field

//build main file
PromoteSupers.MAC_SF_BuildProcess(	addGlobalSID,
																		'~thor_data400::base::VehicleV2::Main',
																		bld_vehicleV2_main,
																		2,,true
																	);
		
//prep party file
concatParty		:= VehicleV2.VehicleV2_DID	+	VehicleV2.irs_dummy_recs_party;
addGlobalSID2 := MDR.macGetGlobalSid(concatParty, 'VehicleV2', 'source_code', 'global_sid'); //DF-26080: Populate Global_SID Field

//build party file		
PromoteSupers.MAC_SF_BuildProcess(	addGlobalSID2,
																		'~thor_data400::base::VehicleV2::party',
																		bld_vehicleV2_party,
																		2,,true
																	);

export	Proc_build_Vehicle_Base	:=	sequential(bld_vehicleV2_main,bld_vehicleV2_party);