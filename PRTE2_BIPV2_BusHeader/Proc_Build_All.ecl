import _control, VersionControl, Business_Header, tools, PRTE;

export Proc_Build_All(

	 string		pversion
	,boolean	pOverwrite							= false
	,boolean	pShouldPromote2QA 			= true
	,boolean	pShouldUpdateDOPS				= true
	
) := 
module

export proc_Build_Bases := sequential(			
			PRTE2_BIPV2_BusHeader.proc_build_base_files(pversion).all
		 ,PRTE2_BIPV2_BusHeader.Proc_build_Seleid_Relatives(pversion).all
		 ,PRTE2_BIPV2_BusHeader.proc_build_Keys(pversion)
		 ,PRTE2_BIPV2_BusHeader.proc_build_BizLinkFull_Keys(pversion)
		 ,PRTE2_BIPV2_BusHeader.BIPV2_Best_Proc_Build(pversion)
		 ,PRTE2_BIPV2_BusHeader.Proc_Build_HRCY_Keys(pversion)
		 ,PRTE2_BIPV2_BusHeader.proc_build_BIP_business_contact(pversion).all
		 ,PRTE2_BIPV2_BusHeader.Proc_Build_BIPV2WeeklyKeys_Package(pversion)		 
);

export update_dops_FullKeys :=	iff(pShouldUpdateDOPS, 
																		PRTE.UpdateVersion(
																			'BIPV2FullKeys'											//	Package name
																			,pversion														//	Package version
																			,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
																			,'B'																//  inloc - 'B' - Boca, 'A' - Alpharetta
																			,'N'																//	N = Non-FCRA, F = FCRA
																			,'N'                                //	N = Do not also include boolean, Y = Include boolean, too
																		)
																 );

export update_dops_WeeklyKeys :=	iff(pShouldUpdateDOPS, 
																			PRTE.UpdateVersion(
																				'BIPV2WeeklyKeys'										//	Package name
																				,pversion														//	Package version
																				,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
																				,'B'																//  inloc - 'B' - Boca, 'A' - Alpharetta
																				,'N'																//	N = Non-FCRA, F = FCRA
																				,'N'                                //	N = Do not also include boolean, Y = Include boolean, too
																			)
																	 );

export All := 
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				Create_Supers
			 ,proc_Build_Bases			 
			 ,update_dops_FullKeys
			 ,update_dops_WeeklyKeys
		 )
		,output('No Valid version parameter passed, skipping PRTE2_BIPV2_BusHeader.proc_Build_All')
	);
																		 
end;