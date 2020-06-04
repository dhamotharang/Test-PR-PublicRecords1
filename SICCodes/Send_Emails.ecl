IMPORT tools, SICCodes;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(	
	 STRING								pversion
	,BOOLEAN							pUseOtherEnvironment 		= FALSE 
	,BOOLEAN							pShouldUpdateRoxiePage	= FALSE     
	,DATASET(lay_builds)	pBuildFilenames					= SICCodes.filenames(pversion,pUseOtherEnvironment).dAll_filenames
	,STRING								pEmailList							= SICCodes.Email_Notification_Lists(pShouldUpdateRoxiePage).BuildSuccess
	,STRING								pRoxieEmailList					= ''
	,STRING								pBuildName							= SICCodes._Constants().Name
	,STRING								pPackageName						= 'SICCodes'
	,STRING								pBuildMessage						= 'SICCode Lookup File Finished'
) := tools.mod_SendEmails(pversion	
		                     ,pBuildFilenames			
		                     ,pEmailList							
		                     ,pRoxieEmailList					
		                     ,pBuildName						
		                     ,pPackageName				
		                     ,pBuildMessage
		                     ,pShouldUpdateRoxiePage
												 );
												 
												 