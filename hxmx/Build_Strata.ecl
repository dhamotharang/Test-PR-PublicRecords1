IMPORT tools,strata,HXMX;

EXPORT Build_Strata( STRING	pVersion, BOOLEAN pUseProd = FALSE) := MODULE

	// HX
	
	SHARED dHXUpdate	:= HXMX.Strata_Stats.HX(Files(pVersion,pUseProd).hx_base.Built);

	Strata.createXMLStats(dHXUpdate.dNoGrouping
													,'Symphony'
													,'base'
													,pVersion
													,email_notification_lists.BuildSuccess
													,BuildHX_Strata
													,'HX'
													,'View'
													);

	full_build := PARALLEL(
									BuildHX_Strata;
								);

	EXPORT HX := full_build;
	
	// MX
	
	SHARED dMXUpdate	:= HXMX.Strata_Stats.MX(Files(pVersion,pUseProd).mx_base.Built);

	Strata.createXMLStats(dMXUpdate.dNoGrouping
													,'Symphony'
													,'base'
													,pVersion
													,email_notification_lists.BuildSuccess
													,BuildMX_Strata
													,'MX'
													,'View'
													);

	full_build := PARALLEL(
									BuildMX_Strata;
								);

	EXPORT MX := full_build;

END;