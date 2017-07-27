import versioncontrol;
export Files(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	versioncontrol.macInputFileVersions	(Filenames(pversion,pUseOtherEnvironment).input	,layouts.Input.Sprayed	,Input			,'CSV','','</DOCUMENT>','~~~',0,_Dataset().max_record_size);

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Base.Organizations								,layouts.Base.Organizations							,Organizations						);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Base.Affiliated_Individuals			,layouts.Base.Affiliated_Individuals		,Affiliated_Individuals		);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).Base.Unaffiliated_Individuals		,layouts.Base.Unaffiliated_Individuals	,Unaffiliated_Individuals	);
	                                                                                
	end;

	export extracts :=
	module
	
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Organizations								,layouts.Temporary.Orgs				,Organizations						);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Affiliated_Individuals			,layouts.Temporary.AffIndiv		,Affiliated_Individuals		);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Unaffiliated_Individuals		,layouts.Temporary.UnaffIndiv	,Unaffiliated_Individuals	);
	                                                                                
	end;

	export extracts2 :=
	module
	
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Organizations								,layouts.Base.Organizations							,Organizations						,pfiletype := 'CSV',pSeparator := '|',pHeading := 1,pMaxLength := 180000000);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Affiliated_Individuals			,layouts.Base.Affiliated_Individuals		,Affiliated_Individuals		,pfiletype := 'CSV',pSeparator := '|',pHeading := 1,pMaxLength := 180000000);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Unaffiliated_Individuals		,layouts.Base.Unaffiliated_Individuals	,Unaffiliated_Individuals	,pfiletype := 'CSV',pSeparator := '|',pHeading := 1,pMaxLength := 180000000);
	                                                                                
	end;

	export base2 :=
	module
	
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Orgs							,layouts.Base.Organizations							,Orgs					);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Aff_Indivs				,layouts.Base.Affiliated_Individuals		,Aff_Indivs		);
		versioncontrol.macBuildFileVersions(Filenames(pversion,pUseOtherEnvironment).extracts.Unaff_Indivs			,layouts.Base.Unaffiliated_Individuals	,Unaff_Indivs	);
	                                                                                
	end;

end;