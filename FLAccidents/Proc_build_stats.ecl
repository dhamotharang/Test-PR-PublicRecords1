export proc_build_stats(filedate,zDoStatsReference)
 :=
  macro

	#uniquename(zDoPopulationStats);

	FLAccidents.Out_FLCrash_STRATA_Population	(
												FLAccidents.BaseFile_FLCrash0
												,FLAccidents.BaseFile_FLCrash1
												,FLAccidents.BaseFile_FLCrash2v
												,FLAccidents.BaseFile_FLCrash3v
												,FLAccidents.BaseFile_FLCrash4
												,FLAccidents.BaseFile_FLCrash5
												,FLAccidents.BaseFile_FLCrash6
												,FLAccidents.BaseFile_FLCrash7
												,FLAccidents.BaseFile_FLCrash8
												,FLAccidents.BaseFile_FLCrash_Did
												,filedate
												,%zDoPopulationStats%
												);

	zDoStatsReference	:=  %zDoPopulationStats%;

  endmacro;