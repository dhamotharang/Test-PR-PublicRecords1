IMPORT tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(	
	 STRING								pversion
	,BOOLEAN							pUseOtherEnvironment 		= FALSE
	,BOOLEAN							pShouldUpdateRoxiePage	= FALSE   
	,DATASET(lay_builds)	pBuildFilenames					= Equifax_Business_Data.keynames(pversion,pUseOtherEnvironment).dAll_filenames
	,STRING								pEmailList							= Equifax_Business_Data.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).BuildSuccess
	,STRING								pRoxieEmailList					= Equifax_Business_Data.Email_Notification_Lists(NOT pShouldUpdateRoxiePage).Roxie
	,STRING								pBuildName							= Equifax_Business_Data._Constants().Name
	,STRING								pPackageName						= 'Equifax_Business_DataKeys'
	,STRING								pBuildMessage						= 'Base Files Finished'
) := tools.mod_SendEmails(pversion
		                     ,pBuildFilenames					
		                     ,pEmailList							
		                     ,pRoxieEmailList					
		                     ,pBuildName							
		                     ,pPackageName			
		                     ,pBuildMessage
		                     ,pShouldUpdateRoxiePage);