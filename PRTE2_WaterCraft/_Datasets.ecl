/********************************************************************************************************** 
	Name: 			_Datasets
	Created On: 06/10/2013
	By: 				ssivasubramanian
	Desc: 			Holds all data set definitions which may be shared by more than one attribute definitions	
***********************************************************************************************************/

IMPORT ut;

EXPORT _Datasets := MODULE
	EXPORT New_Slim_Subfile						:= DATASET(_Files.SubFile.Input_New_Slim, _Layouts.BaseInput_Slim_Common, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT New_Slim										:= DATASET(_Files.SuperFile.Input_New_Slim, _Layouts.BaseInput_Slim_Common, THOR);
	EXPORT All_Slim_SubFile						:= DATASET(_Files.SubFile.Input_All_Slim, _Layouts.BaseInput_Slim_Common,  CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT All_Slim										:= DATASET(_Files.SuperFile.Input_All_Slim, _Layouts.BaseInput_Slim_Common, THOR);
	EXPORT All												:= DATASET(_Files.SuperFile.Input_All, _Layouts.Base, THOR);
	EXPORT All_Prod										:= DATASET(_Files.SuperFile.Input_All_Prod, _Layouts.Base, THOR);
	
	EXPORT Main												:= DATASET(_Files.SuperFile.Main, _Layouts.Main, THOR);
	EXPORT Search											:= DATASET(_Files.SuperFile.Search, _Layouts.Search, THOR);
	EXPORT CoastGuard									:= DATASET(_Files.SuperFile.CoastGuard, _Layouts.CoastGuard, THOR);
	
	/***************************************************
	The following are intermediate datasets that are created for building keys
	****************************************************/
	//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
	//Base search file needs to be reformated before using ut.mac_suppress_by_phonetype because does not accept the casting of did
	
					{_Layouts.Search, UNSIGNED6 did_temp} t_reformat1 (Search L) := TRANSFORM
						SELF.did_temp := (UNSIGNED6) L.did;
						SELF := L;
					END;

					New_File_Base_Search1 		:= PROJECT(Search, t_reformat1(LEFT));

					//Supress WA Cell Phones
					ut.mac_suppress_by_phonetype(New_File_Base_Search1,phone_1,st,Search_PhSuppressed1,true,did_temp);
					ut.mac_suppress_by_phonetype(Search_PhSuppressed1,phone_2,st,Search_PhSuppressed2,true,did_temp);

					//Reformat back to the standard format layout of the Base search file 
					_Layouts.Search t_reformat2 (Search_PhSuppressed2 L):= TRANSFORM
						SELF := L;
					END;
	
	EXPORT Search_Ph_Supressed 				:= PROJECT(Search_PhSuppressed2, t_reformat2(LEFT));
	
	EXPORT Search_Ph_Supressed_bdid 	:= PROJECT(Search_Ph_Supressed,
																					TRANSFORM(_Layouts.Search_Slim,
																						SELF.bdid := LEFT.bdid,
																						SELF := LEFT));
END;