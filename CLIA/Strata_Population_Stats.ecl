IMPORT Strata, tools;

EXPORT Strata_Population_Stats(STRING								 pversion,
															 BOOLEAN							 pIsTesting = FALSE,
															 BOOLEAN							 pOverwrite = FALSE,
															 DATASET(Layouts.Base) pBaseBuilt = Files().Base.Main.Built) := MODULE

  // Projecting to old layout so that the stats don't bomb, currently.
	Strata.mac_Pops(pBaseBuilt, dMainPops, 'state');
	
	// Basefile has changed and so has what we want stats on.
	strata_name := _Dataset().Name + '_v4';

	Strata.mac_CreateXMLStats(dMainPops, strata_name, 'main', pversion, Email_Notification_Lists().Stats,
	                             dMainPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion), dMainPopsOut);

END;