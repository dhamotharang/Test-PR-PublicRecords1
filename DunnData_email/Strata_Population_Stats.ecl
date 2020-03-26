IMPORT Strata, tools;

EXPORT Strata_Population_Stats(
	STRING																pVersion,
	BOOLEAN																pIsTesting				= FALSE,
	BOOLEAN																pOverwrite				= FALSE,
	DATASET(DunnData_Email.Layouts.base)							pBase							= DunnData_Email.Files.Base) := MODULE

	Strata.mac_Pops(pBase,	dBasePops);
	
	Strata.mac_CreateXMLStats(dBasePops, 'DunnData Email', 'Base', pVersion, DunnData_Email.Email_Notification_Lists.strata,
	                             dBasePopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),
									 SEQUENTIAL(dBasePopsOut));

END;