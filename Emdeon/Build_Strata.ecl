IMPORT tools,strata;

EXPORT Build_Strata( STRING	pVersion, BOOLEAN pUseProd = FALSE) := MODULE

	// C Record
	
	SHARED dCRecordUpdate	:= Strata_Stats.CRecord(Files(pVersion,pUseProd).claims_base.Built);

	Strata.createXMLStats(dCRecordUpdate.dNoGrouping
													,'Emdeon'
													,'base'
													,pVersion
													,email_notification_lists.BuildSuccess
													,BuildCRecord_Strata
													,'C'
													,'Record'
													);

	full_build := PARALLEL(
									BuildCRecord_Strata;
								);

	EXPORT CRecord := full_build;
	
	// D Record
	
	SHARED dDRecordUpdate	:= Strata_Stats.DRecord(Files(pVersion,pUseProd).detail_base.Built);

	Strata.createXMLStats(dCRecordUpdate.dNoGrouping
													,'Emdeon'
													,'base'
													,pVersion
													,email_notification_lists.BuildSuccess
													,BuildDRecord_Strata
													,'D'
													,'Record'
													);

	full_build := PARALLEL(
									BuildDRecord_Strata;
								);

	EXPORT DRecord := full_build;
	
	// S Record
	
	SHARED dSRecordUpdate	:= Strata_Stats.SRecord(Files(pVersion,pUseProd).splits_base.Built);

	Strata.createXMLStats(dSRecordUpdate.dNoGrouping
													,'Emdeon'
													,'base'
													,pVersion
													,email_notification_lists.BuildSuccess
													,BuildSRecord_Strata
													,'S'
													,'Record'
													);

	full_build := PARALLEL(
									BuildSRecord_Strata;
								);

	EXPORT SRecord := full_build;

END;