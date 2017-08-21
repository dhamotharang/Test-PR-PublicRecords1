export proc_liens_stats(filedate,zDoStatsReference)
 :=
  macro

	#uniquename(zDoPopulationStats);
	
	LiensV2.out_STRATA_population_stats(LiensV2.file_liens_main
									   ,LiensV2.File_Liens_Party_BIPV2
									   ,filedate
									   ,%zDoPopulationStats%);

	zDoStatsReference	:=	 parallel(liensV2.stats_main
									  ,liensV2.stats_party
									  ,LiensV2.stats_party_DID
									  ,%zDoPopulationStats%
									  );
  endmacro
 ;
