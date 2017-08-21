

export proc_dnbfein_stats(filedate,zDoStatsReference):= macro

	#uniquename(zDoPopulationStats);
	
	dnb_feinv2.out_STRATA_population_stats(DNB_FEINV2.File_DNB_Fein_base_main_new
																				,filedate
																				,%zDoPopulationStats%);

	zDoStatsReference	:=	parallel(DNB_FEINv2.Dnb_fein_base_main_stats 
																,DNB_FEINv2.Dnb_fein_base_main_stats_BDID 
																,%zDoPopulationStats%) ;
  endmacro ;
