EXPORT new_records_sample_Infutor := function
	dVehicleMainVin					:= distribute(vehiclev2.files.base.main(source_code = '1V'),hash(vehicle_key));
	dVehicleMainVin_father	:= distribute(dataset('~thor_data400::base::VehicleV2::Main_father', VehicleV2.Layout_Base.Main, flat)(source_code = '1V'),hash(vehicle_key));

	dSampleVin 							:= join(dVehicleMainVin,
																	dVehicleMainVin_father,
																	left.vehicle_key = right.vehicle_key,
																	transform(recordof(dVehicleMainVin),self := left),
																	left only,
																	local
																	);
										
	zVehicleSamplesVin 			:= choosen(dSampleVin(state_origin = 'AK'),20) + 
														 choosen(dSampleVin(state_origin = 'AL'),20) +
														 choosen(dSampleVin(state_origin = 'AR'),20) +
														 choosen(dSampleVin(state_origin = 'AZ'),20) +
														 choosen(dSampleVin(state_origin = 'CA'),20) +
														 choosen(dSampleVin(state_origin = 'CO'),20) +
														 choosen(dSampleVin(state_origin = 'CT'),20) +
														 choosen(dSampleVin(state_origin = 'DC'),20) +
														 choosen(dSampleVin(state_origin = 'DE'),20) +
														 choosen(dSampleVin(state_origin = 'FL'),20) +
														 choosen(dSampleVin(state_origin = 'GA'),20) +
														 choosen(dSampleVin(state_origin = 'HI'),20) +
														 choosen(dSampleVin(state_origin = 'IA'),20) +
														 choosen(dSampleVin(state_origin = 'ID'),20) +
														 choosen(dSampleVin(state_origin = 'IL'),20) +
														 choosen(dSampleVin(state_origin = 'IN'),20) +
														 choosen(dSampleVin(state_origin = 'KS'),20) +
														 choosen(dSampleVin(state_origin = 'KY'),20) +
														 choosen(dSampleVin(state_origin = 'LA'),20) +
														 choosen(dSampleVin(state_origin = 'MA'),20) +
														 choosen(dSampleVin(state_origin = 'MD'),20) +
														 choosen(dSampleVin(state_origin = 'ME'),20) +
														 choosen(dSampleVin(state_origin = 'MI'),20) +
														 choosen(dSampleVin(state_origin = 'MN'),20) +
														 choosen(dSampleVin(state_origin = 'MO'),20) +
														 choosen(dSampleVin(state_origin = 'MS'),20) +
														 choosen(dSampleVin(state_origin = 'MT'),20) +
														 choosen(dSampleVin(state_origin = 'NC'),20) +
														 choosen(dSampleVin(state_origin = 'ND'),20) +
														 choosen(dSampleVin(state_origin = 'NE'),20) +
														 choosen(dSampleVin(state_origin = 'NH'),20) +
														 choosen(dSampleVin(state_origin = 'NJ'),20) +
														 choosen(dSampleVin(state_origin = 'NM'),20) +
														 choosen(dSampleVin(state_origin = 'NV'),20) +
														 choosen(dSampleVin(state_origin = 'NY'),20) +
														 choosen(dSampleVin(state_origin = 'OH'),20) +
														 choosen(dSampleVin(state_origin = 'OK'),20) +
														 choosen(dSampleVin(state_origin = 'OR'),20) +
														 choosen(dSampleVin(state_origin = 'PA'),20) +
														 choosen(dSampleVin(state_origin = 'PR'),20) +
														 choosen(dSampleVin(state_origin = 'RI'),20) +
														 choosen(dSampleVin(state_origin = 'SC'),20) +
														 choosen(dSampleVin(state_origin = 'SD'),20) +
														 choosen(dSampleVin(state_origin = 'TN'),20) +
														 choosen(dSampleVin(state_origin = 'TX'),20) +
														 choosen(dSampleVin(state_origin = 'UT'),20) +
														 choosen(dSampleVin(state_origin = 'VA'),20) +
														 choosen(dSampleVin(state_origin = 'VT'),20) +
														 choosen(dSampleVin(state_origin = 'WA'),20) +
														 choosen(dSampleVin(state_origin = 'WI'),20) +
														 choosen(dSampleVin(state_origin = 'WV'),20) +
														 choosen(dSampleVin(state_origin = 'WY'),20);

	oSampleVinMain					:= output(zVehicleSamplesVin, all, named('sample_vehicle_records_infutor_mvr_main'));		
	
	dVehicleMainMC					:= distribute(vehiclev2.files.base.main(source_code = '2V'),hash(vehicle_key));
	dVehicleMainMC_father		:= distribute(dataset('~thor_data400::base::VehicleV2::Main_father', VehicleV2.Layout_Base.Main, flat)(source_code = '2V'),hash(vehicle_key));

	dSampleMC 							:= join(dVehicleMainMC,
																	dVehicleMainMC_father,
																	left.vehicle_key = right.vehicle_key,
																	transform(recordof(dVehicleMainMC),self := left),
																	left only,
																	local
																	);
										
	zVehicleSamplesMC 			:= choosen(dSampleMC(state_origin = 'AK'),20) + 
														 choosen(dSampleMC(state_origin = 'AL'),20) +
														 choosen(dSampleMC(state_origin = 'AR'),20) +
														 choosen(dSampleMC(state_origin = 'AZ'),20) +
														 choosen(dSampleMC(state_origin = 'CA'),20) +
														 choosen(dSampleMC(state_origin = 'CO'),20) +
														 choosen(dSampleMC(state_origin = 'CT'),20) +
														 choosen(dSampleMC(state_origin = 'DC'),20) +
														 choosen(dSampleMC(state_origin = 'DE'),20) +
														 choosen(dSampleMC(state_origin = 'FL'),20) +
														 choosen(dSampleMC(state_origin = 'GA'),20) +
														 choosen(dSampleMC(state_origin = 'HI'),20) +
														 choosen(dSampleMC(state_origin = 'IA'),20) +
														 choosen(dSampleMC(state_origin = 'ID'),20) +
														 choosen(dSampleMC(state_origin = 'IL'),20) +
														 choosen(dSampleMC(state_origin = 'IN'),20) +
														 choosen(dSampleMC(state_origin = 'KS'),20) +
														 choosen(dSampleMC(state_origin = 'KY'),20) +
														 choosen(dSampleMC(state_origin = 'LA'),20) +
														 choosen(dSampleMC(state_origin = 'MA'),20) +
														 choosen(dSampleMC(state_origin = 'MD'),20) +
														 choosen(dSampleMC(state_origin = 'ME'),20) +
														 choosen(dSampleMC(state_origin = 'MI'),20) +
														 choosen(dSampleMC(state_origin = 'MN'),20) +
														 choosen(dSampleMC(state_origin = 'MO'),20) +
														 choosen(dSampleMC(state_origin = 'MS'),20) +
														 choosen(dSampleMC(state_origin = 'MT'),20) +
														 choosen(dSampleMC(state_origin = 'NC'),20) +
														 choosen(dSampleMC(state_origin = 'ND'),20) +
														 choosen(dSampleMC(state_origin = 'NE'),20) +
														 choosen(dSampleMC(state_origin = 'NH'),20) +
														 choosen(dSampleMC(state_origin = 'NJ'),20) +
														 choosen(dSampleMC(state_origin = 'NM'),20) +
														 choosen(dSampleMC(state_origin = 'NV'),20) +
														 choosen(dSampleMC(state_origin = 'NY'),20) +
														 choosen(dSampleMC(state_origin = 'OH'),20) +
														 choosen(dSampleMC(state_origin = 'OK'),20) +
														 choosen(dSampleMC(state_origin = 'OR'),20) +
														 choosen(dSampleMC(state_origin = 'PA'),20) +
														 choosen(dSampleMC(state_origin = 'PR'),20) +
														 choosen(dSampleMC(state_origin = 'RI'),20) +
														 choosen(dSampleMC(state_origin = 'SC'),20) +
														 choosen(dSampleMC(state_origin = 'SD'),20) +
														 choosen(dSampleMC(state_origin = 'TN'),20) +
														 choosen(dSampleMC(state_origin = 'TX'),20) +
														 choosen(dSampleMC(state_origin = 'UT'),20) +
														 choosen(dSampleMC(state_origin = 'VA'),20) +
														 choosen(dSampleMC(state_origin = 'VT'),20) +
														 choosen(dSampleMC(state_origin = 'WA'),20) +
														 choosen(dSampleMC(state_origin = 'WI'),20) +
														 choosen(dSampleMC(state_origin = 'WV'),20) +
														 choosen(dSampleMC(state_origin = 'WY'),20);

	oSampleMCMain					:= output(zVehicleSamplesMC, all, named('sample_vehicle_records_infutor_mc_main'));		

	dVehiclePartyVin			:= distribute(vehiclev2.files.base.party(source_code = '1V'),hash(vehicle_key));
	dVehiclePartyVin_father:= distribute(dataset('~thor_data400::base::VehicleV2::Party_father', VehicleV2.Layout_Base.Party_bip, flat)(source_code = '1V'),hash(vehicle_key));

	dSampleVinParty				:= join(dVehiclePartyVin,
																dVehiclePartyVin_father,
																left.vehicle_key = right.vehicle_key,
																transform(recordof(dVehiclePartyVin),self := left),
																left only,
																local
																);
										
	zVehicleSamplesVinParty := choosen(dSampleVinParty(state_origin = 'AK'),20) + 
														 choosen(dSampleVinParty(state_origin = 'AL'),20) +
														 choosen(dSampleVinParty(state_origin = 'AR'),20) +
														 choosen(dSampleVinParty(state_origin = 'AZ'),20) +
														 choosen(dSampleVinParty(state_origin = 'CA'),20) +
														 choosen(dSampleVinParty(state_origin = 'CO'),20) +
														 choosen(dSampleVinParty(state_origin = 'CT'),20) +
														 choosen(dSampleVinParty(state_origin = 'DC'),20) +
														 choosen(dSampleVinParty(state_origin = 'DE'),20) +
														 choosen(dSampleVinParty(state_origin = 'FL'),20) +
														 choosen(dSampleVinParty(state_origin = 'GA'),20) +
														 choosen(dSampleVinParty(state_origin = 'HI'),20) +
														 choosen(dSampleVinParty(state_origin = 'IA'),20) +
														 choosen(dSampleVinParty(state_origin = 'ID'),20) +
														 choosen(dSampleVinParty(state_origin = 'IL'),20) +
														 choosen(dSampleVinParty(state_origin = 'IN'),20) +
														 choosen(dSampleVinParty(state_origin = 'KS'),20) +
														 choosen(dSampleVinParty(state_origin = 'KY'),20) +
														 choosen(dSampleVinParty(state_origin = 'LA'),20) +
														 choosen(dSampleVinParty(state_origin = 'MA'),20) +
														 choosen(dSampleVinParty(state_origin = 'MD'),20) +
														 choosen(dSampleVinParty(state_origin = 'ME'),20) +
														 choosen(dSampleVinParty(state_origin = 'MI'),20) +
														 choosen(dSampleVinParty(state_origin = 'MN'),20) +
														 choosen(dSampleVinParty(state_origin = 'MO'),20) +
														 choosen(dSampleVinParty(state_origin = 'MS'),20) +
														 choosen(dSampleVinParty(state_origin = 'MT'),20) +
														 choosen(dSampleVinParty(state_origin = 'NC'),20) +
														 choosen(dSampleVinParty(state_origin = 'ND'),20) +
														 choosen(dSampleVinParty(state_origin = 'NE'),20) +
														 choosen(dSampleVinParty(state_origin = 'NH'),20) +
														 choosen(dSampleVinParty(state_origin = 'NJ'),20) +
														 choosen(dSampleVinParty(state_origin = 'NM'),20) +
														 choosen(dSampleVinParty(state_origin = 'NV'),20) +
														 choosen(dSampleVinParty(state_origin = 'NY'),20) +
														 choosen(dSampleVinParty(state_origin = 'OH'),20) +
														 choosen(dSampleVinParty(state_origin = 'OK'),20) +
														 choosen(dSampleVinParty(state_origin = 'OR'),20) +
														 choosen(dSampleVinParty(state_origin = 'PA'),20) +
														 choosen(dSampleVinParty(state_origin = 'PR'),20) +
														 choosen(dSampleVinParty(state_origin = 'RI'),20) +
														 choosen(dSampleVinParty(state_origin = 'SC'),20) +
														 choosen(dSampleVinParty(state_origin = 'SD'),20) +
														 choosen(dSampleVinParty(state_origin = 'TN'),20) +
														 choosen(dSampleVinParty(state_origin = 'TX'),20) +
														 choosen(dSampleVinParty(state_origin = 'UT'),20) +
														 choosen(dSampleVinParty(state_origin = 'VA'),20) +
														 choosen(dSampleVinParty(state_origin = 'VT'),20) +
														 choosen(dSampleVinParty(state_origin = 'WA'),20) +
														 choosen(dSampleVinParty(state_origin = 'WI'),20) +
														 choosen(dSampleVinParty(state_origin = 'WV'),20) +
														 choosen(dSampleVinParty(state_origin = 'WY'),20);

	oSampleVinParty					:= output(zVehicleSamplesVinParty, all, named('sample_vehicle_records_infutor_mvr_party'));		
	
	dVehiclePartyMC				:= distribute(vehiclev2.files.base.party(source_code = '2V'),hash(vehicle_key));
	dVehiclePartyMC_father:= distribute(dataset('~thor_data400::base::VehicleV2::Party_father', VehicleV2.Layout_Base.Party_bip, flat)(source_code = '2V'),hash(vehicle_key));


	dSampleMCParty				:= join(dVehiclePartyMC,
																dVehiclePartyMC_father,
																left.vehicle_key = right.vehicle_key,
																transform(recordof(dVehiclePartyMC),self := left),
																left only,
																local
																);
										
	zVehicleSamplesMCParty  := choosen(dSampleMCParty(state_origin = 'AK'),20) + 
														 choosen(dSampleMCParty(state_origin = 'AL'),20) +
														 choosen(dSampleMCParty(state_origin = 'AR'),20) +
														 choosen(dSampleMCParty(state_origin = 'AZ'),20) +
														 choosen(dSampleMCParty(state_origin = 'CA'),20) +
														 choosen(dSampleMCParty(state_origin = 'CO'),20) +
														 choosen(dSampleMCParty(state_origin = 'CT'),20) +
														 choosen(dSampleMCParty(state_origin = 'DC'),20) +
														 choosen(dSampleMCParty(state_origin = 'DE'),20) +
														 choosen(dSampleMCParty(state_origin = 'FL'),20) +
														 choosen(dSampleMCParty(state_origin = 'GA'),20) +
														 choosen(dSampleMCParty(state_origin = 'HI'),20) +
														 choosen(dSampleMCParty(state_origin = 'IA'),20) +
														 choosen(dSampleMCParty(state_origin = 'ID'),20) +
														 choosen(dSampleMCParty(state_origin = 'IL'),20) +
														 choosen(dSampleMCParty(state_origin = 'IN'),20) +
														 choosen(dSampleMCParty(state_origin = 'KS'),20) +
														 choosen(dSampleMCParty(state_origin = 'KY'),20) +
														 choosen(dSampleMCParty(state_origin = 'LA'),20) +
														 choosen(dSampleMCParty(state_origin = 'MA'),20) +
														 choosen(dSampleMCParty(state_origin = 'MD'),20) +
														 choosen(dSampleMCParty(state_origin = 'ME'),20) +
														 choosen(dSampleMCParty(state_origin = 'MI'),20) +
														 choosen(dSampleMCParty(state_origin = 'MN'),20) +
														 choosen(dSampleMCParty(state_origin = 'MO'),20) +
														 choosen(dSampleMCParty(state_origin = 'MS'),20) +
														 choosen(dSampleMCParty(state_origin = 'MT'),20) +
														 choosen(dSampleMCParty(state_origin = 'NC'),20) +
														 choosen(dSampleMCParty(state_origin = 'ND'),20) +
														 choosen(dSampleMCParty(state_origin = 'NE'),20) +
														 choosen(dSampleMCParty(state_origin = 'NH'),20) +
														 choosen(dSampleMCParty(state_origin = 'NJ'),20) +
														 choosen(dSampleMCParty(state_origin = 'NM'),20) +
														 choosen(dSampleMCParty(state_origin = 'NV'),20) +
														 choosen(dSampleMCParty(state_origin = 'NY'),20) +
														 choosen(dSampleMCParty(state_origin = 'OH'),20) +
														 choosen(dSampleMCParty(state_origin = 'OK'),20) +
														 choosen(dSampleMCParty(state_origin = 'OR'),20) +
														 choosen(dSampleMCParty(state_origin = 'PA'),20) +
														 choosen(dSampleMCParty(state_origin = 'PR'),20) +
														 choosen(dSampleMCParty(state_origin = 'RI'),20) +
														 choosen(dSampleMCParty(state_origin = 'SC'),20) +
														 choosen(dSampleMCParty(state_origin = 'SD'),20) +
														 choosen(dSampleMCParty(state_origin = 'TN'),20) +
														 choosen(dSampleMCParty(state_origin = 'TX'),20) +
														 choosen(dSampleMCParty(state_origin = 'UT'),20) +
														 choosen(dSampleMCParty(state_origin = 'VA'),20) +
														 choosen(dSampleMCParty(state_origin = 'VT'),20) +
														 choosen(dSampleMCParty(state_origin = 'WA'),20) +
														 choosen(dSampleMCParty(state_origin = 'WI'),20) +
														 choosen(dSampleMCParty(state_origin = 'WV'),20) +
														 choosen(dSampleMCParty(state_origin = 'WY'),20);

	oSampleMCParty					:= output(zVehicleSamplesMCParty, all, named('sample_vehicle_records_infutor_mc_party'));		
	
	return parallel(oSampleVinMain,
									oSampleMCMain,
									oSampleVinParty,
									oSampleMCParty
								 );
end;