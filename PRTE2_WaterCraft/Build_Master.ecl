/********************************************************************************************************** 
	Name: 			Build_Master
	Created On: 08/10/2013
	By: 				ssivasubramanian
	Desc: 			This function is the main function that is called for building the keys for watercraft customer test. 
***********************************************************************************************************/
IMPORT PRTE,ut,_control;

EXPORT Build_Master(BOOLEAN bIsFullRebuild, STRING fileVersion = ut.GetDate, STRING filePathToUse = '') := FUNCTION
	#WORKUNIT ('NAME','Watercraft Customer Test Build');
	filePath						:= IF(filePathToUse = '',
															IF(bIsFullRebuild,
																		_LandingZoneConfig.AllData.FullPath,
																		_LandingZoneConfig.NewData.FullPath),
															filePathToUse);
																		
	appendNewToMain			:= fSpray_And_Append_New(filePath, fileVersion);
	rebuildMain					:= fSpray_And_Build_Base(filePath, fileVersion);
	
	// build the base files
	buildBase		 				:= IF(bIsFullRebuild, rebuildMain, appendNewToMain);
	buildMain						:= Build_File_Main(fileVersion);
	buildSearch					:= Build_File_Search(fileVersion);
	buildCoastGuard			:= Build_File_CoastGuard(fileVersion);
	
	// build the keys
	buildKeysAll				:= Build_Keys_All(fileVersion);
	BuildAutoKeys				:= Build_Keys_AutoKeys(fileVersion);

	sequentialSteps := SEQUENTIAL(buildBase,
															buildMain,
															buildSearch,
															buildCoastGuard,
															buildKeysAll,
															BuildAutoKeys
															): 	SUCCESS(_Common.Email_Notify(_Constants.EmailTargetSuccess,
																																					 'WaterCraft Customer Test data/key build SUCCESS',
																																					 'WaterCraft Customer Test data/key build successful on ' + ThorLib.Cluster())),
																	FAILURE(_Common.Email_Notify(_Constants.EmailTargetFail,
																																					 'WaterCraft Customer Test data/key build FAIL',
																																					 FAILMESSAGE));
	RETURN sequentialSteps;
END;