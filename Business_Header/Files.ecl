import versioncontrol, business_header_ss, risk_indicators, Business_HeaderV2, statistics;

export Files(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
	
	shared basenames	:= filenames(pversion,pUseOtherEnvironment).base;
	shared outnames		:= filenames(pversion,pUseOtherEnvironment).out	;
	shared statnames	:= filenames(pversion,pUseOtherEnvironment).stat;

	export base :=
	module
		
		VersionControl.macBuildFileVersions(basenames.search					,Layout_Business_Header_base_orig		,Business_headers_old			, built);
		VersionControl.macBuildFileVersions(basenames.search					,Layout_Business_Header_base				,Business_headers					, built);
		VersionControl.macBuildFileVersions(basenames.contacts				,Layout_Business_Contact_Full_new		,Business_Contacts				, built);
		VersionControl.macBuildFileVersions(basenames.contactsPlus		,Layout_Business_Contact_Full_new		,Business_Contacts_Plus		, built);
		VersionControl.macBuildFileVersions(basenames.HeaderBest			,Layout_BH_Best											,Business_Header_Best			, built);
		VersionControl.macBuildFileVersions(basenames.Relatives				,Layout_Business_Relative						,Business_Relatives				, built);
		VersionControl.macBuildFileVersions(basenames.RelativesGroup	,Layout_Business_Relative_Group			,Business_Relatives_Group	, built);
		VersionControl.macBuildFileVersions(basenames.SuperGroup			,Layout_BH_Super_Group							,Super_Group							, built);
		VersionControl.macBuildFileVersions(basenames.BDL2						,Layout_BDL2												,BDL2											, built);
		VersionControl.macBuildFileVersions(basenames.Eq_Employer			,layout_eq_employer									,Eq_Employer								, built);

		VersionControl.macBuildFileVersions(basenames.Stat										,Layout_Business_Header_Stat														,Stat													, built);
		VersionControl.macBuildFileVersions(basenames.Companyname							,business_header_ss.Layout_CompanyName_SS								,Companyname									, built);
		VersionControl.macBuildFileVersions(basenames.CompanynameAddress			,business_header_ss.Layout_CompanyName_Address_SS				,CompanynameAddress						, built);
		VersionControl.macBuildFileVersions(basenames.CompanynameAddressBroad	,business_header_ss.Layout_CompanyName_Address_Broad_SS	,CompanynameAddressBroad			, built);
		VersionControl.macBuildFileVersions(basenames.CompanynamePhone				,business_header_ss.Layout_CompanyName_Phone_SS					,CompanynamePhone							, built);
		VersionControl.macBuildFileVersions(basenames.CompanynameFein					,business_header_ss.Layout_CompanyName_FEIN_SS					,CompanynameFein							, built);
		VersionControl.macBuildFileVersions(basenames.CompanyWords						,business_header_ss.Layout_Header_Word_Index						,CompanyWords									, built);
		VersionControl.macBuildFileVersions(basenames.Bdid										,business_header_ss.Layout_BH_BDID_City_Plus						,Bdid													, built);
		VersionControl.macBuildFileVersions(basenames.AddressSicCode					,Risk_Indicators.Layout_HRI_Address_Sic									,AddressSicCode								, built);
		VersionControl.macBuildFileVersions(basenames.AddressSicCode2					,Risk_Indicators.Layout_HRI_Address_Sic2								,AddressSicCode2							, built);
		VersionControl.macBuildFileVersions(basenames.AddressSicCodeFCRA			,Risk_Indicators.Layout_HRI_Address_Sic									,AddressSicCodeFCRA						, built);
		VersionControl.macBuildFileVersions(basenames.PeopleAtWorkStats				,Layout_Business_Contacts_Stats													,PeopleAtWorkStats						, built, false);
		VersionControl.macBuildFileVersions(basenames.StatOverflow						,Layout_Business_Header_Stat														,StatOverflow													);
                                                                                                                            

	end;
	
	export Out :=
	module
	
		VersionControl.macBuildFileVersions(outnames.Search					,Business_HeaderV2.Layouts.out.Business_headers					,Search					, built);
		VersionControl.macBuildFileVersions(outnames.HeaderBest			,Business_HeaderV2.Layouts.out.Business_Best						,HeaderBest			, built);
		VersionControl.macBuildFileVersions(outnames.Stat						,Business_HeaderV2.Layouts.out.Business_header_Stat			,Stat						, built);
		VersionControl.macBuildFileVersions(outnames.Relatives			,Business_HeaderV2.Layouts.out.Business_Relative				,Relatives			, built);
		VersionControl.macBuildFileVersions(outnames.RelativesGroup	,Business_HeaderV2.Layouts.out.Business_Relative_Group	,RelativesGroup	, built);
		VersionControl.macBuildFileVersions(outnames.PeopleAtWork		,Business_HeaderV2.Layouts.out.PeopleAtWork							,PeopleAtWork		, built);
		VersionControl.macBuildFileVersions(outnames.Contacts				,Business_HeaderV2.Layouts.out.Business_Contacts				,Contacts				, built);
	                                                                                                   
	end;

	export Stat :=
	module
	
		VersionControl.macBuildFileVersions(statnames.Search					,Statistics.Layouts.standard_stat_out			,Search				);
		VersionControl.macBuildFileVersions(statnames.SuperGroup			,Statistics.Layouts.standard_stat_out			,SuperGroup		);
		VersionControl.macBuildFileVersions(statnames.Contacts				,Statistics.Layouts.standard_stat_out			,Contacts			);
	                                                                                                           
	end;

end;