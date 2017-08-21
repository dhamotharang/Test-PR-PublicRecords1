import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Email(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= true
	,dataset(lay_builds)	pBuildFilenames					= keynames(pversion).dAll_filenames
	,string								pEmailList							= Email_Notification_Lists.BuildSuccess
	,string								pRoxieEmailList					= Email_Notification_Lists.Roxie
	,string								pPackageName						= Datasetname + 'Keys'
	,string								pBuildMessage						= 'Base Files Finished'
	,string               pUseVersion             = 'qa'
	,string               pEnvironment            = 'N|B'
) := 
	tools.mod_SendEmails(
		 pversion
		,pBuildFilenames					
		,pEmailList							
		,pRoxieEmailList					
		,Datasetname							
		,pPackageName			
		,pBuildMessage
		,pShouldUpdateRoxiePage	
		,pUseVersion
		,pEnvironment
	);
