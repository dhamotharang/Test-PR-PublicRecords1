IMPORT ALC, Strata, tools;

EXPORT Strata_Stats(STRING										pversion,
										BOOLEAN										pIsTesting = FALSE,
										BOOLEAN										pOverwrite = FALSE,
										DATASET(ALC.Layouts.Base)	pBaseBuilt = ALC.Files().Base.Built) := MODULE

	Strata.mac_Pops(pBaseBuilt, dMainPops);
	
	strata_name := ALC._Dataset().Name;

	Strata.mac_CreateXMLStats(dMainPops, strata_name, 'main', pversion, ALC.Email_Notification_Lists.Stats,
	                             dMainPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion), dMainPopsOut);

END;