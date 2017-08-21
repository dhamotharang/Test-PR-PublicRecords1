import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= true
	,dataset(lay_builds)	pBuildFilenames					= keynames(pversion,pUseOtherEnvironment).dAll_filenames
	,string								pEmailList							= Email_Notification_Lists.BuildSuccess
	,string								pRoxieEmailList					= Email_Notification_Lists.Roxie
	,string								pBuildName							= _Dataset().Name
	,string								pPackageName						= 'POEKeys'
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
    ,'N' // //       'N' - nonfcra, 'F' - FCRA
	);
