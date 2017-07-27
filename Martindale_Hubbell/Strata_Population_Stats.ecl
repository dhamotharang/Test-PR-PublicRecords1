import strata, versioncontrol;
export Strata_Population_Stats(

	 string																					pversion
	,dataset(layouts.base.affiliated_individuals	)	pAffBase		= files().base.affiliated_individuals.built
	,dataset(layouts.base.Organizations						)	pOrgBase 		= files().base.Organizations.built

) :=
module

	Strata.createAsBusinessStats.Header		(fAs_Business_Header	(pOrgBase	),_dataset().name,'Organizations'					,pversion,Email_Notification_Lists.Statistics,Organizations					);
	Strata.createAsBusinessStats.Contacts	(fAs_Business_Contact	(pAffBase	),_dataset().name,'Affiliated_Individuals',pversion,Email_Notification_Lists.Statistics,Affiliated_Individuals);
	
	export all := if(VersionControl.IsValidVersion(pversion),
	parallel(
		 Organizations					
		,Affiliated_Individuals
	));

end;