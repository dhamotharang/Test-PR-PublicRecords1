import	vehicleV2,ut;

//build vehicle main & party base file

ut.MAC_SF_BuildProcess(	VehicleV2.Map_Experian_Main			+	
												VehicleV2.mapping_NC_main				+
												VehicleV2.Mapping_Vehicle_Main	+
												VehicleV2.irs_dummy_recs_main		+
												VehicleV2.mapping_OH_main,
												'~thor_data400::base::VehicleV2::Main',
												bld_vehicleV2_main,
												2,,true
											);
				   
ut.MAC_SF_BuildProcess(	VehicleV2.VehicleV2_DID	+	VehicleV2.irs_dummy_recs_party,
												'~thor_data400::base::VehicleV2::party',
												bld_vehicleV2_party,
												2,,true
											);


export	Proc_build_Vehicle_Base	:=	sequential(bld_vehicleV2_main,bld_vehicleV2_party);