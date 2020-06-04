import tools,strata;
export Build_Strata( boolean isUpdate = true, boolean isFCRA = true, string pVersion = '') := module

	shared dUpdate := Strata_stats(Files(isUpdate,isFCRA,pversion).Base.Built);
	
	Strata.createXMLStats(dUpdate.dNoGrouping,'inquiry_history', 'base', pversion, email_notification_lists.BuildSuccess, BuildGeneric_Strata		,'View','Population');

	full_build := 
	parallel(
		 BuildGeneric_Strata		
	);

	export All := full_build;
		
end;