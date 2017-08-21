import doxie, VersionControl, Marketing_Best, govdata, paw,tools, risk_indicators;

export Proc_Rename_Logical_Keys(

	 string		pversion
	,string		pPackageName	= 'All'
	,boolean	pIsTesting		= true
	,boolean	pJustKeys			= true
	,string		pSuperVersion	= 'qa'
	,string		pLogicalVersion	= ''

) :=
function
	
	lpackage := Roxie_Packages(pversion);

	dall_names :=  
					lpackage.All_package_keys
				+ if(not pJustKeys,
						business_header.Filenames(pversion).dAll_filenames 
					+ risk_indicators.filenames(pversion).dAll_filenames
					+ Marketing_Best.filenames(pversion).dAll_filenames
					+ paw.filenames(pversion).dAll_filenames
				)
				;

	dpackagekeys := map(
		 regexfind('ACA'										,pPackageName, nocase) => lpackage.ACAInstitutionsKeys
		,regexfind('AddressHRI|hri'					,pPackageName, nocase) => lpackage.AddressHRIKeys			
		,regexfind('BusinessHeader|bh'			,pPackageName, nocase) => lpackage.BusinessHeaderKeys				
		,regexfind('BusinessBest|execs|bb'	,pPackageName, nocase) => lpackage.BusinessBestKeys		
		,regexfind('Peopleatwork|paw'				,pPackageName, nocase) => lpackage.PAWV2Keys
		,regexfind('Govdata|gov'						,pPackageName, nocase) => lpackage.GovdataKeys		
		,regexfind('All'										,pPackageName, nocase) => dall_names
		,pPackageName != ''																				 => 
				dall_names(			regexfind(pPackageName,templatename		,nocase)
										or	regexfind(pPackageName,templatenamenew,nocase)
									)
		,dataset([], versioncontrol.layout_versions.builds)
	);

	dallfiles := dpackagekeys(not(regexfind('stat_overflow', templatename)));
	dallfiles_proj := project(dallfiles, tools.Layout_FilenameVersions.builds);
	rename_keys := tools.fun_RenameBuildFiles(pversion,dallfiles_proj,pIsTesting,pSuperVersion,,pLogicalVersion);

	return rename_keys;

end;