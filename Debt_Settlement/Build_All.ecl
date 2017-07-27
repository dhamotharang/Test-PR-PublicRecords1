import versioncontrol, _control,Business_Header;

export Build_All(

	 string																			pversion
	,string																			pServerIP						= _control.IPAddress.edata10
	,string																			pDirectory					= '/prod_data_build_13/eval_data/debt_settlement/'
	,string																			pFilename						= 'attroney_file_did_stats.csv'
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
	
	export full_build := sequential(
		Create_Supers
		,spray_files
		,Build_Base(pversion,pUpdateRSIHFile,pUpdateCCFile,pBaseFile,pUseBusHeader,,pBusHeaderBestFile,pBusSICRecs).full_build
	  ,Build_Keys(pversion).all
		,Build_Autokeys(pversion)
		,Promote().Buildfiles.Built2QA
		,Promote().Inputfiles.Using2Used
		,QA_Records()
		,Build_Strata(pversion,pOverwrite,,pIsTesting)
		
	) : success(Send_Emails(pversion).Roxie), failure(send_emails(pversion).buildfailure);
	
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Debt Settlment.Build_All')
	);

end;