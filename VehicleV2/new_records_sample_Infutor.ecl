EXPORT new_records_sample_Infutor := FUNCTION
	dVehicleMainVin := DISTRIBUTE(vehiclev2.files.base.main(source_code = '1V'),HASH(vehicle_key));
	dVehicleMainVin_father := DISTRIBUTE(DATASET('~thor_data400::base::VehicleV2::Main_father', VehicleV2.Layout_Base.Main, FLAT)(source_code = '1V'),HASH(vehicle_key));

	dSampleVin := JOIN(
		dVehicleMainVin,
		dVehicleMainVin_father,
		LEFT.vehicle_key = RIGHT.vehicle_key,
		TRANSFORM(RECORDOF(dVehicleMainVin),self := LEFT),
		LEFT only,
		LOCAL
	);

	zVehicleSamplesVin := CHOOSEN(dSampleVin(state_origin = 'AK'),20) +
		CHOOSEN(dSampleVin(state_origin = 'AL'),20) +
		CHOOSEN(dSampleVin(state_origin = 'AR'),20) +
		CHOOSEN(dSampleVin(state_origin = 'AZ'),20) +
		CHOOSEN(dSampleVin(state_origin = 'CA'),20) +
		CHOOSEN(dSampleVin(state_origin = 'CO'),20) +
		CHOOSEN(dSampleVin(state_origin = 'CT'),20) +
		CHOOSEN(dSampleVin(state_origin = 'DC'),20) +
		CHOOSEN(dSampleVin(state_origin = 'DE'),20) +
		CHOOSEN(dSampleVin(state_origin = 'FL'),20) +
		CHOOSEN(dSampleVin(state_origin = 'GA'),20) +
		CHOOSEN(dSampleVin(state_origin = 'HI'),20) +
		CHOOSEN(dSampleVin(state_origin = 'IA'),20) +
		CHOOSEN(dSampleVin(state_origin = 'ID'),20) +
		CHOOSEN(dSampleVin(state_origin = 'IL'),20) +
		CHOOSEN(dSampleVin(state_origin = 'IN'),20) +
		CHOOSEN(dSampleVin(state_origin = 'KS'),20) +
		CHOOSEN(dSampleVin(state_origin = 'KY'),20) +
		CHOOSEN(dSampleVin(state_origin = 'LA'),20) +
		CHOOSEN(dSampleVin(state_origin = 'MA'),20) +
		CHOOSEN(dSampleVin(state_origin = 'MD'),20) +
		CHOOSEN(dSampleVin(state_origin = 'ME'),20) +
		CHOOSEN(dSampleVin(state_origin = 'MI'),20) +
		CHOOSEN(dSampleVin(state_origin = 'MN'),20) +
		CHOOSEN(dSampleVin(state_origin = 'MO'),20) +
		CHOOSEN(dSampleVin(state_origin = 'MS'),20) +
		CHOOSEN(dSampleVin(state_origin = 'MT'),20) +
		CHOOSEN(dSampleVin(state_origin = 'NC'),20) +
		CHOOSEN(dSampleVin(state_origin = 'ND'),20) +
		CHOOSEN(dSampleVin(state_origin = 'NE'),20) +
		CHOOSEN(dSampleVin(state_origin = 'NH'),20) +
		CHOOSEN(dSampleVin(state_origin = 'NJ'),20) +
		CHOOSEN(dSampleVin(state_origin = 'NM'),20) +
		CHOOSEN(dSampleVin(state_origin = 'NV'),20) +
		CHOOSEN(dSampleVin(state_origin = 'NY'),20) +
		CHOOSEN(dSampleVin(state_origin = 'OH'),20) +
		CHOOSEN(dSampleVin(state_origin = 'OK'),20) +
		CHOOSEN(dSampleVin(state_origin = 'OR'),20) +
		CHOOSEN(dSampleVin(state_origin = 'PA'),20) +
		CHOOSEN(dSampleVin(state_origin = 'PR'),20) +
		CHOOSEN(dSampleVin(state_origin = 'RI'),20) +
		CHOOSEN(dSampleVin(state_origin = 'SC'),20) +
		CHOOSEN(dSampleVin(state_origin = 'SD'),20) +
		CHOOSEN(dSampleVin(state_origin = 'TN'),20) +
		CHOOSEN(dSampleVin(state_origin = 'TX'),20) +
		CHOOSEN(dSampleVin(state_origin = 'UT'),20) +
		CHOOSEN(dSampleVin(state_origin = 'VA'),20) +
		CHOOSEN(dSampleVin(state_origin = 'VT'),20) +
		CHOOSEN(dSampleVin(state_origin = 'WA'),20) +
		CHOOSEN(dSampleVin(state_origin = 'WI'),20) +
		CHOOSEN(dSampleVin(state_origin = 'WV'),20) +
		CHOOSEN(dSampleVin(state_origin = 'WY'),20);

	oSampleVinMain := OUTPUT(zVehicleSamplesVin, ALL, NAMED('sample_vehicle_records_infutor_mvr_main'));

	dVehicleMainMC := DISTRIBUTE(vehiclev2.files.base.main(source_code = '2V'),HASH(vehicle_key));
	dVehicleMainMC_father := DISTRIBUTE(DATASET('~thor_data400::base::VehicleV2::Main_father', VehicleV2.Layout_Base.Main, FLAT)(source_code = '2V'),HASH(vehicle_key));

	dSampleMC := JOIN(
		dVehicleMainMC,
		dVehicleMainMC_father,
		LEFT.vehicle_key = RIGHT.vehicle_key,
		TRANSFORM(RECORDOF(dVehicleMainMC),self := LEFT),
		LEFT only,
		LOCAL
	);

	zVehicleSamplesMC := CHOOSEN(dSampleMC(state_origin = 'AK'),20) +
		CHOOSEN(dSampleMC(state_origin = 'AL'),20) +
		CHOOSEN(dSampleMC(state_origin = 'AR'),20) +
		CHOOSEN(dSampleMC(state_origin = 'AZ'),20) +
		CHOOSEN(dSampleMC(state_origin = 'CA'),20) +
		CHOOSEN(dSampleMC(state_origin = 'CO'),20) +
		CHOOSEN(dSampleMC(state_origin = 'CT'),20) +
		CHOOSEN(dSampleMC(state_origin = 'DC'),20) +
		CHOOSEN(dSampleMC(state_origin = 'DE'),20) +
		CHOOSEN(dSampleMC(state_origin = 'FL'),20) +
		CHOOSEN(dSampleMC(state_origin = 'GA'),20) +
		CHOOSEN(dSampleMC(state_origin = 'HI'),20) +
		CHOOSEN(dSampleMC(state_origin = 'IA'),20) +
		CHOOSEN(dSampleMC(state_origin = 'ID'),20) +
		CHOOSEN(dSampleMC(state_origin = 'IL'),20) +
		CHOOSEN(dSampleMC(state_origin = 'IN'),20) +
		CHOOSEN(dSampleMC(state_origin = 'KS'),20) +
		CHOOSEN(dSampleMC(state_origin = 'KY'),20) +
		CHOOSEN(dSampleMC(state_origin = 'LA'),20) +
		CHOOSEN(dSampleMC(state_origin = 'MA'),20) +
		CHOOSEN(dSampleMC(state_origin = 'MD'),20) +
		CHOOSEN(dSampleMC(state_origin = 'ME'),20) +
		CHOOSEN(dSampleMC(state_origin = 'MI'),20) +
		CHOOSEN(dSampleMC(state_origin = 'MN'),20) +
		CHOOSEN(dSampleMC(state_origin = 'MO'),20) +
		CHOOSEN(dSampleMC(state_origin = 'MS'),20) +
		CHOOSEN(dSampleMC(state_origin = 'MT'),20) +
		CHOOSEN(dSampleMC(state_origin = 'NC'),20) +
		CHOOSEN(dSampleMC(state_origin = 'ND'),20) +
		CHOOSEN(dSampleMC(state_origin = 'NE'),20) +
		CHOOSEN(dSampleMC(state_origin = 'NH'),20) +
		CHOOSEN(dSampleMC(state_origin = 'NJ'),20) +
		CHOOSEN(dSampleMC(state_origin = 'NM'),20) +
		CHOOSEN(dSampleMC(state_origin = 'NV'),20) +
		CHOOSEN(dSampleMC(state_origin = 'NY'),20) +
		CHOOSEN(dSampleMC(state_origin = 'OH'),20) +
		CHOOSEN(dSampleMC(state_origin = 'OK'),20) +
		CHOOSEN(dSampleMC(state_origin = 'OR'),20) +
		CHOOSEN(dSampleMC(state_origin = 'PA'),20) +
		CHOOSEN(dSampleMC(state_origin = 'PR'),20) +
		CHOOSEN(dSampleMC(state_origin = 'RI'),20) +
		CHOOSEN(dSampleMC(state_origin = 'SC'),20) +
		CHOOSEN(dSampleMC(state_origin = 'SD'),20) +
		CHOOSEN(dSampleMC(state_origin = 'TN'),20) +
		CHOOSEN(dSampleMC(state_origin = 'TX'),20) +
		CHOOSEN(dSampleMC(state_origin = 'UT'),20) +
		CHOOSEN(dSampleMC(state_origin = 'VA'),20) +
		CHOOSEN(dSampleMC(state_origin = 'VT'),20) +
		CHOOSEN(dSampleMC(state_origin = 'WA'),20) +
		CHOOSEN(dSampleMC(state_origin = 'WI'),20) +
		CHOOSEN(dSampleMC(state_origin = 'WV'),20) +
		CHOOSEN(dSampleMC(state_origin = 'WY'),20);

	oSampleMCMain := OUTPUT(zVehicleSamplesMC, ALL, NAMED('sample_vehicle_records_infutor_mc_main'));

	dVehiclePartyVin := DISTRIBUTE(vehiclev2.files.base.party(source_code = '1V'),HASH(vehicle_key));
	dVehiclePartyVin_father:= DISTRIBUTE(
		DATASET(
			'~thor_data400::base::VehicleV2::Party_father',
			VehicleV2.Layout_Base.Party_CCPA,
			FLAT
		)(source_code = '1V'),
		HASH(vehicle_key)
	);

	dSampleVinParty := JOIN(dVehiclePartyVin,
		dVehiclePartyVin_father,
		LEFT.vehicle_key = RIGHT.vehicle_key,
		TRANSFORM(RECORDOF(dVehiclePartyVin),self := LEFT),
		LEFT only,
		LOCAL
	);

	zVehicleSamplesVinParty := CHOOSEN(dSampleVinParty(state_origin = 'AK'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'AL'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'AR'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'AZ'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'CA'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'CO'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'CT'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'DC'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'DE'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'FL'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'GA'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'HI'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'IA'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'ID'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'IL'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'IN'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'KS'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'KY'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'LA'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'MA'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'MD'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'ME'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'MI'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'MN'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'MO'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'MS'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'MT'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'NC'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'ND'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'NE'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'NH'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'NJ'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'NM'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'NV'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'NY'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'OH'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'OK'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'OR'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'PA'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'PR'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'RI'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'SC'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'SD'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'TN'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'TX'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'UT'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'VA'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'VT'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'WA'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'WI'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'WV'),20) +
		CHOOSEN(dSampleVinParty(state_origin = 'WY'),20);

	oSampleVinParty := OUTPUT(zVehicleSamplesVinParty, ALL, NAMED('sample_vehicle_records_infutor_mvr_party'));
	
	dVehiclePartyMC := DISTRIBUTE(vehiclev2.files.base.party(source_code = '2V'),HASH(vehicle_key));
	dVehiclePartyMC_father := DISTRIBUTE(
		DATASET(
			'~thor_data400::base::VehicleV2::Party_father',
			VehicleV2.Layout_Base.Party_CCPA,
			FLAT
		)(source_code = '2V'),
		HASH(vehicle_key)
	);


	dSampleMCParty := JOIN(dVehiclePartyMC,
		dVehiclePartyMC_father,
		LEFT.vehicle_key = RIGHT.vehicle_key,
		TRANSFORM(RECORDOF(dVehiclePartyMC),self := LEFT),
		LEFT only,
		LOCAL
	);

	zVehicleSamplesMCParty := CHOOSEN(dSampleMCParty(state_origin = 'AK'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'AL'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'AR'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'AZ'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'CA'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'CO'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'CT'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'DC'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'DE'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'FL'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'GA'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'HI'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'IA'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'ID'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'IL'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'IN'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'KS'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'KY'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'LA'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'MA'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'MD'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'ME'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'MI'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'MN'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'MO'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'MS'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'MT'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'NC'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'ND'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'NE'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'NH'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'NJ'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'NM'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'NV'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'NY'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'OH'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'OK'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'OR'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'PA'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'PR'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'RI'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'SC'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'SD'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'TN'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'TX'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'UT'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'VA'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'VT'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'WA'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'WI'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'WV'),20) +
		CHOOSEN(dSampleMCParty(state_origin = 'WY'),20);

	oSampleMCParty := OUTPUT(zVehicleSamplesMCParty, ALL, NAMED('sample_vehicle_records_infutor_mc_party'));
	
	RETURN PARALLEL(
		oSampleVinMain,
		oSampleMCMain,
		oSampleVinParty,
		oSampleMCParty
	);

END;
