IMPORT tools, dx_Database_USA;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(	
	 STRING								pversion
	,BOOLEAN							pUseOtherEnvironment 		= FALSE
	,BOOLEAN							pShouldUpdateRoxiePage	= TRUE   
	,DATASET(lay_builds)	pBuildFilenames					= dx_Database_USA.names(pversion,pUseOtherEnvironment).dAll_filenames
	,STRING								pEmailList							= Database_USA.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).BuildSuccess
	,STRING								pRoxieEmailList					= Database_USA.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).Roxie
	,STRING								pBuildName							= Database_USA._Constants().Name
	,STRING								pPackageName						= 'DatabaseUSAKeys'
	,STRING								pBuildMessage						= 'Base Files Finished'
) := tools.mod_SendEmails(pversion
		                     ,pBuildFilenames					
		                     ,pEmailList							
		                     ,pRoxieEmailList					
		                     ,pBuildName							
		                     ,pPackageName			
		                     ,pBuildMessage
		                     ,pShouldUpdateRoxiePage
												 ,
												 ,'N');