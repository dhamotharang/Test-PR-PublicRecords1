IMPORT tools, Cortera;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(	
	 STRING								pversion
	,BOOLEAN							pUseOtherEnvironment 		= FALSE
	,BOOLEAN							pShouldUpdateRoxiePage	= FALSE   
	,DATASET(lay_builds)	pBuildFilenames					= Cortera.keynames(pversion,pUseOtherEnvironment).dAll_filenames
	,STRING								pEmailList							= Cortera.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).BuildSuccess
	,STRING								pRoxieEmailList					= Cortera.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).Roxie
	,STRING								pBuildName							= Cortera._Constants().Name
	,STRING								pPackageName						= Cortera._Constants().Name
	,STRING								pBuildMessage						= 'Base Files Finished'
) := tools.mod_SendEmails(pversion
		                     ,pBuildFilenames					
		                     ,pEmailList							
		                     ,pRoxieEmailList					
		                     ,pBuildName							
		                     ,pPackageName			
		                     ,pBuildMessage
		                     ,pShouldUpdateRoxiePage
												 );