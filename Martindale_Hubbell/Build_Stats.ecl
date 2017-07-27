import versioncontrol;

export Build_Stats(

	 string																					pversion
	,dataset(layouts.base.affiliated_individuals	)	pAffBase		= files().base.affiliated_individuals.built
	,dataset(layouts.base.unaffiliated_individuals)	pUnaffBase	= files().base.unaffiliated_individuals.built
	,dataset(layouts.base.Organizations						)	pOrgBase 		= files().base.Organizations.built
	,boolean																				pOverwrite	= false

) :=
module

	shared dAffstats		:= Stats(pversion).fAffiliated_Individuals	(pAffBase		);
	shared dUnaffstats 	:= Stats(pversion).fUnaffiliated_Individuals(pUnaffBase	);
	shared dOrgstats 		:= Stats(pversion).fOrganizations						(pOrgBase		);

	shared lnames := filenames(pversion).stat;

	VersionControl.macBuildNewLogicalFile( lnames.affiliated_individuals.new		,dAffstats	,BuildAffStats		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile( lnames.unaffiliated_individuals.new	,dUnaffstats,BuildUnaffStats	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile( lnames.Organizations.new							,dOrgstats	,BuildOrgStats		,,,pOverwrite);

	export all := 
	sequential(
		parallel(
			 BuildAffStats	
			,BuildUnaffStats
			,BuildOrgStats	
		)
		,promote(pversion, '::stats::',pClearSuperFirst := false).new2qa
	);

end;