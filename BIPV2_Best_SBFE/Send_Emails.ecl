IMPORT	tools,	Business_Credit;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(STRING							 pVersion,
	                 BOOLEAN						 pUseOtherEnvironment 	= FALSE,
	                 BOOLEAN						 pShouldUpdateRoxiePage	= FALSE,
	                 DATASET(lay_builds) pBuildFilenames				= Keynames(pversion, pUseOtherEnvironment).dAll_filenames,
	                 STRING							 pEmailList							= Business_Credit.Email_Notification_Lists().BuildSuccess,
	                 STRING							 pRoxieEmailList				= Business_Credit.Email_Notification_Lists().Roxie,
	                 STRING							 pBuildName							= Business_Credit._Dataset().Name,
	                 STRING							 pPackageName						= Business_Credit._Dataset().Name + 'Keys',
	                 STRING							 pBuildMessage					= 'Base Files Finished') := 
	tools.mod_SendEmails(pVersion,
		                   pBuildFilenames,
		                   pEmailList,
		                   pRoxieEmailList,
		                   pBuildName,
		                   pPackageName,
		                   pBuildMessage,
		                   pShouldUpdateRoxiePage);
