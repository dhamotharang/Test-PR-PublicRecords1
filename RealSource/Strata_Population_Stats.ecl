IMPORT Strata, tools;

EXPORT Strata_Population_Stats(
	STRING																pVersion,
	BOOLEAN																pIsTesting				= FALSE,
	BOOLEAN																pOverwrite				= FALSE,
	DATASET(RealSource.Layouts.base)							pBase							= RealSource.Files.Base_out) := MODULE

	Strata.mac_Pops(pBase,	dBasePops);
	
	Strata.mac_CreateXMLStats(dBasePops, 'RealSource', 'Base', pVersion, RealSource.Email_Notification_Lists.strata,
	                             dBasePopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),
									 SEQUENTIAL(dBasePopsOut));

END;