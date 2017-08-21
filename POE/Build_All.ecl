import tools,_control; 

export Build_All(
	
	 string									pversion
	,boolean								pIsTesting							= false
	,boolean								pOverwrite							= false													
	,boolean								pPullSourceDataFromProd	= _Dataset().IsDataland	// default to pull source data from prod on dataland													
	,dataset(layouts.base	)	pSource_Data						= Source_Data(pPullSourceDataFromProd)

) :=
module

	export full_build :=
	sequential(
		 create_supers
		,Source_Lock(pPullSourceDataFromProd)
		,Build_Base(pversion,pPullSourceDataFromProd,pSource_Data).All
		,Build_Keys(pversion).all
		,Build_Autokeys(pversion)
		,Build_Strata(pversion).all
		,Promote().Built2QA
		,QA_Records()
		,Source_Unlock(pPullSourceDataFromProd)
	) : success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);

	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping POE.Build_All')
	);

end;