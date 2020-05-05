import versioncontrol, _control,Business_Header, Orbit3, Scrubs, Scrubs_Debt_Settlement;

export Build_All(

	 string																			pversion
	,string																			pServerIP						= _control.IPAddress.bctlpedata11
	,string																			pDirectory					= '/data/prod_data_build_13/eval_data/debt_settlement/data/'+ pversion + '/'
	,string																			pFilename						= 'attorney_file_did_stats.csv'
	,string																			pFilename2					= 'DebtSettlementCreditCounsel.csv'
	,boolean																		pUseBusHeader				= _Flags.UseBusinessHeader
	,string																			pGroupName					= _Constants().groupname																		
	,boolean																		pIsTesting					= false
	,boolean																		pOverwrite					= false		
	,dataset(layouts.Input.RSIH				)					pUpdateRSIHFile			= Files().InputRSIH.Using
	,dataset(Layouts.Base							)					pBaseFile						= Files().Base.QA
	,dataset(Layouts.Input.CC					)					pUpdateCCFile				= Files().InputCC.Using
	,dataset(Business_Header.Layout_BH_Best)		pBusHeaderBestFile 	= Business_Header.Files().Base.Business_Header_Best.QA
	,dataset(Business_Header.Layout_SIC_Code)		pBusSICRecs 				= Business_Header.Persists().BHBDIDSIC

) :=
module
	
	export spray_files := if(
			pDirectory != ''
	and not(			_Flags.ExistCurrentRSIHSprayed
						and	_Flags.ExistCurrentCCSprayed
			)
	
	, Spray(
		 pversion
		,pServerIP
		,pDirectory 
		,pFilename
		,pFilename2
		,pGroupName
		,pIsTesting
		,pOverwrite

	));
	orbit_update := Orbit3.proc_Orbit3_CreateBuild ('DebtSettlement',pversion,'N');	
	export full_build := sequential(
		Create_Supers
		,spray_files
		,Scrubs.ScrubsPlus('Debt_Settlement','Scrubs_Debt_Settlement','Scrubs_Debt_Settlement_CC', 'CC', pversion,Debt_Settlement.Email_Notification_Lists(pIsTesting).BuildFailure,false)
	  ,Scrubs.ScrubsPlus('Debt_Settlement','Scrubs_Debt_Settlement','Scrubs_Debt_Settlement_RSIH', 'RSIH', pversion,Debt_Settlement.Email_Notification_Lists(pIsTesting).BuildFailure,false)
	 	,if(scrubs.mac_ScrubsFailureTest('Scrubs_Debt_Settlement_CC,Scrubs_Debt_Settlement_RSIH',pversion)
		 	 ,OUTPUT('Scrubs passed.  Continuing to the Build_Base step.')				
			 ,FAIL('Scrubs failed.  Base and keys not built.  Processing stopped.')
		   )		
		,Build_Base(pversion,pUpdateRSIHFile,pUpdateCCFile,pBaseFile,pUseBusHeader,,pBusHeaderBestFile,pBusSICRecs).full_build
 	  ,Build_Keys(pversion).all
		,Build_Autokeys(pversion)
		,Promote().Buildfiles.Built2QA
		,Promote().Inputfiles.Using2Used
		,QA_Records()
		,Build_Strata(pversion,pOverwrite,,pIsTesting)
		,orbit_update
	) : success(Send_Emails(pversion).Roxie), failure(send_emails(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Debt Settlment.Build_All')
	);

end;

