import tools,strata,std;

export Build_Strata( string	pversion, boolean pUseProd = false) := module

  shared version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion):INDEPENDENT;

	shared dUpdate := Strata_stats(Files(version,pUseProd).Base.Built);
	
	Strata.createXMLStats(dUpdate.dNoGrouping,'IDA', 'base', version, IDA.email_notification_lists.BuildSuccess, BuildGeneric_Strata,'View','Population');

	full_build := 
	parallel(
		 BuildGeneric_Strata		
	);

	export All := full_build;
		
end;


