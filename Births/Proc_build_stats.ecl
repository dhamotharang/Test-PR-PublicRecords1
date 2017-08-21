export proc_build_stats(filedate,zDoStatsReference)
 :=
  macro

	#uniquename(zDoPopulationStats);

	Births.Out_Births_STRATA_Population	(
										Births.BaseFile_births
										,filedate
										,%zDoPopulationStats%
										);

	zDoStatsReference	:=  %zDoPopulationStats%;

  endmacro;