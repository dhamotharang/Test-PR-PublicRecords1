#workunit('name','Vehicle V2 sample Records');

export new_records_sample(string process_date) := function
	dVehicleMain				:= distribute(vehiclev2.file_VehicleV2_Main(source_code = 'AE'),hash(vehicle_key));
	dVehicleMain_father	:= distribute(dataset('~thor_data400::base::VehicleV2::Main_father', VehicleV2.Layout_Base_Main, flat)(source_code = 'AE'),hash(vehicle_key));

	dSample := join(dVehicleMain,
									dVehicleMain_father,
									left.vehicle_key = right.vehicle_key,
									transform(recordof(dVehicleMain),self := left),
									left only,
									local
									);
										
	sample_CO := choosen(dSample(state_origin = 'CO'),20);
	sample_DC := choosen(dSample(state_origin = 'DC'),20);
	sample_FL := choosen(dSample(state_origin = 'FL'),20);
	sample_IL := choosen(dSample(state_origin = 'IL'),20);
	sample_KY := choosen(dSample(state_origin = 'KY'),20);
	sample_LA := choosen(dSample(state_origin = 'LA'),20);
	sample_MA := choosen(dSample(state_origin = 'MA'),20);
	sample_ME := choosen(dSample(state_origin = 'ME'),20);
	sample_MI := choosen(dSample(state_origin = 'MI'),20);
	sample_MN := choosen(dSample(state_origin = 'MN'),20);
	sample_MO := choosen(dSample(state_origin = 'MO'),20);
	sample_MS := choosen(dSample(state_origin = 'MS'),20);
	sample_MT := choosen(dSample(state_origin = 'MT'),20);
	sample_ND := choosen(dSample(state_origin = 'ND'),20);
	sample_NE := choosen(dSample(state_origin = 'NE'),20);
	sample_NM := choosen(dSample(state_origin = 'NM'),20);
	sample_NV := choosen(dSample(state_origin = 'NV'),20);
	sample_NY := choosen(dSample(state_origin = 'NY'),20);
	sample_OH := choosen(dSample(state_origin = 'OH'),20);
	sample_TN := choosen(dSample(state_origin = 'TN'),20);
	sample_TX := choosen(dSample(state_origin = 'TX'),20);
	sample_WI := choosen(dSample(state_origin = 'WI'),20);
	sample_WY := choosen(dSample(state_origin = 'WY'),20);

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
												 
	return sequential(output(zVehicleSamples,all,named('sample_vehicle_records')),
										fileservices.sendemail('QualityAssurance@seisint.com;kgummadi@seisint.com',
																						'Vehicle V2 sample records for build version ' + process_date,
																						'New Vehicle V2 QA sample records: http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit
																					)
									 );
end;