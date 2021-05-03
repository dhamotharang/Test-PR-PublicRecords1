IMPORT Strata, tools;

EXPORT Strata_Population_Stats(
	STRING																pVersion,
	BOOLEAN																pIsTesting				= FALSE,
	BOOLEAN																pOverwrite				= FALSE,
	DATASET(WhoIs.Layouts.base)							pBase							= WhoIs.Files.Base) := MODULE

	Strata.mac_Pops(pBase,	dBasePops);
	
	Strata.mac_CreateXMLStats(dBasePops, 'WhoIs_Data', 'Base', pVersion, WhoIs.Email_Notification_Lists.strata,
	                             dBasePopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),
									 SEQUENTIAL(dBasePopsOut));

END;