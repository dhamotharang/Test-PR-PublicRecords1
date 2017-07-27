//this macro is designed to serve BIPV2_PostProcess.fieldstats_[some id]

EXPORT mac_fieldstats_ID(
	pinfile,
	pSegStats,
	IDname,
	IDnameString,	//i'm sure there is a way to do without this parameter, but it was giving me trouble and this works just fine
	out_active_fieldStats,
	out_inactive_fieldStats
) :=
MACRO

  shared active   := join(pinFile, pSegStats(inactive = ''),  left.IDname = right.id, transform(recordof(left), self := left), hash);
  shared inactive := join(pinFile, pSegStats(inactive != ''), left.IDname = right.id, transform(recordof(left), self := left), hash);
	
	shared preA	:= Strata.macf_Pops(active,		IDnameString,,,,,,,true);
	shared preI := Strata.macf_Pops(inactive,	IDnameString,,,,,,,true);

  shared out_active_fieldStats 			:= Strata.macf_Pops(preA,,,,,,,['countgroup'],true);            
  shared out_inactive_fieldStats 		:= Strata.macf_Pops(preI,,,,,,,['countgroup'],true);    

ENDMACRO;