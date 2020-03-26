IMPORT tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

//Attributes to call are BuildSuccess, BuildFailure, BuildMessage (message in subject), BuildNote (message in body), Roxie
EXPORT Send_Emails(STRING							 pVersion,
	                 BOOLEAN						 pUseOtherEnvironment 	= FALSE,
	                 BOOLEAN						 pShouldUpdateRoxiePage	= FALSE,
	                 DATASET(lay_builds) pBuildFilenames				= DATASET([],lay_builds), //Keynames(pversion, pUseOtherEnvironment).dAll_filenames,
	                 STRING							 pEmailList							= Email_Notification_Lists().BuildSuccess,
	                 STRING							 pRoxieEmailList				= Email_Notification_Lists().Roxie,
	                 STRING							 pBuildName							= _Dataset().Name,
	                 STRING							 pPackageName						= _Dataset().Name + 'Keys',
	                 STRING							 pBuildMessage					= '') := 
	tools.mod_SendEmails(pVersion,
		                   pBuildFilenames,
		                   pEmailList,
		                   pRoxieEmailList,
		                   pBuildName,
		                   pPackageName,
		                   pBuildMessage,
		                   pShouldUpdateRoxiePage);
