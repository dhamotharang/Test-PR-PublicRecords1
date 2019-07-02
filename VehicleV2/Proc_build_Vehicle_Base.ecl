import	vehicleV2,PromoteSupers;
															
//build vehicle main & party base file

PromoteSupers.MAC_SF_BuildProcess(	VehicleV2.Map_Experian_Main			+	
																		VehicleV2.mapping_NC_main				+
																		VehicleV2.Mapping_Vehicle_Main	+
																		VehicleV2.irs_dummy_recs_main		+
																		VehicleV2.mapping_OH_main +
																		VehicleV2.mapping_Infutor_Motorcycle_main +
																		VehicleV2.mapping_Infutor_Vin_main,
																		'~thor_data400::base::VehicleV2::Main',
																		bld_vehicleV2_main,
																		2,,true
																	);
				   
PromoteSupers.MAC_SF_BuildProcess(	VehicleV2.VehicleV2_DID	+	VehicleV2.irs_dummy_recs_party,
																		'~thor_data400::base::VehicleV2::party',
																		bld_vehicleV2_party,
																		2,,true
																	);


export	Proc_build_Vehicle_Base	:=	sequential(project(bld_vehicleV2_main,transform(VehicleV2.Layout_Base_Main,
                                                                                     self.global_sid := 0;             //Added for CCPA-103
																																										 self.record_sid := 0;             //Added for CCPA-103
																																										 self            := left
                                                                                    )
																												),
                                                project(bld_vehicleV2_party,trnasform(VehicleV2.Layout_Base.Party_CCPA, //Added for CCPA-103
																								                                      self.global_sid := 0;             //Added for CCPA-103
																																											self.record_sid := 0;             //Added for CCPA-103
																																											self            := left
																																										 )
																											 )
																						   );