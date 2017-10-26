IMPORT Strata, tools;
EXPORT Strata_Population_Stats(
	STRING																pVersion,
	BOOLEAN																pIsTesting				= FALSE,
	BOOLEAN																pOverwrite				= FALSE,
	DATASET(Layout_Base.base)							pBase							= File_OKC_Base) := MODULE

	Strata.mac_Pops(pBase							,	dBasePops);
	
	Strata.mac_CreateXMLStats(dBasePops, _Dataset().Name, 'Base', pVersion, OKC_Student_List.Constants().email_notification_strata,
	                             dBasePopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),
									 SEQUENTIAL(dBasePopsOut));

END;