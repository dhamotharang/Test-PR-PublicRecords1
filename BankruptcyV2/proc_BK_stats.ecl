// Add as_header and as_business_header stats. 
export proc_BK_stats(filedate,zDoStatsReference)
 :=
  macro

	#uniquename(zDoPopulationStats);
	
	Bankruptcyv2.out_STRATA_population_stats(BankruptcyV2.file_bankruptcy_main
									   ,BankruptcyV2.file_bankruptcy_search
									   ,filedate
									   ,zDoPopulationStats);

	zDoStatsReference	:=	 zDoPopulationStats ;
  endmacro
 ;
 
