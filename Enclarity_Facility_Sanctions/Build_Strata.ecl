import tools,strata;
export Build_Strata( string	pversion, boolean pUseProd = false) := module

	shared dFacSancUpdate 			:= Strata_stats.facility_sanctions(Files(pversion,pUseProd).facility_sanctions_Base.Built);

	Strata.createXMLStats(dFacSancUpdate.dNoGrouping,'EncFacSanc_v1', 'facility_sanctions_base', pversion, email_notification_lists.BuildSuccess, BuildFacSanc_Strata		,'View','Population');
	
	full_build := 
	parallel(
		 BuildFacSanc_Strata;
	);

	export All := full_build;
		
end;
