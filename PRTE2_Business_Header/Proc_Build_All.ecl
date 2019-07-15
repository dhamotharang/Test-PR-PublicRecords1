import _control, VersionControl, Business_Header, tools, PRTE;

export Proc_Build_All(

	 string		pversion
	,boolean	pOverwrite							= false
	,boolean	pShouldPromote2QA 			= true
	,boolean	pShouldUpdateDOPS				= true
	
) := 
module

export proc_Build_Bases := sequential(			
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

export update_dops :=	iff(pShouldUpdateDOPS, 
														PRTE.UpdateVersion(
															'BusinessHeaderKeys'								//	Package name
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
			 ,proc_Build_Bases
			 ,PRTE2_Business_Header.promote().Inputfiles.Using2Used
			 ,update_dops
		 )
		,output('No Valid version parameter passed, skipping PRTE2_Business_Header.proc_Build_All')
	);
																		 
end;