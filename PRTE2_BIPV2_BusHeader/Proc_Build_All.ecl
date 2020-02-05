import _control, VersionControl, Business_Header, tools, PRTE, dops,Prte2, orbit3;

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
		 ,copy_seeds(pversion)
		 ,proc_build_cnpname_slim (pversion)
);
																 
	notifyEmail_full					:= _control.MyInfo.EmailAddressNormal;
	NoUpdate_full 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops_full			:=	PRTE.UpdateVersion(Constants.dops_name_full, pversion, notifyEmail_full,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	PerformUpdateOrNot_full	:= IF(pShouldUpdateDOPS,PARALLEL(updatedops_full),NoUpdate_full);

	notifyEmail_weekly					:= _control.MyInfo.EmailAddressNormal;
	NoUpdate_weekly 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops_weekly		:=	PRTE.UpdateVersion(Constants.dops_name_weekly, pversion, notifyEmail_weekly,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	PerformUpdateOrNot_weekly	:= IF(pShouldUpdateDOPS,PARALLEL(updatedops_weekly),NoUpdate_weekly);

key_validation_full :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name_full, 'N'), named(Constants.dops_name_full+'Validation'));
key_validation_weekly :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name_weekly, 'N'), named(Constants.dops_name_weekly+'Validation'));

updateorbit		:= Orbit3.proc_Orbit3_CreateBuild('PRTE2- BIPV2', pversion, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);  

export All := 
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				Create_Supers
			 ,proc_Build_Bases			 
			 ,updatedops_Full
			 ,updatedops_Weekly
			 ,key_validation_full
			 ,key_validation_weekly
			 ,updateorbit,
		 )
		,output('No Valid version parameter passed, skipping PRTE2_BIPV2_BusHeader.proc_Build_All')
	);
																		 
end;