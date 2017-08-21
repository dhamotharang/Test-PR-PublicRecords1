IMPORT CMS_AddOn, Strata, tools;

EXPORT Strata_Population_Stats(STRING													 pversion,
															 BOOLEAN												 pIsTesting 		 = FALSE,
															 BOOLEAN												 pOverwrite		 	 = FALSE,
															 DATASET(CMS_AddOn.Layouts.Base) pBaseAddOnBuilt = CMS_AddOn.Files().Base.Built) := MODULE

	Strata.mac_Pops(pBaseAddOnBuilt, pBaseAddOnPops);
	
	Strata.mac_CreateXMLStats(pBaseAddOnPops, CMS_AddOn._Dataset().Name, 'main',
	                             pversion, CMS_AddOn.Email_Notification_Lists.Stats,
	                             dAddOnPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pversion), dAddOnPopsOut);

END;