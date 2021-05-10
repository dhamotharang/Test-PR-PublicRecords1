EXPORT new_records_sample(STRING process_date) := FUNCTION
	dVehicleMain := DISTRIBUTE(
		vehiclev2.file_VehicleV2_Main(source_code = 'AE'),
		HASH(vehicle_key)
	);
	dVehicleMain_father	:= DISTRIBUTE(
		DATASET(
			'~thor_data400::base::VehicleV2::Main_father',
			VehicleV2.Layout_Base_Main,
			flat
		)(source_code = 'AE'),
		HASH(vehicle_key)
	);

	dSample := JOIN(
		dVehicleMain,
		dVehicleMain_father,
		left.vehicle_key = right.vehicle_key,
		transform(recordof(dVehicleMain),self := left),
		left only,
		local
	);

	sample_CO := CHOOSEN(dSample(state_origin = 'CO'),20);
	sample_DC := CHOOSEN(dSample(state_origin = 'DC'),20);
	sample_FL := CHOOSEN(dSample(state_origin = 'FL'),20);
	sample_IL := CHOOSEN(dSample(state_origin = 'IL'),20);
	sample_KY := CHOOSEN(dSample(state_origin = 'KY'),20);
	sample_LA := CHOOSEN(dSample(state_origin = 'LA'),20);
	sample_MA := CHOOSEN(dSample(state_origin = 'MA'),20);
	sample_ME := CHOOSEN(dSample(state_origin = 'ME'),20);
	sample_MI := CHOOSEN(dSample(state_origin = 'MI'),20);
	sample_MN := CHOOSEN(dSample(state_origin = 'MN'),20);
	sample_MO := CHOOSEN(dSample(state_origin = 'MO'),20);
	sample_MS := CHOOSEN(dSample(state_origin = 'MS'),20);
	sample_MT := CHOOSEN(dSample(state_origin = 'MT'),20);
	sample_ND := CHOOSEN(dSample(state_origin = 'ND'),20);
	sample_NE := CHOOSEN(dSample(state_origin = 'NE'),20);
	sample_NM := CHOOSEN(dSample(state_origin = 'NM'),20);
	sample_NV := CHOOSEN(dSample(state_origin = 'NV'),20);
	sample_NY := CHOOSEN(dSample(state_origin = 'NY'),20);
	sample_OH := CHOOSEN(dSample(state_origin = 'OH'),20);
	sample_TN := CHOOSEN(dSample(state_origin = 'TN'),20);
	sample_TX := CHOOSEN(dSample(state_origin = 'TX'),20);
	sample_WI := CHOOSEN(dSample(state_origin = 'WI'),20);
	sample_WY := CHOOSEN(dSample(state_origin = 'WY'),20);

	zVehicleSamples := sample_CO +
		sample_DC +
		sample_FL +
		sample_IL +
		sample_KY +
		sample_LA +
		sample_MA +
		sample_ME +
		sample_MI +
		sample_MN +
		sample_MO +
		sample_MS +
		sample_MT +
		sample_ND +
		sample_NE +
		sample_NM +
		sample_NV +
		sample_NY +
		sample_OH +
		sample_TN +
		sample_TX +
		sample_WI +
		sample_WY;

	RETURN SEQUENTIAL(
		OUTPUT(zVehicleSamples,all,named('sample_vehicle_records')),
		fileservices.sendemail(
			'QualityAssurance@seisint.com;kgummadi@seisint.com',
			'Vehicle V2 sample records for build version ' + process_date,
			'New Vehicle V2 QA sample records: http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + WORKUNIT
		)
	);

END;
