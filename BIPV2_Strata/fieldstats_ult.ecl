import strata, BIPV2_Files,BIPv2_HRCHY,BIPV2,BIPV2_Postprocess;

EXPORT fieldstats_ult(

   string                                  	pversion  = 'built'
  ,dataset(BIPV2.CommonBase.layout ) 				pinfile   = bipv2.CommonBase.DS_CLEAN
  ,dataset(layouts.laysegmentation       ) 	pSegStats = BIPV2_Postprocess.Files(pversion).UltidSegs.logical

) := 
module

  shared segmentationFile := pSegStats;

  shared active   := join(pinfile, segmentationFile(inactive = ''),  left.ultid = right.id, transform(recordof(left), self := left), hash);
  shared inactive := join(pinfile, segmentationFile(inactive != ''), left.ultid = right.id, transform(recordof(left), self := left), hash);

  export active_fieldStats 			:= Strata.macf_Pops(active,,,,,,,,true);              // this will do population statistics on the whole dataset(not grouping on any field) for every field

  export inactive_fieldStats 		:= Strata.macf_Pops(inactive,,,,,,,,true);              // this will do population statistics on the whole dataset(not grouping on any field) for every field

end;