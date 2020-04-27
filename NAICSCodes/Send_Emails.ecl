IMPORT tools, NAICSCodes;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(	
	 STRING								pversion
	,BOOLEAN							pUseOtherEnvironment 		= FALSE 
	,BOOLEAN							pShouldUpdateRoxiePage	= FALSE     
	,DATASET(lay_builds)	pBuildFilenames					= NAICSCodes.filenames(pversion,pUseOtherEnvironment).dAll_filenames
	,STRING								pEmailList							= NAICSCodes.Email_Notification_Lists(pShouldUpdateRoxiePage).BuildSuccess
	,STRING								pRoxieEmailList					= ''
	,STRING								pBuildName							= NAICSCodes._Constants().Name
	,STRING								pPackageName						= 'NAICSCodes'
	,STRING								pBuildMessage						= 'NAICSCode Lookup File Finished'
) := tools.mod_SendEmails(pversion	
		                     ,pBuildFilenames			
		                     ,pEmailList							
		                     ,pRoxieEmailList					
		                     ,pBuildName						
		                     ,pPackageName				
		                     ,pBuildMessage
		                     ,pShouldUpdateRoxiePage
												 );
												 
												 