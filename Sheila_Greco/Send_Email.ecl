import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Email(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= true
	,dataset(lay_builds)	pBuildFilenames					= keynames(pversion,pUseOtherEnvironment).dAll_filenames
	,string								pEmailList							= Email_Notification_Lists(not pShouldUpdateRoxiePage).BuildSuccess
	,string								pRoxieEmailList					= Email_Notification_Lists(not pShouldUpdateRoxiePage).Roxie
	,string								pBuildName							= _Constants().Name
	,string								pPackageName						= 'SheilaGrecoKeys'
	,string								pBuildMessage						= 'Base Files Finished'
	,string								pUseVersion							= 'qa'
	,string							  pEnvironment						= 'N'		//	'N' - nonfcra, 'F' - FCRA, 'BN' - BIP
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
