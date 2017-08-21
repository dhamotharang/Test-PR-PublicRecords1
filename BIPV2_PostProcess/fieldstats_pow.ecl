import strata, BIPV2_Files,BIPv2_HRCHY,BIPV2;

EXPORT fieldstats_pow(

   string                                  	pversion  = 'built'
  ,dataset(BIPV2.CommonBase.layout ) 				pinfile   = BIPV2.CommonBase.DS_CLEAN
  ,dataset(layouts.laysegmentation       ) 	pSegStats = BIPV2_PostProcess.Files(pversion).PowidSegs.logical

) := 
module

	mac_fieldstats_ID(
		pinfile,
		pSegStats,
		POWID,
		'POWID',
		out_active_fieldStats,
		out_inactive_fieldStats
	)	

		export active_fieldStats := out_active_fieldStats;
		export inactive_fieldStats := out_inactive_fieldStats;        

end;