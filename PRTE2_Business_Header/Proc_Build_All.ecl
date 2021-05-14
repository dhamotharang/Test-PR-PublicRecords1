import _control, VersionControl, Business_Header, tools, PRTE, dops,prte2,orbit3;

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


//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= _control.MyInfo.EmailAddressNormal;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(Constants.dops_name, pversion, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	
	PerformUpdateOrNot	:= IF(pShouldUpdateDOPS,PARALLEL(updatedops),NoUpdate);
//---------------------------------------------------------------------------------------

updateorbit:= orbit3.proc_Orbit3_CreateBuild('PRTE2- BusinessHeader', pversion, 'PN', _control.Myinfo.EmailAddressNormal);


key_validation :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));


export All := 
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				PRTE2_Business_Header.promote().Inputfiles.Sprayed2Using
			 ,proc_Build_Bases
			 ,PRTE2_Business_Header.promote().Inputfiles.Using2Used
			 ,PerformUpdateOrNot
			 ,key_validation
			 ,updateorbit	
		 )
		,output('No Valid version parameter passed, skipping PRTE2_Business_Header.proc_Build_All')
	);
																		 
end;