IMPORT $, strata, ut, tools;

EXPORT strata_popCanadianPhonesInfutor(
	STRING															pVersion,
	BOOLEAN															pIsTesting				= FALSE,
	BOOLEAN															pOverwrite				= FALSE,
	DATASET(CanadianPhones.Layout_InfutorWP.InputFile)	pBase	= CanadianPhones.file_InfutorWP().RawIn) := MODULE
	
	Strata.mac_Pops(pBase,	dBasePops);
	
	Strata.mac_CreateXMLStats(dBasePops, 'CanadianPhonesWP', 'data', pVersion, '',
	                          dBasePopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),
									 SEQUENTIAL(dBasePopsOut));

END;