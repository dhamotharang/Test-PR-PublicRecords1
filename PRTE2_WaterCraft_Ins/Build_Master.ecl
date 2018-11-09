/********************************************************************************************************** 
	Name: 			Build_Master
	Created On: 08/10/2013
	By: 				ssivasubramanian
	Desc: 			This function is the main function that is called for building the keys for watercraft customer test. 
***********************************************************************************************************/
IMPORT Std, PRTE2_Common;

EXPORT Build_Master(BOOLEAN bIsFullRebuild, STRING fileVersion = (STRING)Std.Date.Today(), STRING filePathToUse = '', BOOLEAN isProdBase=TRUE) := FUNCTION
	filePath						:= IF(filePathToUse = '',Constants.SourcePathForCSV,filePathToUse);
																		
	appendNewToMain			:= fSpray_And_Append_New(filePath, fileVersion, isProdBase);
	rebuildMain					:= fSpray_And_Build_Base(filePath, fileVersion);
	
	// build the base file
	buildBase		 				:= IF(bIsFullRebuild, rebuildMain, appendNewToMain);
	
	sequentialSteps := SEQUENTIAL(buildBase
															 ) : SUCCESS(	PRTE2_Common.Email.sendSuccess('WaterCraft Insurance CT base (not keys)','Shannon.Skumanich@lexisnexis.com')	),
																	 FAILURE(	PRTE2_Common.Email.sendFail('WaterCraft Insurance CT base (not keys)','Shannon.Skumanich@lexisnexis.com')	);																																					 
	RETURN sequentialSteps;
END;