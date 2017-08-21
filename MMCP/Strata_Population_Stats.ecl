IMPORT Strata, tools;

EXPORT Strata_Population_Stats(STRING								 pversion,
															 BOOLEAN							 pIsTesting = FALSE,
															 BOOLEAN							 pOverwrite = FALSE,
															 DATASET(Layouts.Base) pBaseBuilt = Files().Base.Main.Built) := MODULE

	Strata.mac_Pops(pBaseBuilt, dMainPops, 'state,customer_id');
	
	strata_name := _Dataset().Name;

	Strata.mac_CreateXMLStats(dMainPops, strata_name, 'main_v2', pversion, Email_Notification_Lists().Stats,
	                             dMainPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion), dMainPopsOut);

END;