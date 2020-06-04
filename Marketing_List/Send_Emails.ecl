import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= true
	,string								pKeyDatasetName					= 'Marketing_List'
	,dataset(lay_builds)	pBuildFilenames					= filenames(pversion,pUseOtherEnvironment).dAll_filenames
	,string								pEmailList							= Email_Notification_Lists(not pShouldUpdateRoxiePage).BuildSuccess
	,string								pRoxieEmailList					= Email_Notification_Lists(not pShouldUpdateRoxiePage).Roxie
	,string								pBuildName							= _Config().Name
	,string								pPackageName						= pKeyDatasetName + 'Keys'
	,string								pBuildMessage						= 'Base Files Finished'
) := 
	tools.mod_SendEmails(
		 pversion
		,pBuildFilenames					
		,pEmailList							
		,pRoxieEmailList					
		,pBuildName							
		,pPackageName			
		,pBuildMessage
		,pShouldUpdateRoxiePage
		,
    , 'N' // //  'N' - nonfcra, 'F' - FCRA

	);
