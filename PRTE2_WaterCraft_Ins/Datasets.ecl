/********************************************************************************************************** 
	Name: 			Datasets
	Created On: 06/10/2013
	By: 				ssivasubramanian
	Desc: 			Holds all data set definitions which may be shared by more than one attribute definitions	
***********************************************************************************************************/

IMPORT ut, PRTE2_Watercraft;

EXPORT Datasets := MODULE
	EXPORT New_Slim_Subfile				:= DATASET(Files.SubFile.Input_New_Slim, Layouts.BaseInput_Slim_Common, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT New_Slim									:= DATASET(Files.SuperFile.Input_New_Slim, Layouts.BaseInput_Slim_Common, THOR);
	EXPORT All_Slim_SubFile				:= DATASET(Files.SubFile.Input_All_Slim, Layouts.BaseInput_Slim_Common,  CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));

	// All_Slim might have worked for the Alpharetta spray/despray but I'm not following what they wrote this for... I'm adding Internal just in case.
	EXPORT All_Slim									:= DATASET(Files.SuperFile.Input_All_Slim, Layouts.BaseInput_Slim_Common, THOR);
	EXPORT All_Slim_Internal			:= DATASET(Files.SuperFile.Internal_All_Slim_Name, Layouts.BaseInput_Slim_Common, THOR);
	EXPORT All_Slim_Internal_Prod	:= DATASET(Files.SuperFile.Internal_Slim_Prod, Layouts.BaseInput_Slim_Common, THOR);

	EXPORT All_Base									:= DATASET(Files.SuperFile.Base_All, PRTE2_WaterCraft_Ins.Layouts.Base, THOR);
	EXPORT Father_Base							:= DATASET(Files.SuperFile.Base_Father, PRTE2_WaterCraft_Ins.Layouts.Base, THOR);
	EXPORT All_Prod									:= DATASET(Files.SuperFile.Base_All_Prod, PRTE2_WaterCraft_Ins.Layouts.Base, THOR);
	
	// EXPORT Main										:= DATASET(Files.SuperFile.Main, Layouts.Main, THOR);
	// EXPORT Search									:= DATASET(Files.SuperFile.Search, Layouts.Search, THOR);
	// EXPORT CoastGuard						:= DATASET(Files.SuperFile.CoastGuard, Layouts.CoastGuard, THOR);
	
	SHARED PRTE2_WaterCraft_Ins.Layouts.BaseInput_Slim_Common transformToSlim(PRTE2_WaterCraft_Ins.Layouts.Base L) := TRANSFORM
			SELF := L;
			SELF := [];
	END;
		
	EXPORT Despray_DEV_DS 		:= PROJECT( All_Base, transformToSlim(LEFT) );
	EXPORT Despray_PROD_DS 	:= PROJECT( All_Prod, transformToSlim(LEFT) );
	EXPORT Despray_Father_DS 	:= PROJECT( Father_Base, transformToSlim(LEFT) );
	
	//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
	// Base search file needs to be reformated before using ut.mac_suppress_by_phonetype because does not accept the casting of did
	// This will occur in the Boca code after they append our data.
	//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
	
END;