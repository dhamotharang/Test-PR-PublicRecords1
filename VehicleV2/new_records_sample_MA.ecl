EXPORT new_records_sample_MA := function

	dVehicleMain						:= distribute(vehiclev2.files.base.main(source_code = '3V'),hash(vehicle_key));
	dVehicleMain_father			:= distribute(dataset('~thor_data400::base::VehicleV2::Main_father', VehicleV2.Layout_Base.Main, flat)(source_code = '3V'),hash(vehicle_key));

	dSampleMain							:= join(dVehicleMain,
																	dVehicleMain_father,
																	left.vehicle_key = right.vehicle_key,
																	transform(recordof(dVehicleMain),self := left),
																	left only,
																	local
																	);
										
	oSampleMain							:= output(choosen(dSampleMain,1000), all, named('sample_vehicle_records_ma_main'));		
	
	dVehicleParty						:= distribute(vehiclev2.files.base.party(source_code = '3V'),hash(vehicle_key));
	dVehicleParty_father		:= distribute(dataset('~thor_data400::base::VehicleV2::Party_father', VehicleV2.Layout_Base.Party_bip, flat)(source_code = '3V'),hash(vehicle_key));

	dSampleParty						:= join(dVehicleParty,
																dVehicleParty_father,
																left.vehicle_key = right.vehicle_key,
																transform(recordof(dVehicleParty),self := left),
																left only,
																local
																);

	oSampleParty						:= output(choosen(dSampleParty,1000), all, named('sample_vehicle_records_ma_party'));		
										
	return parallel(oSampleMain, oSampleParty);

end;	