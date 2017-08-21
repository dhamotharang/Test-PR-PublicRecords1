d01 := output(choosen(vehicleV2.file_VehicleV2_main(iteration_key = max(vehicleV2.file_VehicleV2_main,iteration_key) AND State_Origin = 'OH' AND Source_Code = 'DI'), 1000),named('vehicleV2_main_OH_sample_QA'));
d02 := output(choosen(vehicleV2.file_vehicleV2_party(date_vendor_last_reported = max(vehicleV2.file_vehicleV2_party,date_vendor_last_reported) and (unsigned6)append_did > 0 AND State_Origin = 'OH' AND Source_Code = 'DI'), 1000), named('vehicleV2_party_OH_sample_QA'));


export New_Records_Sample_OH := parallel(d01, d02);