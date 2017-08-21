import prte_csv, tools;

export Send_Emails(
	
	 string								pversion
	,string								pPackageName	 
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= false
	,string								pEmailList							= Email_Notification_Lists(not pShouldUpdateRoxiePage).BuildSuccess
//,string								pRoxieEmailList					= Email_Notification_Lists(not pShouldUpdateRoxiePage).Roxie
	,string								pBuildName							= PRTE_CSV._Constants(pUseOtherEnvironment).constants.name
	,string								pBuildMessage						= 'PRTE Process Finished for '+ pPackageName

) := 

	export pBuildFilenames := map(/*
													pPackageName = 'AMSKeys'							=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'ATFKeys' 							=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'BankruptcyV2Keys ' 		=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'BBBKeys' 							=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'BusinessRegKeys ' 		=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'CNLDFacilitiesKeys '	=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'CodesV3Keys ' 				=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'Corp2Keys ' 					=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'CountyKeys ' 					=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'DCAKeys' 							=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'DEAKeys' 							=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'DeathMasterKeys ' 		=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'DNBFEINV2Keys ' 			=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'DNBKeys' 							=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'EBRKeys' 							=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'ExperianCRDBKeys ' 		=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'ExperianFEINKeys ' 		=> keynames(pversion,pUseOtherEnvironment).dAll_filenames */
												  pPackageName = 'FAAKeys' 							=> FAA_Keyfilenames(pversion,pUseOtherEnvironment).dAll_filenames
											/* ,pPackageName = 'Fbn2Keys ' 						=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'ForeclosureKeys ' 		=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'FRANDXKeys' 					=> keynames(pversion,pUseOtherEnvironment).dAll_filenames
												 ,pPackageName = 'GongKeys ' 						=> keynames(pversion,pUseOtherEnvironment).dAll_filenames */
												 ,''
												);
	
	tools.mod_SendEmails(
		 pversion
		,pBuildFilenames					
		,pEmailList							
		,pRoxieEmailList					
		,pBuildName							
		,pPackageName			
		,pBuildMessage
		,pShouldUpdateRoxiePage	
	);