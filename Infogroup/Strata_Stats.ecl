IMPORT Infogroup, Strata, tools;

EXPORT Strata_Stats(STRING										      pversion,
										BOOLEAN										      pIsTesting = FALSE,
										BOOLEAN										      pOverwrite = FALSE,
										DATASET(Infogroup.Layouts.Base)	pBaseBuilt = Infogroup.Files().Base.Built) := MODULE

	Strata.mac_Pops(pBaseBuilt, dMainPops, 'license_state');
	
	strata_name := Infogroup._Dataset().Name;

	Strata.mac_CreateXMLStats(dMainPops, strata_name, 'main', pversion, Infogroup.Email_Notification_Lists.Stats,
	                             dMainPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion), dMainPopsOut);

END;