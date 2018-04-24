IMPORT Strata, tools, Header;

EXPORT Strata_Population_Stats(
	STRING																	pVersion,
	BOOLEAN																pIsTesting				= FALSE,
	BOOLEAN																pOverwrite				= FALSE,
	DATASET(layout.base_raw)																		pOKCProbateBase	= Files().file_base,
	DATASET(header.Layout_Did_Death_MasterV3)	pOKCProbateV3			= Files().file_deathmasterv3) := MODULE

	Strata.mac_Pops(pOKCProbateBase	,	dOKCProbateBasePops);
	Strata.mac_Pops(pOKCProbateV3			,	dOKCProbateV3Pops);
	
	Strata.mac_CreateXMLStats(dOKCProbateBasePops, _Dataset().Name, 'Base', pVersion, Email_Notification_Lists().Stats,
	                             dOKCProbateBasePopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dOKCProbateV3Pops, _Dataset().Name, 'V3', pVersion, Email_Notification_Lists().Stats,
	                             dOKCProbateV3PopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),
									 SEQUENTIAL(	dOKCProbateBasePopsOut,
																						dOKCProbateV3PopsOut));

END;