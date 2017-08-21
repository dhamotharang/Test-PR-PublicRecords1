import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= false
	,dataset(lay_builds)	pBuildFilenames					= dataset([],tools.Layout_FilenameVersions.builds)
	,string								pEmailList							= Email_Notification_Lists(not pShouldUpdateRoxiePage).BuildSuccess
	,string								pRoxieEmailList					= Email_Notification_Lists(not pShouldUpdateRoxiePage).Roxie
	,string								pBuildName							= _Constants().Name
	,string								pPackageName						= pBuildName + 'Keys'
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
	);
