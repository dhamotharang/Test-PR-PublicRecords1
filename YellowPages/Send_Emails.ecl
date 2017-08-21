import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Send_Emails(
	
	 string								pversion
	,boolean							pUseOtherEnvironment 		= false
	,dataset(lay_builds)	pBuildFilenames					= keynames(pversion,pUseOtherEnvironment).dAll_filenames
	,string								pEmailList							= Email_Notification_Lists().BuildSuccess
	,string								pRoxieEmailList					= Email_Notification_Lists().Roxie
	,string								pBuildName							= Constants().Name
	,string								pPackageName						= 'YellowPagesKeys'
	,string								pBuildMessage						= 'Base Files Finished'
  ,boolean							pShouldUpdateRoxiePage	= true
	,string							  pUseVersion							= 'qa'
	,string							  pEnvironment						= 'N'		//	'N' - nonfcra, 'F' - FCRA, 'BN' - BIP NonFCRA if updating the same dataset
  ,string               pupdateflag             = 'F'   //  'F' - Full replace, 'D' - Delta Update, 'DR' - Delta Replace
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
    ,pupdateflag
	);
