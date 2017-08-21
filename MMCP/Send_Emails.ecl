IMPORT tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(STRING							 pversion,
	                 BOOLEAN						 pUseOtherEnvironment 	= FALSE,
	                 BOOLEAN						 pShouldUpdateRoxiePage	= FALSE,
	                 DATASET(lay_builds) pBuildFilenames				= Keynames(pversion, pUseOtherEnvironment).dAll_filenames,
	                 STRING							 pEmailList							= Email_Notification_Lists().BuildSuccess,
	                 STRING							 pRoxieEmailList				= Email_Notification_Lists().Roxie,
	                 STRING							 pBuildName							= _Dataset().Name,
	                 STRING							 pPackageName						= _Dataset().Name + 'Keys',
	                 STRING							 pBuildMessage					= 'Base Files Finished') := 
	tools.mod_SendEmails(pversion,
		                   pBuildFilenames,
		                   pEmailList,
		                   pRoxieEmailList,
		                   pBuildName,
		                   pPackageName,
		                   pBuildMessage,
		                   pShouldUpdateRoxiePage);
