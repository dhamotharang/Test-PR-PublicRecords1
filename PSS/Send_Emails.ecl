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
	,string								pPackageName						= 'PSSKeys'
	,string								pBuildMessage						= 'Base Files Finished'
	,string							  pUseVersion							= 'qa'
	,string							  pEnvironment						= 'N'		//	'B' - OSS Roxie, 'N' - nonfcra, 'F' - FCRA
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
		,pUseVersion
		,pEnvironment
	);
