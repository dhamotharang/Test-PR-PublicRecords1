import business_header_ss, business_risk, EDA_VIA_XML, Risk_Indicators, govdata, Marketing_Best,_control,Business_HeaderV2, versioncontrol,Business_Header_BDL2,paw;

// Check Business_Header.Filters

export proc_Build_All(

	 string		pversion
	,boolean	pOverwrite							= false
	,boolean	pShouldPromote2QA 			= true
	,boolean	pShouldRollbackSources	= true
	,boolean	pShouldSendToStrata			= true

) := 
module

	lstrata := proc_build_strata	(pversion,,,pShouldSendToStrata);

	export proc_Build_Bases := sequential(
		
		 proc_build_business_header_base_files							(pversion).all					
		,lstrata.biz_header			
		,lstrata.biz_rel	
		,Business_Header_SS.proc_build_Business_Header_Keys	(pversion).all	
		,lstrata.biz_best
		,lstrata.biz_group
		,Business_Header_SS.proc_build_Business_Search_Keys	(pversion).all
		,proc_build_new_fetch_keys													(pversion).all							
		,proc_build_business_header_BDL2_base_file					(pversion).all
		,lstrata.biz_bdl
		,Proc_Build_BDL2_Keys                     					(pversion).all
		,proc_build_business_contacts_base_files						(pversion).all							
		,lstrata.biz_contacts
		,proc_build_business_contacts_keys									(pversion).All	
		,PAW.Proc_Build_All																	(pversion,,false,pShouldSendToStrata,false)
		,Stats																							(pversion).all_separate_files
		,fCheckSources																			(				 ).all
		
	) : success(Send_Email(pversion).BasesFinished), failure(Send_Email(pversion).BuildFailure);

	export proc_Build_Other := sequential(
	
		 business_risk.proc_build_brisk_keys								(pversion).all	
		,risk_indicators.proc_build_hri_all									(pversion,false,false,'built')									
		,EDA_VIA_XML.proc_build_bizword_key									(pversion).all						
		,Marketing_Best.Proc_Build_Marketing_Best						(pversion,false,pShouldSendToStrata,false)								
		,govdata.proc_build_all_keys												(pversion).all
		,govdata.QA_Records
//		,Proc_Build_Keydiffs																() 
		,proc_create_business_relationships									(pversion)
		,if(pShouldPromote2QA, Promote2QA)
	
	) : success(Send_Email(pversion,,pShouldPromote2QA).Roxie.All), failure(Send_Email(pversion).BuildFailure);

	export proc_cleanup := sequential(
	
		 Business_HeaderV2.Source_Rollback().all
	
	);
	export full_build := 
	sequential(
		 Business_HeaderV2.Source_Promote().all
		,proc_Build_Bases
		,proc_Build_Other
		,if(pShouldRollbackSources,proc_cleanup)
		,notify('BUSINESS HEADER KEY BUILD COMPLETE','*')
	) : success(Send_Email(pversion).BuildSuccess)
		, failure(Send_Email(pversion).BuildFailure)
		;
	
	export All := 
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Business_Header.proc_Build_All')
	);
		
end;