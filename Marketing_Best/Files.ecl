import versioncontrol, business_header_ss, risk_indicators, Business_HeaderV2, statistics;

export Files(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
	
	shared basenames	:= filenames(pversion,pUseOtherEnvironment);
		
	VersionControl.macBuildFileVersions(basenames.Best_All					,Layout_Best						,Best_All						, built);
	VersionControl.macBuildFileVersions(basenames.Best_Restricted		,Layout_Best						,Best_Restricted		, built);
	VersionControl.macBuildFileVersions(basenames.Titles_All				,Layout_Marketing_Title	,Titles_All					, built);
	VersionControl.macBuildFileVersions(basenames.Titles_Restricted	,Layout_Marketing_Title	,Titles_Restricted	, built);
                                                                                                 

end;