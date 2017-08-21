// Add as_header and as_business_header stats. 
export proc_BK_stats(filedate,zDoStatsReference)
 :=
  macro

	#uniquename(zDoPopStats);
	
	Bankruptcyv3.out_STRATA_population_stats(BankruptcyV2.file_bankruptcy_main_v3
									   ,BankruptcyV2.file_bankruptcy_search_v3
									   ,filedate
									   ,zDoPopStats);

	zDoStatsReference	:=	 zDoPopStats ;
  endmacro
 ;