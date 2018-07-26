IMPORT tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(	
	 STRING								pversion
	,BOOLEAN							pUseOtherEnvironment 		= FALSE
	,BOOLEAN							pShouldUpdateRoxiePage	= TRUE   
	,DATASET(lay_builds)	pBuildFilenames					= QA_Data.filenames(pversion,pUseOtherEnvironment).dAll_filenames
	,STRING								pEmailList							= QA_Data.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).BuildSuccess
	,STRING								pRoxieEmailList					= QA_Data.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).Roxie
	,STRING								pBuildName							= QA_Data._Constants().Name
	,STRING								pPackageName						= 'QA_DataBase'
	,STRING								pBuildMessage						= 'Base Files Finished'
) := tools.mod_SendEmails(pversion
		                     ,pBuildFilenames					
		                     ,pEmailList							
		                     ,pRoxieEmailList					
		                     ,pBuildName							
		                     ,pPackageName			
		                     ,pBuildMessage
		                     ,pShouldUpdateRoxiePage);
