import tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,boolean							pShouldUpdateRoxiePage	= true
	,dataset(lay_builds)	pBuildFilenames					= keynames(pversion,pUseOtherEnvironment).dAll_filenames
	,string								pEmailList							= Email_Notification_Lists(not pShouldUpdateRoxiePage).BuildSuccess
	,string								pRoxieEmailList					= Email_Notification_Lists(not pShouldUpdateRoxiePage).Roxie
	,string								pBuildName							= _Constants().Name
	,string								pPackageName						= 'FrandxKeys'
	,string								pBuildMessage						= 'Base Files Finished' + 'Remember to Update Dops196'
	,string               pUseVersion             = 'qa'
  ,string               pEnvironment            = 'N|BN' 


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
		, pUseVersion
    , pEnvironment
	);
