﻿IMPORT FirstData, tools;

lay_builds := tools.Layout_FilenameVersions.builds;

EXPORT Send_Emails(
	STRING  pVersion,
	BOOLEAN pUseOtherEnvironment  = FALSE,
	BOOLEAN pShouldUpdateRoxiePage = FALSE,
	DATASET(lay_builds) pBuildFilenames = DATASET([],tools.Layout_FilenameVersions.builds),
	STRING  pEmailList = Email_Notification_Lists().BuildSuccess,
	STRING  pRoxieEmailList = Email_Notification_Lists().Roxie,
	STRING  pBuildName = _Dataset().pDatasetName,
	STRING  pPackageName = _Dataset().pDatasetName + 'Keys',
	STRING  pBuildMessage = 'Base Files Finished'
) := tools.mod_SendEmails(
	pVersion,
	pBuildFilenames,
	pEmailList,
	pRoxieEmailList,
	pBuildName,
	pPackageName,
	pBuildMessage,
	pShouldUpdateRoxiePage
);
