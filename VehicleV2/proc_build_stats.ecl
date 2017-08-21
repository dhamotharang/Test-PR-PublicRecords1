export proc_build_stats(filedate,zDoStatsReference)
 :=
  macro

	#uniquename(zDoPopulationStats);
	
	VehicleV2.out_STRATA_population_stats(vehicleV2.file_vehicleV2_main
									   ,vehicleV2.File_VehicleV2_Party_Building
									   ,filedate
									   ,%zDoPopulationStats%);

	zDoStatsReference	:=  %zDoPopulationStats%;
									 
  endmacro
 ;
