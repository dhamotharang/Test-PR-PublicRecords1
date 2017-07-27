import strata, BIPV2_Files,BIPv2_HRCHY,BIPV2;

EXPORT fieldstats_ult(

   string                                  	pversion  = 'built'
  ,dataset(BIPV2.CommonBase.layout ) 				pinfile   = BIPV2.CommonBase.DS_CLEAN
  ,dataset(layouts.laysegmentation       ) 	pSegStats = BIPV2_PostProcess.Files(pversion).UltidSegs.logical

) := 
module

	mac_fieldstats_ID(
		pinfile,
		pSegStats,
		ULTID,
		'ULTID',
		out_active_fieldStats,
		out_inactive_fieldStats
	)	

		export active_fieldStats := out_active_fieldStats;
		export inactive_fieldStats := out_inactive_fieldStats;
		
end;