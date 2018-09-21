import _control, VersionControl, Business_Header, tools, PRTE, PRTE2_BIPV2_BusHeader;

export Proc_Build_Legacy_BIP_All(

	 string		pversion
	,boolean	pOverwrite							= false
	,boolean	pShouldPromote2QA 			= true
	,boolean	pShouldUpdateDOPS				= true
	
) := 
module

//*** Legacy Business Header process.
export proc_Build_BH_Bases := sequential(			
			PRTE2_Business_Header.proc_build_business_header_base_files(pversion).all
		 ,PRTE2_Business_Header.proc_build_Business_Header_Keys(pversion).all		 
		 ,PRTE2_Business_Header.Proc_Build_Business_Search_Keys(pversion).all
		 ,PRTE2_Business_Header.Proc_Build_New_Fetch_Keys(pversion)
		 ,PRTE2_Business_Header.Proc_Build_BDL2_Keys(pversion).all
		 ,PRTE2_Business_Header.proc_build_business_contacts_base_files(pversion).all
		 ,PRTE2_Business_Header.proc_build_business_contacts_keys(pversion).all
		 ,PRTE2_Business_Header.proc_build_brisk_keys(pversion).all
		 ,PRTE2_Business_Header.proc_build_bizword_key(pversion).all
);

export update_BH_dops :=	iff(pShouldUpdateDOPS, 
															PRTE.UpdateVersion(
																'BusinessHeaderKeys'								//	Package name
																,pversion														//	Package version
																,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
																,'B'																//  inloc - 'B' - Boca, 'A' - Alpharetta
																,'N'																//	N = Non-FCRA, F = FCRA
																,'N'                                //	N = Do not also include boolean, Y = Include boolean, too
															)
													 );

//*** BIPV2 Business Header process.
export proc_Build_BIP_BH_Bases := sequential(			
			PRTE2_BIPV2_BusHeader.proc_build_base_files(pversion).all
		 ,PRTE2_BIPV2_BusHeader.Proc_build_Seleid_Relatives(pversion).all
		 ,PRTE2_BIPV2_BusHeader.proc_build_Keys(pversion)
		 ,PRTE2_BIPV2_BusHeader.proc_build_BizLinkFull_Keys(pversion)
		 ,PRTE2_BIPV2_BusHeader.BIPV2_Best_Proc_Build(pversion)
		 ,PRTE2_BIPV2_BusHeader.Proc_Build_HRCY_Keys(pversion)
		 ,PRTE2_BIPV2_BusHeader.proc_build_BIP_business_contact(pversion).all
		 ,PRTE2_BIPV2_BusHeader.Proc_Build_BIPV2WeeklyKeys_Package(pversion)		 
);

export update_BIP_dops_FullKeys :=	iff(pShouldUpdateDOPS, 
																				PRTE.UpdateVersion(
																					'BIPV2FullKeys'											//	Package name
																					,pversion														//	Package version
																					,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
																					,'B'																//  inloc - 'B' - Boca, 'A' - Alpharetta
																					,'N'																//	N = Non-FCRA, F = FCRA
																					,'N'                                //	N = Do not also include boolean, Y = Include boolean, too
																				)
																		 );

export update_BIP_dops_WeeklyKeys :=	iff(pShouldUpdateDOPS, 
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
				PRTE2_Business_Header.promote().Inputfiles.Sprayed2Using
			 ,proc_Build_BH_Bases
			 ,output('************** Legacy/BDID Business Header build Completes *******************')
			 ,output('************** BIPV2 Business Header build begins          *******************')
			 ,proc_Build_BIP_BH_Bases				
			 ,PRTE2_Business_Header.promote().Inputfiles.Using2Used
			 ,parallel(
						 update_BH_dops
						,update_BIP_dops_FullKeys
						,update_BIP_dops_WeeklyKeys
						)
		 )
		,output('No Valid version parameter passed, skipping PRTE2_Business_Header.proc_Build_Legacy_BIP_All')
	);
																		 
end;