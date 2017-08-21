import tools,_control,VersionControl,roxiekeybuild, ut; 

export Build_All(
	
  string									jobid 	
	,string									pversion
	,boolean								pIsTesting							= false
	,boolean								pOverwrite							= false													
) :=
module

export full_build :=
	sequential(
	  spray(jobid)
		,Build_Base(jobid, pversion, pIsTesting).full_build
		,Build_Keys(pversion, pIsTesting).all
		,Build_Strata(pversion, pIsTesting).all
		,Promote(pversion).Built2QA
		//,roxiekeybuild.updateversion('PSSKeys',pversion,'christopher.brodeur@lexisnexis.com',,'N')
		,output(Fn_Get_Report(pversion, pIsTesting),all, named('ReportAllRecords'))
		,output(Fn_Get_Report(pversion, pIsTesting, ut.getdate[..6]),all, named('ReportCurrentMonth'))
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure)
	;

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping PSS.Build_All')
	);

end;